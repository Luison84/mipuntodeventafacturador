<?php

require_once "../modelos/perfil_modulo.modelo.php";

// class AjaxPerfilModulo{

//     public function ajaxRegistrarPerfilModulo($array_idModulos, $idPerfil, $id_modulo_inicio){

//         $registroPerfilModulo = PerfilModuloControlador::ctrRegistrarPerfilModulo($array_idModulos, $idPerfil, $id_modulo_inicio);

//         echo json_encode($registroPerfilModulo);
//     }

   
// }

// if(isset($_POST['accion']) && $_POST['accion'] == 1){ //

//     $registroPerfilModulo = new AjaxPerfilModulo;    
//     $registroPerfilModulo->ajaxRegistrarPerfilModulo($_POST['id_modulosSeleccionados'],$_POST['id_Perfil'], $_POST['id_modulo_inicio']);

// }

if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'registrar_perfil_modulo': //1
            
            $response = PerfilModuloModelo::mdlRegistrarPerfilModulo($_POST["id_modulosSeleccionados"],$_POST["id_Perfil"],$_POST["id_modulo_inicio"]);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

    }

}