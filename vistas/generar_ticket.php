<?php

if(isset($_GET["id_venta"])){
    $id_venta = $_GET["id_venta"];
    
}

?>

<main>
    <div class="container-fluid vh-100">
        <iframe src="<?php echo "https://tutorialesphperu.com/pos/ajax/ventas.ajax.php?accion=". "generar_ticket" . "&id_venta=".$id_venta ?>" frameborder="0" height="100%" width="100%">
        </iframe>
    </div>
</main>