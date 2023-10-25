<?php

if(isset($_GET["id_arqueo_caja"])){
    $id_arqueo_caja = $_GET["id_arqueo_caja"];
    
}

?>

<main>
    <div class="container-fluid vh-100">
        <iframe src="<?php echo "http://mipuntodeventa.facturador.com/ajax/arqueo_caja.ajax.php?accion=". "generar_ticket_arqueo" . "&id_arqueo_caja=".$id_arqueo_caja ?>" frameborder="0" height="100%" width="100%">

        </iframe>
    </div>
</main>