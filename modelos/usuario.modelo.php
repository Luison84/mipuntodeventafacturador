<?php

require_once "conexion.php";

class UsuarioModelo
{

    static public function mdlIniciarSesion($usuario, $password)
    {

        try {

            $stmt = Conexion::conectar()->prepare("select *
                                                from usuarios u 
                                                inner join perfiles p
                                                on u.id_perfil_usuario = p.id_perfil
                                                inner join perfil_modulo pm
                                                on pm.id_perfil = u.id_perfil_usuario
                                                inner join modulos m
                                                on m.id = pm.id_modulo
                                                where u.usuario = :usuario
                                                and u.clave = :password
                                                and vista_inicio = 1
                                                and u.estado = 1");

            $stmt->bindParam(":usuario", $usuario, PDO::PARAM_STR);
            $stmt->bindParam(":password", $password, PDO::PARAM_STR);

            $stmt->execute();

            $respuesta = $stmt->fetchAll(PDO::FETCH_CLASS);

            // var_dump(count($respuesta));

            if (count($respuesta) > 0) {

                $_SESSION["usuario"] = $respuesta[0];

                $respuesta["tipo_msj"] = "success";
                $respuesta["msj"] = "Usuario autenticado";
            } else {

                $respuesta["tipo_msj"] = "error";
                $respuesta["msj"] = "El usuario y/o contraseña son invalidos";
            }
        } catch (Exception $e) {
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "El usuario y/o contraseña son invalidos";
        }


        return $respuesta;
    }

    static public function mdlObtenerMenuUsuario($id_usuario)
    {

        $stmt = Conexion::conectar()->prepare("SELECT m.id,m.modulo,m.icon_menu,m.vista,pm.vista_inicio,
                                                    (select count(1) from modulos m1
                                                            where m1.padre_id = m.id
                                                            and exists (select 'x' from perfil_modulo pm1 
                                                                        where pm1.id_modulo = m1.id 
                                                                        and pm1.vista_inicio = 1
                                                                        AND pm1.id_perfil = u.id_perfil_usuario)) as abrir_arbol
                                                from usuarios u inner join perfiles p on u.id_perfil_usuario = p.id_perfil
                                                inner join perfil_modulo pm on pm.id_perfil = p.id_perfil
                                                inner join modulos m on m.id = pm.id_modulo
                                                where u.id_usuario = :id_usuario
                                                and (m.padre_id is null or m.padre_id = 0)
                                                order by m.orden");

        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_STR);

        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_CLASS);
    }

    static public function mdlObtenerSubMenuUsuario($idMenu, $id_usuario)
    {

        $stmt = Conexion::conectar()->prepare("SELECT m.id,m.modulo,m.icon_menu,m.vista,pm.vista_inicio
                                                from usuarios u inner join perfiles p on u.id_perfil_usuario = p.id_perfil
                                                inner join perfil_modulo pm on pm.id_perfil = p.id_perfil
                                                inner join modulos m on m.id = pm.id_modulo
                                                where u.id_usuario = :id_usuario
                                                and m.padre_id = :idMenu
                                                order by m.orden");

        $stmt->bindParam(":idMenu", $idMenu, PDO::PARAM_STR);
        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_STR);

        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_CLASS);
    }

    static public function mdlObtenerUsuarios($post)
    {

        $columns = [
            "id_usuario",
            "nombre_usuario",
            "apellido_usuario",
            "usuario",
            "id_perfil",
            "perfil",
            "id_caja",
            "caja",
            "estado"
        ];

        $query = " SELECT '' as detalles,
                            '' as opciones,
                            usu.id_usuario, 
                            usu.nombre_usuario, 
                            usu.apellido_usuario, 
                            usu.usuario, 
                            usu.id_perfil_usuario as id_perfil,
                            p.descripcion as perfil,
                            usu.id_caja, 
                            c.nombre_caja as caja,
                            case when usu.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM usuarios usu inner join perfiles p on usu.id_perfil_usuario = p.id_perfil
                                    inner join cajas c on c.id = usu.id_caja";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE usu.nombre_usuario like "%' . $post["search"]["value"] . '%"
                        or usu.apellido_usuario like "%' . $post["search"]["value"] . '%"
                        or usu.usuario like "%' . $post["search"]["value"] . '%"
                        or p.descripcion like "%' . $post["search"]["value"] . '%"
                        or case when usu.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY usu.id_usuario desc ';
        }

        //SE AGREGA PAGINACION
        if ($post["length"] != -1) {
            $query1 = " LIMIT " . $post["start"] . ", " . $post["length"];
        }

        $stmt = Conexion::conectar()->prepare($query);

        $stmt->execute();

        $number_filter_row = $stmt->rowCount();

        $stmt =  Conexion::conectar()->prepare($query . $query1);

        $stmt->execute();

        $results = $stmt->fetchAll(PDO::FETCH_NAMED);

        $data = array();

        foreach ($results as $row) {
            $sub_array = array();
            $sub_array[] = $row['detalles'];
            $sub_array[] = $row['opciones'];
            $sub_array[] = $row['id_usuario'];
            $sub_array[] = $row['nombre_usuario'];
            $sub_array[] = $row['apellido_usuario'];
            $sub_array[] = $row['usuario'];
            $sub_array[] = $row['id_perfil'];
            $sub_array[] = $row['perfil'];
            $sub_array[] = $row['id_caja'];
            $sub_array[] = $row['caja'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT 1
                                                FROM USUARIOS usu 
                                                inner join perfiles p on usu.id_perfil_usuario = p.id_perfil
                                                inner join cajas c on c.id = usu.id_caja");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $clientes = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $clientes;
    }

    static public function mdlRegistrarUsuario($usuario)
    {

        $dbh = Conexion::conectar();

        try {

            $password = crypt($usuario['password'], '$2a$07$azybxcags23425sdg23sdfhsd$');
            $stmt = $dbh->prepare("INSERT INTO usuarios(nombre_usuario, apellido_usuario, usuario, clave, id_perfil_usuario, id_caja, estado)
                                    VALUES(UPPER(?),UPPER(?),?,?,?,?,?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $usuario['nombres'],
                $usuario['apellidos'],
                $usuario['usuario'],
                $password,
                $usuario['perfil'],
                $usuario['caja'],
                $usuario['estado']
            ));
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el usuario correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el usuario ' . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlValidarUsuarioSistema($id_usuario, $usuario)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM usuarios usu 
                                            WHERE usuario = :usuario
                                            AND usu.id_usuario != :id_usuario");

        $stmt->bindParam(":usuario", $usuario, PDO::PARAM_STR);
        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlValidarUsuarioSistemaNuevo($usuario)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM usuarios usu 
                                            WHERE usuario = :usuario");

        $stmt->bindParam(":usuario", $usuario, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlValidarUsuarioSistemaLogin($usuario)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM usuarios usu 
                                            WHERE usuario = :usuario");

        $stmt->bindParam(":usuario", $usuario, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlActualizarUsuario($usuario)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("UPDATE   usuarios
                                     SET    nombre_usuario = upper(?),
                                            apellido_usuario = upper(?),
                                            usuario = ?,
                                            id_perfil_usuario = ?,
                                            id_caja = ?,
                                            estado = ?
                                    WHERE   id_usuario = ?");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $usuario['nombres'],
                $usuario['apellidos'],
                $usuario['usuario'],
                $usuario['perfil'],
                $usuario['caja'],
                $usuario['estado'],
                $usuario['id_usuario']
            ));
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se actualizó el cliente correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar al cliente ' . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlReestablecerPassword($usuario, $password) 
    {

        $dbh = Conexion::conectar();

        try {

            $newPassword = crypt($password, '$2a$07$azybxcags23425sdg23sdfhsd$');

            $stmt = $dbh->prepare("UPDATE   usuarios
                                     SET    clave = ?
                                    WHERE   usuario = ?");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $newPassword,
                $usuario
            ));
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'La contraseña se cambio correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al actualizar la contraseña ' . $e->getMessage();
        }

        return $respuesta;
    }
}
