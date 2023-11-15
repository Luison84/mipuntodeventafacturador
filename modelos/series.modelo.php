<?php

require_once "conexion.php";

class SeriesModelo
{


    static public function mdlObtenerSeries($post)
    {

        $column = ["id", "id_tipo_comprobante", "serie", "correlativo", "estado"];

        $query = " SELECT  s.id, 
                            t.descripcion,
                            s.serie,
                            s.correlativo,
                            case when s.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM serie s inner join tipo_comprobante t on s.id_tipo_comprobante =  t.codigo";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE serie like "%' . $post["search"]["value"] . '%" 
                        or t.descripcion like "%' . $post["search"]["value"] . '%"
                        or case when s.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
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
            $sub_array[] = $row['descripcion'];
            $sub_array[] = $row['serie'];
            $sub_array[] = $row['correlativo'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare("SELECT  s.id, 
                                                        t.descripcion,
                                                        s.serie,
                                                        s.correlativo,
                                                        case when s.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                                                FROM serie s inner join tipo_comprobante t on s.id_tipo_comprobante =  t.codigo");

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

    static public function mdlObtenerTipoComprobante()
    {
        $stmt = Conexion::conectar()->prepare("select codigo,descripcion
                                            from tipo_comprobante where estado = 1 ");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerTipoComprobanteNotaCredito()
    {
        $stmt = Conexion::conectar()->prepare("select codigo,descripcion
                                            from tipo_comprobante 
                                            where estado = 1 and codigo in ('01','03')");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlRegistrarSerie($serie){

        $dbh = Conexion::conectar();

        //VALIDAR QUE NO EXISTE LA SERIE

        $stmt = Conexion::conectar()->prepare("SELECT count(1) as cantidad
                                                FROM serie
                                            WHERE id_tipo_comprobante = :id_tipo_comprobante
                                            AND serie = :serie");
        
        $stmt->bindParam(":id_tipo_comprobante", $serie['tipo_comprobante'], PDO::PARAM_STR);
        $stmt->bindParam(":serie", $serie['serie'], PDO::PARAM_STR);
        $stmt->execute();
        
        $existe = $stmt->fetch();

        if($existe["cantidad"] > 0 ){
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'El Tipo de Comprobante y Serie ya fue registrado';    

            return $respuesta;
        }

        //ELIMINAR TABLAS DEL SISTEMA
        try {

            $stmt = $dbh->prepare("INSERT INTO serie(id_tipo_comprobante, 
                                                    serie, 
                                                    correlativo, 
                                                    estado)
            VALUES(?,UPPER(?),?,?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $serie['tipo_comprobante'],
                $serie['serie'],
                $serie['correlativo'],
                $serie['estado']
            ));
            
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró la serie correctamente';        
            
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar la serie ' . $e->getMessage();    
        }

        return $respuesta;

    }
}
