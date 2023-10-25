<?php

require_once "../../modelos/conexion.php";

if ($_POST["action"] == "edit") {




    $data = array(
        "id_tipo_comprobante" => $_POST["descripcion"],
        "serie" => $_POST["serie"],
        "correlativo" => $_POST["correlativo"],
        "estado" => $_POST["estado"],
        "id" => $_POST["id"]
    );

    $stmt = Conexion::conectar()->prepare("SELECT count(1) as cantidad
                    FROM serie
                WHERE id_tipo_comprobante = :id_tipo_comprobante
                AND upper(serie) = upper(:serie)
                AND id != :id_serie");

    $stmt->bindParam(":id_tipo_comprobante", $_POST["descripcion"], PDO::PARAM_STR);
    $stmt->bindParam(":serie", $_POST["serie"], PDO::PARAM_STR);
    $stmt->bindParam(":id_serie", $_POST["id"], PDO::PARAM_STR);
    $stmt->execute();

    $existe = $stmt->fetch();

    if ($existe["cantidad"] > 0) {
        $respuesta['action'] = 'edit';
        $respuesta['tipo_msj'] = 'error';
        $respuesta['msj'] = 'El Tipo de Comprobante y Serie ya fue registrado';


        echo json_encode($respuesta);
        return;
    }


    $update = "
            UPDATE serie
            set id_tipo_comprobante = :id_tipo_comprobante, 
                serie = upper(:serie),
                correlativo = :correlativo,
                estado = :estado
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    $respuesta['action'] = 'edit';
    $respuesta['tipo_msj'] = 'success';
    $respuesta['msj'] = 'La serie se actualizó correctamente';

    echo json_encode($respuesta);
}
