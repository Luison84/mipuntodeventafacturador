<?php

require_once "modelos/conexion.php";

if ($_POST["action"] == "edit") {

    $data = array(
        "descripcion" => $_POST["descripcion"],
        "monto" => $_POST["monto"],
        "id" => $_POST["id"]
    );

    $update = "
            update movimientos_arqueo_caja
            set descripcion = :descripcion,
            monto = :monto
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data);

    $data2 = array(
        "id_arqueo_caja" => $_GET["id_caja"]
    );


    $update = " update arqueo_caja
                    set devoluciones = (select sum(monto)  from movimientos_arqueo_caja where id_arqueo_caja = :id_arqueo_caja and id_tipo_movimiento = 1),
                        monto_final = ifnull(monto_apertura,0) + ifnull(ingresos,0) - (ifnull(devoluciones,0) + ifnull(gastos,0))
                where id = :id_arqueo_caja
                ";

    $stmt = Conexion::conectar()->prepare($update);
    $stmt->execute($data2);

    echo json_encode($_POST);
}


if ($_POST["action"] == "delete") {

    $data = array(
        "id" => $_POST["id"]
    );

    $delete = "
            DELETE FROM movimientos_arqueo_caja
            where id = :id
        ";

    $stmt = Conexion::conectar()->prepare($delete);
    $stmt->execute($data);

    $data2 = array(
        "id_arqueo_caja" => $_GET["id_caja"]
    );

    $update = " update arqueo_caja
                    set devoluciones = (select sum(monto)  from movimientos_arqueo_caja where id_arqueo_caja = :id_arqueo_caja and id_tipo_movimiento = 1),
                        monto_final = ifnull(monto_apertura,0) + ifnull(ingresos,0) - (ifnull(devoluciones,0) + ifnull(gastos,0))
                where id = :id_arqueo_caja";

    $stmt = Conexion::conectar()->prepare($update);

    $stmt->execute($data2);

    echo json_encode($_POST);
}
