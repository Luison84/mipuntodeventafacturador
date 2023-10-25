    <?php

require_once "../../modelos/conexion.php";

if ($_POST["action"] == "edit") {

    $data = array(        
        "codigo" => $_POST["codigo"],
        "descripcion" => $_POST["descripcion"],
        "letra_tributo" => $_POST["letra_tributo"],
        "codigo_tributo" => $_POST["codigo_tributo"],
        "nombre_tributo" => $_POST["nombre_tributo"],
        "tipo_tributo" => $_POST["tipo_tributo"],
        "estado" => $_POST["estado"],
        "id" => $_POST["id"]
    );

    $update = "
            update tipo_afectacion_igv
                set codigo = upper(:codigo),
                    descripcion = upper(:descripcion),
                    letra_tributo = upper(:letra_tributo),
                    codigo_tributo = upper(:codigo_tributo),
                    nombre_tributo = upper(:nombre_tributo),
                    tipo_tributo = upper(:tipo_tributo),
                    estado = :estado
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    echo json_encode($_POST);
}

