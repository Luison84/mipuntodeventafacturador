<?php

require_once "conexion.php";

class TipoDocumentoModelo
{

    static public function mdlObtenerTipoDocumento($post)
    {

        $column = ["id", "descripcion", "estado"];

        $query = " SELECT td.id,
                        td.descripcion,
                        case when td.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM tipo_documento td";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE td.descripcion like "%' . $post["search"]["value"] . '%"
                        or td.id like "%' . $post["search"]["value"] . '%"
                        or case when td.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $column[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY td.id asc ';
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
            $sub_array[] = $row['descripcion'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare("SELECT 1
                                                FROM tipo_documento td");

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

    static public function mdlRegistrarTipoDocumento($tipo_documento)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO tipo_documento(id,
                                                    descripcion, 
                                                    estado)
            VALUES(?,UPPER(?),?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $tipo_documento['codigo'],
                $tipo_documento['descripcion'],
                $tipo_documento['estado']
            ));

            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el tipo de documento correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el tipo de documento ' . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlValidarCodigoTipoDocumento($codigo_tipo_documento)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM tipo_documento 
                                            WHERE id = :codigo_tipo_documento");

        $stmt->bindParam(":codigo_tipo_documento", $codigo_tipo_documento, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }
}
