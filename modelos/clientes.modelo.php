<?php

require_once "conexion.php";

class ClientesModelo
{

    static public function mdlObtenerClientes($post)
    {

        $columns = [
            "id",
            "id_tipo_documento",
            "tipo_documento",
            "nro_documento",
            "nombres_apellidos_razon_social",
            "direccion",
            "telefono",
            "estado"
        ];

        $query = " SELECT 
                    '' as opciones,
                    cli.id,
                    cli.id_tipo_documento,
                    td.descripcion as tipo_documento,
                    cli.nro_documento,
                    cli.nombres_apellidos_razon_social,
                    cli.direccion,
                    cli.telefono,
                    case when cli.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
            FROM clientes cli INNER JOIN tipo_documento td on cli.id_tipo_documento = td.id";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE td.descripcion like "%' . $post["search"]["value"] . '%"
                        or cli.nro_documento like "%' . $post["search"]["value"] . '%"
                        or cli.nombres_apellidos_razon_social like "%' . $post["search"]["value"] . '%"
                        or cli.direccion like "%' . $post["search"]["value"] . '%"
                        or cli.telefono like "%' . $post["search"]["value"] . '%"
                        or case when cli.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY cli.id desc ';
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
            $sub_array[] = $row['id_tipo_documento'];
            $sub_array[] = $row['tipo_documento'];
            $sub_array[] = $row['nro_documento'];
            $sub_array[] = $row['nombres_apellidos_razon_social'];
            $sub_array[] = $row['direccion'];
            $sub_array[] = $row['telefono'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT 
                                                        '' as opciones,
                                                        cli.id,
                                                        cli.id_tipo_documento,
                                                        td.descripcion as tipo_documento,
                                                        cli.nro_documento,
                                                        cli.nombres_apellidos_razon_social,
                                                        cli.direccion,
                                                        cli.telefono,
                                                        case when cli.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                                                FROM clientes cli INNER JOIN tipo_documento td on cli.id_tipo_documento = td.id");

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

    static public function mdlRegistrarCliente($cliente)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO clientes(id_tipo_documento, nro_documento, nombres_apellidos_razon_social, direccion, telefono, estado)
                                    VALUES(?,UPPER(?),UPPER(?),UPPER(?),UPPER(?),UPPER(?))");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $cliente['tipo_documento'],
                $cliente['nro_documento'],
                $cliente['nombre_cliente_razon_social'],
                $cliente['direccion'],
                $cliente['telefono'],
                $cliente['estado']
            ));
            $dbh->commit();

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró el cliente correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar el cliente ' . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlActualizarCliente($cliente)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("UPDATE   clientes
                                     SET    id_tipo_documento = ?,
                                            nro_documento = ?,
                                            nombres_apellidos_razon_social = ?,
                                            direccion = ?,
                                            telefono = ?,
                                            estado = ?
                                    WHERE   id = ?");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $cliente['tipo_documento'],
                $cliente['nro_documento'],
                $cliente['nombre_cliente_razon_social'],
                $cliente['direccion'],
                $cliente['telefono'],
                $cliente['estado'],
                $cliente['id_cliente']
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

    static public function mdlValidarNroDocumento($id_cliente, $tipo_documento, $nro_documento)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM clientes cli 
                                            WHERE id_tipo_documento = :tipo_documento
                                            AND cli.nro_documento = :nro_documento
                                            AND cli.id != :id_cliente");

        $stmt->bindParam(":id_cliente", $id_cliente, PDO::PARAM_STR);
        $stmt->bindParam(":tipo_documento", $tipo_documento, PDO::PARAM_STR);
        $stmt->bindParam(":nro_documento", $nro_documento, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerClientePorDocumento($tipo_documento, $nro_documento)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT id, 
                                                        id_tipo_documento, 
                                                        nro_documento, 
                                                        nombres_apellidos_razon_social as razonSocial,
                                                         direccion, 
                                                         telefono, 
                                                         estado
                                            FROM clientes cli 
                                            WHERE id_tipo_documento = :tipo_documento
                                            AND cli.nro_documento = :nro_documento");

        $stmt->bindParam(":tipo_documento", $tipo_documento, PDO::PARAM_STR);
        $stmt->bindParam(":nro_documento", $nro_documento, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    
}
