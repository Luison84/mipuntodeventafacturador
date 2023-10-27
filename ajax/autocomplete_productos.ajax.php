<?php

require_once "../modelos/conexion.php";

$dato_busqueda = $_GET['term'];

$stmt = Conexion::conectar()->prepare("SELECT 
                                            p.codigo_producto , 
                                            c.id as id_categoria,
                                            c.descripcion as categoria,
                                            p.descripcion as producto,
                                            p.imagen,
                                            p.precio_unitario_con_igv, 
                                            p.costo_unitario,
                                            stock
                                        FROM 
                                            productos p 
                                        INNER JOIN 
                                            categorias c 
                                        ON 
                                            p.id_categoria = c.id  
                                        WHERE  (p.descripcion  LIKE CONCAT('%', :dato_buscado, '%') 
                                                or p.codigo_producto  LIKE CONCAT('%', :dato_buscado, '%')
                                                or c.descripcion  LIKE CONCAT('%', :dato_buscado, '%'))
                                        AND p.stock > 0
                                        AND p.estado = 1
                                        LIMIT 0,5");

$stmt->bindParam(":dato_buscado", $dato_busqueda, PDO::PARAM_STR);
$stmt->execute();

$productos = $stmt->fetchAll();

$productData = array();

foreach ($productos as $row) {

    $codigo_producto = $row['codigo_producto'];
    $nombre_categoria = $row['categoria'];
    $descripcion_producto = $row['producto'];
    $imagen_producto = $row['imagen'];
    $precio_venta_producto = $row['precio_unitario_con_igv'];
    $stock_producto = $row['stock'];
    $precio_compra_producto = $row['costo_unitario'];
    // <a href="javascript:void(0);" class="d-flex border border-secondary border-left-0 border-right-0 border-top-0" style="width:100% !important;">
    $data["id"] = $codigo_producto;
    $data["value"] = $codigo_producto . ' - ' . $descripcion_producto;
    $data["label"] = '<div class="row mx-0 border border-secondary border-left-0 border-right-0 border-top-0">                           
                            <div class="col-6 offset-6 col-lg-12 d-flex flex-row align-items-center">
                            <img src="vistas/assets/imagenes/productos/' . $imagen_producto . '" class="border rounded-pill text-center border-secondary" style="object-fit: cover; width: 40px; height: 40px; transition: transform .2s;" alt="">
                                <div class="d-flex flex-column ml-3 text-sm">
                                    <div class="text-sm">Codigo: ' . $codigo_producto . ' - Producto: ' . $descripcion_producto . '</div> 
                                    <div class="text-sm">' . "Stock: " .  $stock_producto . ' - Costo Unit.: ' . $precio_venta_producto . '</div>
                                </div>
                            </div>
                        </div>';

    array_push($productData, $data);
}

// return $productData;

echo json_encode($productData);
