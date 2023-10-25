<?php

require_once "../../modelos/conexion.php";

if ($_POST["action"] == "edit") {

    $data = array(
        "tipo_documento" => $_POST["id_tipo_documento"],
        "ruc" => $_POST["ruc"],
        "razon_social" => $_POST["razon_social"],
        "direccion" => $_POST["direccion"],
        "telefono" => $_POST["telefono"],
        "estado" => $_POST["estado"],
        "id" => $_POST["id"]
    );

    $update = "
            update proveedores
            set id_tipo_documento = :id_tipo_documento, 
                ruc = :ruc,
                razon_social = :razon_social,
                direccion = :direccion,
                telefono = :telefono,
                estado = :estado
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    echo json_encode($_POST);
}

