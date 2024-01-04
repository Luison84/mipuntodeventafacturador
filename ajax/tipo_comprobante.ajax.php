

<?php

require_once "../modelos/tipo_comprobante.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_tipo_comprobante':

            $response = TipoComprobanteModelo::mdlObtenerTipoComprobante($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_comprobante':

            //Datos del formulario
            $formulario_comprobante = [];
            parse_str($_POST['datos_comprobante'], $formulario_comprobante);

            $response = TipoComprobanteModelo::mdlRegistrarComprobante($formulario_comprobante);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_codigo_tipo_comprobante':

            $response = TipoComprobanteModelo::mdlValidarCodigoTipoComprobante($_POST['codigo_tipo_comprobante']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;
    }
}
