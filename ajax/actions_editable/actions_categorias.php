<?php

require_once "../../modelos/conexion.php";

if ($_POST["action"] == "edit") {

    $data = array(
        "descripcion" => $_POST["descripcion"],
        "id" => $_POST["id"]
    );

    $update = "
            update categorias
            set descripcion = :descripcion
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    echo json_encode($_POST);
}

if ($_POST["action"] == "delete") {

    $data = array(
        "id" => $_POST["id"]
    );

    $update = "
            update categorias
            set estado = case when estado = 1 then 0 else 1 end
            where id = :id
        ";


    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    echo json_encode($_POST);
}
