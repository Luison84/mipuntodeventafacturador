

<?php

require_once "../modelos/clientes.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_clientes':

            $response = ClientesModelo::mdlObtenerClientes($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'validar_nro_documento':

            $response = ClientesModelo::mdlValidarNroDocumento($_POST['id_cliente'], $_POST['tipo_documento'], $_POST['nro_documento']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_cliente':

            //Datos del formulario
            $formulario_cliente = [];
            parse_str($_POST['datos_cliente'], $formulario_cliente);

            $response = ClientesModelo::mdlRegistrarCliente($formulario_cliente);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'actualizar_cliente':

            //Datos del formulario
            $formulario_cliente = [];
            parse_str($_POST['datos_cliente'], $formulario_cliente);

            $response = ClientesModelo::mdlActualizarCliente($formulario_cliente);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}
