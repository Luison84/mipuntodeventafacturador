<?php

require_once "conexion.php";

class ModuloModelo
{

    static public function mdlObtenerModulos()
    {

        $stmt = Conexion::conectar()->prepare("select id as id,
                                                        (case when (padre_id is null or padre_id = 0)then '#' else padre_id end) as parent,
                                                        modulo as text,
                                                        vista
                                                from modulos m
                                                order by m.orden");

        $stmt->execute();

        return $stmt->fetchAll();
    }

    static public function mdlObtenerModulosPorPerfil($id_perfil)
    {

        $stmt = Conexion::conectar()->prepare("select id,
                                                    modulo,
                                                    IFNULL(case when (m.vista is null or m.vista = '') then '0' else (
                                                        (select '1' from perfil_modulo pm where pm.id_modulo = m.id and pm.id_perfil = :id_perfil)) end,0) as sel
                                                from modulos m
                                                order by m.orden");

        $stmt->bindParam(":id_perfil", $id_perfil, PDO::PARAM_INT);

        $stmt->execute();

        return $stmt->fetchAll();
    }

    /*==============================================================
    SE USA PARA EL MODULO DE MANTENIMIENTO DE MODULOS
    ==============================================================*/
    static public function mdlObtenerModulosSistema()
    {

        $stmt = Conexion::conectar()->prepare("SELECT '' as opciones,
                                                        id,
                                                        orden,
                                                        modulo,
                                                        (select modulo FROM modulos mp where mp.id = m.padre_id) as modulo_padre,
                                                        vista,
                                                        icon_menu,
                                                        date(fecha_creacion) as fecha_creacion,
                                                        date(fecha_actualizacion) as fecha_actualizacion
                                                FROM modulos m
                                                ORDER BY m.orden");

        $stmt->execute();

        return $stmt->fetchAll();
    }

    /*==============================================================
    FNC PARA REORGANIZAR LOS MODULOS DEL SISTEMA
    ==============================================================*/
    static public function mdlReorganizarModulos($modulos_ordenados)
    {

        try {

            $dbh = Conexion::conectar();
            
            foreach ($modulos_ordenados as $modulo) {

                $array_item_modulo = explode(";", $modulo);
                // var_dump($array_item_modulo);
                // return;

                $stmt = $dbh->prepare("UPDATE modulos
                                        SET padre_id = replace(?,'#',0),
                                            orden = ?
                                        WHERE id = ?"); 

                $dbh->beginTransaction();
                $stmt->execute(array(
                    $array_item_modulo[1],
                    $array_item_modulo[2],
                    $array_item_modulo[0]
                    
                ));

                $dbh->commit();
              
            }

        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al reorganizar los módulos " . $e->getMessage();
        }

        $respuesta["tipo_msj"] = "success";
        $respuesta["msj"] = "Se reorganizaron los módulos correctamente";

        return $respuesta;
    }

    /*==============================================================
    FNC PARA REGISTRAR MODULOS
    ==============================================================*/
    static public function mdlRegistrarModulo($data_modulo)
    {

        $date = date("Y-m-d H:i:s");

        $stmt = Conexion::conectar()->prepare("SELECT max(orden)
                                                FROM modulos m");

        $stmt->execute();

        $orden = $stmt->fetch();

        $orden = $orden[0] + 1;

        $stmt = Conexion::conectar()->prepare("INSERT INTO modulos( modulo,
                                                                    padre_id,
                                                                    vista,
                                                                    icon_menu,
                                                                    fecha_creacion,
                                                                    orden)
                                                            values(:modulo,
                                                                    0,
                                                                    :vista,
                                                                    :icon_menu,
                                                                    :fecha_creacion,
                                                                    :orden)");

        $stmt->bindParam(":modulo", $data_modulo["iptModulo"], PDO::PARAM_STR);

        $stmt->bindParam(":vista", $data_modulo["iptVistaModulo"], PDO::PARAM_STR);
        $stmt->bindParam(":icon_menu", $data_modulo["iptIconoModulo"], PDO::PARAM_STR);
        $stmt->bindParam(":fecha_creacion", $date, PDO::PARAM_STR);
        $stmt->bindParam(":orden", $orden, PDO::PARAM_INT);

        if ($stmt->execute()) {
            return "Se registro correctamente";
        } else {
            return "Error al registrar";
        }
    }
}
