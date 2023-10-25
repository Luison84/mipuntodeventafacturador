<?php

require_once "../../modelos/conexion.php";

if ($_POST["action"] == "edit") {

    $data = array(
        "codigo" => $_POST["codigo"],
        "descripcion" => $_POST["descripcion"],                
        "estado" => $_POST["estado"],
        "id" => $_POST["id"]
    );

    $update = "
            update tipo_comprobante
            set codigo = upper(:codigo),
                descripcion = upper(:descripcion),
                estado = :estado
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    echo json_encode($_POST);
}

