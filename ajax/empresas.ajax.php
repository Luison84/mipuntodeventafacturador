

<?php

require_once "../modelos/empresas.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_empresas':

            $response = EmpresasModelo::mdlObtenerEmpresas($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_datos_empresa_x_id':

            $response = EmpresasModelo::mdlObtenerEmpresaPorId($_POST["id_empresa"]);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_empresas_select':

            $response = EmpresasModelo::mdlObtenerEmpresas_Select();
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_ruc_empresa':

            $response = EmpresasModelo::mdlValidarRucEmpresa($_POST['id_empresa'], $_POST['ruc']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_empresa':

            //Datos del formulario
            $formulario_empresa = [];
            parse_str($_POST['datos_empresa'], $formulario_empresa);

            if (isset($_FILES["archivo"]["name"])) {
                $certificado["ubicacionTemporal"] =  $_FILES["archivo"]["tmp_name"][0];
                $certificado["nombre_archivo"] = $_FILES["archivo"]["name"][0];             
            }
            
            $response = EmpresasModelo::mdlRegistrarEmpresa($formulario_empresa, $certificado);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'actualizar_empresa':

            //Datos del formulario
            $formulario_empresa = [];
            parse_str($_POST['datos_empresa'], $formulario_empresa);

            $certificado = [];

            if (isset($_FILES["archivo"]["name"])) {
                $certificado["ubicacionTemporal"] =  $_FILES["archivo"]["tmp_name"][0];
                $certificado["nombre_archivo"] = $_FILES["archivo"]["name"][0];
            }

            // var_dump($certificado);
            // return;

            $response = EmpresasModelo::mdlActualizarEmpresa($formulario_empresa, $certificado);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}
