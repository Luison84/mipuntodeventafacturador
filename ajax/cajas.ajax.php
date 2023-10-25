<?php

require_once "../modelos/cajas.modelo.php";

if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {


        case 'listar_cajas_select':

            $response = CajasModelo::mdlListarCajas();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}
