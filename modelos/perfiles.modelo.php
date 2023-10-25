<?php

require_once "conexion.php";

class PerfilesModelo{

    static public function mdlObtenerPerfilesAsignar(){

        $stmt = Conexion::conectar()->prepare("select p.id_perfil,
                                                        p.descripcion,
                                                        p.estado,
                                                        date(p.fecha_creacion) as fecha_creacion,
                                                        p.fecha_actualizacion,
                                                        ' ' as opciones
                                                from perfiles p
                                                order by p.id_perfil");

        $stmt -> execute();

        return $stmt->fetchAll();

    }

    static public function mdlObtenerListarPerfiles(){

        $stmt = Conexion::conectar()->prepare("select p.id_perfil,
                                                        p.descripcion
                                                from perfiles p
                                                where estado = 1
                                                order by p.id_perfil");

        $stmt -> execute();

        return $stmt->fetchAll();

    }
    

    static public function mdlObtenerPerfiles($post)
    {

        $column = ["id_perfil", "descripcion", "estado"];

        $query = " SELECT p.id_perfil,
                        p.descripcion,
                        case when p.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM perfiles p ";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE p.descripcion like "%' . $post["search"]["value"] . '%"
                        or p.id_perfil like "%' . $post["search"]["value"] . '%"
                        or case when p.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $column[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY p.id_perfil asc ';
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

        $results = $stmt->fetchAll();

        $data = array();

        foreach ($results as $row) {
            $sub_array = array();
            $sub_array[] = $row['id_perfil'];
            $sub_array[] = $row['descripcion'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare("SELECT 1
                                                FROM perfiles");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $output = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $output;
    }

    static public function mdlRegistrarPerfil($perfil)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO perfiles(descripcion, estado)
            VALUES(UPPER(?),?)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $perfil['descripcion'],
                $perfil['estado']
            ));

            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el perfil correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el perfil ' . $e->getMessage();
        }

        return $respuesta;
    }
}