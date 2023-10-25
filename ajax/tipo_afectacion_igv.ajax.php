

<?php

require_once "../modelos/tipo_afectacion_igv.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_tipo_afectacion_igv':

            $response = TipoAfectacionIgvModelo::mdlObtenerTipoAfectacionIgv($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_codigo_tipo_afectacion':

            $response = TipoAfectacionIgvModelo::mdlValidarCodigoAfectacion($_POST['codigo_tipo_afectacion']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_tipo_afectacion_igv':

            //Datos del formulario
            $formulario_tipo_afectacion_igv = [];
            parse_str($_POST['datos_tipo_afectacion_igv'], $formulario_tipo_afectacion_igv);

            $response = TipoAfectacionIgvModelo::mdlRegistrarTipoAfectacionIgv($formulario_tipo_afectacion_igv);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;
    }
}
