<?php

require_once "../modelos/series.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_series':

            $response = SeriesModelo::mdlObtenerSeries($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_tipo_comprobante':

            $response = SeriesModelo::mdlObtenerTipoComprobante();
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_tipo_comprobante_nota_credito':

            $response = SeriesModelo::mdlObtenerTipoComprobanteNotaCredito();
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;


        case 'obtener_motivo_nota_credito':

            $response = SeriesModelo::mdlObtenerMotivosNotaCredito();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_serie':

            //Datos del formulario
            $formulario_serie = [];
            parse_str($_POST['datos_serie'], $formulario_serie);

            $response = SeriesModelo::mdlRegistrarSerie($formulario_serie);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;
    }
}
