<?php

require_once "conexion.php";

class TipoComprobanteModelo
{


    static public function mdlObtenerTipoComprobante($post)
    {

        $column = ["id", "codigo", "descripcion", "estado"];

        $query = " SELECT  tc.id, 
                            tc.codigo,
                            tc.descripcion,
                            case when tc.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM tipo_comprobante tc";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE tc.descripcion like "%' . $post["search"]["value"] . '%"
                        or tc.codigo like "%' . $post["search"]["value"] . '%"
                        or case when tc.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $column[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY id asc ';
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
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare("SELECT  tc.id, 
                                                    tc.codigo,
                                                    tc.descripcion,
                                                    case when tc.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                                            FROM tipo_comprobante tc");

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

    static public function mdlRegistrarComprobante($comprobante){

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO tipo_comprobante(codigo,
                                                    descripcion, 
                                                    estado)
            VALUES(?,UPPER(?),?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $comprobante['codigo'],
                $comprobante['descripcion'],
                $comprobante['estado']
            ));

            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el comprobante correctamente';        

        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el comprobante ' . $e->getMessage();    
        }

        return $respuesta;

    }

    static public function mdlValidarCodigoTipoComprobante($codigo_tipo_comprobante)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM tipo_comprobante 
                                            WHERE id = :codigo_tipo_comprobante");

        $stmt->bindParam(":codigo_tipo_comprobante", $codigo_tipo_comprobante, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }
}
