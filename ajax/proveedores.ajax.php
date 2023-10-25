

<?php

require_once "../modelos/proveedores.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_proveedores':

            $response = ProveedoresModelo::mdlObtenerProveedores($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_ruc':

            $response = ProveedoresModelo::mdlValidarRuc($_POST['id_proveedor'], $_POST['ruc']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_proveedor':

            //Datos del formulario
            $formulario_proveedor = [];
            parse_str($_POST['datos_proveedor'], $formulario_proveedor);

            $response = ProveedoresModelo::mdlRegistrarProveedor($formulario_proveedor);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'actualizar_proveedor':

            //Datos del formulario
            $formulario_proveedor = [];
            parse_str($_POST['datos_proveedor'], $formulario_proveedor);

            $response = ProveedoresModelo::mdlActualizarProveedor($formulario_proveedor);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}
