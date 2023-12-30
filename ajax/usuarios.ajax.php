

<?php

require_once "../modelos/usuario.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_usuarios':

            $response = UsuarioModelo::mdlObtenerUsuarios($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_usuario_sistema':

            $response = UsuarioModelo::mdlValidarUsuarioSistema($_POST['id_usuario'], $_POST['usuario']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_usuario_sistema_nuevo':

            $response = UsuarioModelo::mdlValidarUsuarioSistemaNuevo($_POST['usuario']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_usuario_sistema_login':

            $response = UsuarioModelo::mdlValidarUsuarioSistemaLogin($_POST['usuario']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_usuario':

            //Datos del formulario
            $formulario_usuario = [];
            parse_str($_POST['datos_usuario'], $formulario_usuario);

            $response = UsuarioModelo::mdlRegistrarUsuario($formulario_usuario);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'actualizar_usuario':

            //Datos del formulario
            $formulario_usuario = [];
            parse_str($_POST['datos_usuario'], $formulario_usuario);

            $response = UsuarioModelo::mdlActualizarUsuario($formulario_usuario);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'cambiar_password':

            $response = UsuarioModelo::mdlReestablecerPassword($_POST["usuario"], $_POST["password"]);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}
