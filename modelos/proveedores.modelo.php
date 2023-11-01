<?php

require_once "conexion.php";

class ProveedoresModelo
{


    static public function mdlObtenerProveedores($post)
    {

        $column = ["id", "tipo_documento", "ruc", "razon_social", "direccion", "telefono", "estado"];

        $query = " SELECT 
                            '' as opciones,
                            p.id, 
                            td.descripcion as tipo_documento, 
                            p.ruc, 
                            p.razon_social, 
                            p.direccion, 
                            p.telefono,
                            case when p.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                        FROM proveedores p inner join tipo_documento td on p.id_tipo_documento = td.id";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE p.razon_social like "%' . $post["search"]["value"] . '%"
                        or p.direccion like "%' . $post["search"]["value"] . '%"
                        or p.ruc like "%' . $post["search"]["value"] . '%"
                        or p.direccion like "%' . $post["search"]["value"] . '%"
                        or case when p.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
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

        $results = $stmt->fetchAll(PDO::FETCH_NAMED);

        $data = array();

        foreach ($results as $row) {
            $sub_array = array();
            $sub_array[] = $row['opciones'];
            $sub_array[] = $row['id'];
            $sub_array[] = $row['tipo_documento'];
            $sub_array[] = $row['ruc'];
            $sub_array[] = $row['razon_social'];
            $sub_array[] = $row['direccion'];
            $sub_array[] = $row['telefono'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT '' as detalles,
                                                    '' as opciones,
                                                    p.id, 
                                                    td.descripcion as tipo_documento, 
                                                    p.ruc, 
                                                    p.razon_social, 
                                                    p.direccion, 
                                                    p.telefono,
                                                    case when p.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                                            FROM proveedores p inner join tipo_documento td on p.id_tipo_documento = td.id");

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

    static public function mdlRegistrarProveedor($proveedor){

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO proveedores(id_tipo_documento,ruc,razon_social,direccion,telefono,estado)
                                    VALUES(?,?,UPPER(?),?,?,?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $proveedor['tipo_documento'],
                $proveedor['nro_documento'],
                $proveedor['nombre_cliente_razon_social'],
                $proveedor['direccion'],
                $proveedor['telefono'],
                $proveedor['estado']
            ));
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el proveedor correctamente';        

        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el proveedor ' . $e->getMessage();    
        }

        return $respuesta;

    }

    static public function mdlActualizarProveedor($proveedor){

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("UPDATE   proveedores
                                     SET    id_tipo_documento = ?,
                                            ruc = ?,
                                            razon_social = upper(?),
                                            direccion = upper(?),
                                            telefono = ?,
                                            estado = ?
                                    WHERE   id = ?");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $proveedor['tipo_documento'],
                $proveedor['nro_documento'],
                $proveedor['nombre_cliente_razon_social'],
                $proveedor['direccion'],
                $proveedor['telefono'],
                $proveedor['estado'],
                $proveedor['id_proveedor']
            ));
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se actualizó el proveedor correctamente';        

        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al actualizar el proveedor ' . $e->getMessage();    
        }

        return $respuesta;

    }

    static public function mdlValidarRuc($id_proveedor, $ruc)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM proveedores p 
                                            WHERE p.ruc = :ruc
                                            and id != :id_proveedor");

        $stmt->bindParam(":id_proveedor", $id_proveedor, PDO::PARAM_STR);
        $stmt->bindParam(":ruc", $ruc, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    
    }
}
