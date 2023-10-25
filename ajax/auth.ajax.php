<?php

require_once "../modelos/usuario.modelo.php";
session_start();

if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'login':

            if (isset($_POST["usuario"])) {

                $usuario = $_POST["usuario"];
                $password = crypt($_POST["password"], '$2a$07$azybxcags23425sdg23sdfhsd$');

                $response = UsuarioModelo::mdlIniciarSesion($usuario, $password);
                
                echo json_encode($response);
               
            }

            break;

        default:
            # code...
            break;
    }
}
