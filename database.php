<?php

require_once "modelos/conexion.php";

$id_arqueo_caja = $_POST["id_arqueo_caja"];

$stmt = Conexion::conectar()->prepare('SELECT ac.id,ac.descripcion,ac.monto
FROM movimientos_arqueo_caja ac
where id_arqueo_caja = :id_arqueo_caja
and id_tipo_movimiento = 1');

$stmt->bindParam(":id_arqueo_caja", $id_arqueo_caja, PDO::PARAM_STR);

$stmt->execute();

$number_filter_row = $stmt->rowCount();

$results = $stmt->fetchAll();

$data = array();

foreach ($results as $row) {
    $sub_array = array();
    $sub_array[] = $row['id'];
    $sub_array[] = $row['descripcion'];
    $sub_array[] = $row['monto'];
    $data[] = $sub_array;
}

function count_all_data()
{
    $stmt = Conexion::conectar()->prepare('SELECT *
        FROM movimientos_arqueo_caja ac
        where id_arqueo_caja = 1');
    $stmt->execute();

    return $stmt->rowCount();
}

$output = array(
    'draw' => $_POST["draw"],
    "recordsTotal" => count_all_data(),
    "recordsFiltered" => $number_filter_row,
    "data" => $data
);

echo json_encode($output);
