<?php

require_once "../modelos/perfiles.modelo.php";

// class AjaxPerfiles{

//     public function ajaxObtenerPerfiles(){

//         $perfiles = PerfilControlador::ctrObtenerPerfiles();

//         echo json_encode($perfiles);
//     }

// }


// if(isset($_POST['accion']) && $_POST['accion'] == 1){

//     $perfiles = new AjaxPerfiles;    
//     $perfiles->ajaxObtenerPerfiles();

// }

if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_perfiles_asignar':

            $response = PerfilesModelo::mdlObtenerPerfilesAsignar();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_perfiles': 

            $response = PerfilesModelo::mdlObtenerPerfiles($_POST);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'listar_perfiles_select': 

                $response = PerfilesModelo::mdlObtenerListarPerfiles();
    
                echo json_encode($response, JSON_UNESCAPED_UNICODE);
    
                break;

        case 'registrar_perfil':

            //Datos del formulario
            $formulario_perfil = [];
            parse_str($_POST['datos_perfil'], $formulario_perfil);

            $response = PerfilesModelo::mdlRegistrarPerfil($formulario_perfil);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;
    }
}
