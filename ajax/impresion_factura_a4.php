<?php

// echo $_SESSION["compra"]->ruc;
// $datos_emisor

?>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>    

    <link rel="stylesheet" href='<?php echo $_SERVER["DOCUMENT_ROOT"]. "/pos/vistas/assets/dist/css/bootstrap.min.css" ?>' />

</head>

<body>

    <div class="container-fluid">

        <?php
            $nombreImagen = $_SERVER["DOCUMENT_ROOT"]. "/pos/vistas/assets/dist/img/logos_empresas/65962c4715b57_330.png";
            $imagenBase64 = "data:image/png;base64," . base64_encode(file_get_contents($nombreImagen));
        ?>

        <div class="row">
            <div class="col-3">                
                    <img src="<?php echo $imagenBase64 ?>" width="80"/>
            </div>
            <div class="col-6">
                <span style="font-size: 20px;">
                    <?php echo $venta["empresa"]; ?>
                </span> <br />
                <span style="font-size: 13px;">
                    <?php echo $venta["direccion_empresa"]; ?>
                </span>
            </div>
            <div class="col-3">
                <div class="border border-dark w-100">
                    <span>RUC: 20457845121</span> <br>
                    <span>FACTURA ELECTRÓNICA</span>

                </div>
            </div>
        </div>

    </div>

</body>

</html>