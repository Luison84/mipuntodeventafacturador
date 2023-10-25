<?php

require_once "../../modelos/conexion.php";

if ($_POST["action"] == "edit") {

    $data = array(        
        "descripcion" => $_POST["descripcion"],                
        "estado" => $_POST["estado"],
        "id_perfil" => $_POST["id_perfil"]
    );

    $update = "
            update perfiles
            set descripcion = upper(:descripcion),
                estado = :estado
            where id_perfil = :id_perfil
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    $respuesta['action'] = "edit";
    $respuesta['tipo_msj']="success";
    $respuesta['msj']="Se actualizó el perfil correctamente";
    
    echo json_encode($respuesta);
}

