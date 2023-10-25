<?php

require_once "conexion.php";

class TipoAfectacionIgvModelo
{

    static public function mdlObtenerTipoAfectacionIgv($post)
    {

        $column = ["id", "descripcion", "letra_tributo","codigo_tributo","nombre_tributo","tipo_tributo","estado"];

        $query = " SELECT  ta.id, 
                            ta.codigo, 
                            ta.descripcion, 
                            ta.letra_tributo, 
                            ta.codigo_tributo, 
                            ta.nombre_tributo, 
                            ta.tipo_tributo,
                        case when ta.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM tipo_afectacion_igv ta";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE ta.descripcion like "%' . $post["search"]["value"] . '%"
                            or ta.codigo like "%' . $post["search"]["value"] . '%"
                            or ta.nombre_tributo like "%' . $post["search"]["value"] . '%"
                            or ta.tipo_tributo like "%' . $post["search"]["value"] . '%"
                            or case when ta.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $column[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY ta.id asc ';
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
            $sub_array[] = $row['id'];
            $sub_array[] = $row['codigo'];
            $sub_array[] = $row['descripcion'];
            $sub_array[] = $row['letra_tributo'];
            $sub_array[] = $row['codigo_tributo'];
            $sub_array[] = $row['nombre_tributo'];
            $sub_array[] = $row['tipo_tributo'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare("SELECT 1
                                                FROM tipo_afectacion_igv ta");

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

    static public function mdlRegistrarTipoAfectacionIgv($tipo_afectacion_igv){

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO tipo_afectacion_igv(codigo,descripcion,letra_tributo,codigo_tributo,nombre_tributo,tipo_tributo,estado)
            VALUES(?,UPPER(?),UPPER(?),UPPER(?),UPPER(?),UPPER(?),?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $tipo_afectacion_igv['codigo'],
                $tipo_afectacion_igv['descripcion'],
                $tipo_afectacion_igv['letra_tributo'],
                $tipo_afectacion_igv['codigo_tributo'],
                $tipo_afectacion_igv['nombre_tributo'],
                $tipo_afectacion_igv['tipo_tributo'],
                $tipo_afectacion_igv['estado']
            ));

            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el tipo de afectación correctamente';        

        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el tipo de afectación ' . $e->getMessage();    
        }

        return $respuesta;

    }

    static public function mdlValidarCodigoAfectacion($codigo_afectacion)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM tipo_afectacion_igv 
                                            WHERE codigo = :codigo_afectacion");

        $stmt->bindParam(":codigo_afectacion", $codigo_afectacion, PDO::PARAM_STR);
        
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }
}
