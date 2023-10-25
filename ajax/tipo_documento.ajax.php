

<?php

require_once "../modelos/tipo_documento.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_tipo_documento':

            $response = TipoDocumentoModelo::mdlObtenerTipoDocumento($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_codigo_tipo_documento':

            $response = TipoDocumentoModelo::mdlValidarCodigoTipoDocumento($_POST['codigo_tipo_documento']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_tipo_documento':

            //Datos del formulario
            $formulario_tipo_documento = [];
            parse_str($_POST['datos_tipo_documento'], $formulario_tipo_documento);

            $response = TipoDocumentoModelo::mdlRegistrarTipoDocumento($formulario_tipo_documento);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;
    }
}
