

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

            if (isset($_FILES["archivo_imagen"]["name"])) {

                $imagen_logo["ubicacionTemporal"] =  $_FILES["archivo_imagen"]["tmp_name"][0];

                //capturamos el nombre de la imagen
                $info = new SplFileInfo($_FILES["archivo_imagen"]["name"][0]);

                //generamos un nombre aleatorio y unico para la imagen
                $imagen_logo["nuevoNombre"] = sprintf("%s_%d.%s", uniqid(), rand(100, 999), $info->getExtension());

                $imagen_logo["folder"] = '../vistas/assets/dist/img/logos_empresas/';

            }
            
            $response = EmpresasModelo::mdlRegistrarEmpresa($formulario_empresa, $certificado, $imagen_logo);
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
