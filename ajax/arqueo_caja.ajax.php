<?php

require_once "../modelos/arqueo_caja.modelo.php";
require "../vendor/autoload.php";

use Dompdf\Dompdf;


/* ===================================================================================  */
/* P O S T   P E T I C I O N E S  */
/* ===================================================================================  */

if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'listar_arqueos_por_usuario':

            $response = ArqueoCajaModelo::mdlObtenerArqueoPorUsuario();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_estado_caja_por_dia':

            $response = ArqueoCajaModelo::mdlObtenerArqueoPorDia();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_movimientos_arqueo_caja_por_usuario':

            $response = ArqueoCajaModelo::mdlObtenerMovimientosArqueoCajaPorUsuario($_POST["id_caja"]);
            echo json_encode($response, JSON_NUMERIC_CHECK);

            break;

        case 'abrir_caja':

            $response = ArqueoCajaModelo::mdlAbrirCaja($_POST['id_caja'], $_POST['monto_apertura']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'cerrar_caja':

            $response = ArqueoCajaModelo::mdlCerrarCaja(
                $_POST['id_caja'],
                $_POST['ingresos'],
                $_POST['devoluciones'],
                $_POST['gastos'],
                $_POST['monto_final'],
                $_POST['monto_real'],
                $_POST['sobrante'],
                $_POST['faltante']
            );

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'registrar_devolucion_caja':

            $response = ArqueoCajaModelo::mdlRegistrarDevolucion($_POST['id_arqueo_caja'], $_POST['descripcion_devolucion'], $_POST['monto_devolucion']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_devoluciones':
            $response = ArqueoCajaModelo::mdlObtenerDevoluciones($_POST['id_arqueo_caja'], $_POST["draw"]);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_gastos':
            $response = ArqueoCajaModelo::mdlObtenerGastos($_POST['id_arqueo_caja'], $_POST["draw"]);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'registrar_gasto_caja':

            $response = ArqueoCajaModelo::mdlRegistrarGasto($_POST['id_arqueo_caja'], $_POST['descripcion_gasto'], $_POST['monto_gasto']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'eliminar_devolucion':

            $response = ArqueoCajaModelo::mdlEliminarDevolucion($_POST['id_devolucion'], $_POST['id_caja']);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}

/* ===================================================================================  */
/* G E T   P E T I C I O N E S  */
/* ===================================================================================  */
if (isset($_GET["accion"])) {

    switch ($_GET["accion"]) {

        case 'generar_ticket_arqueo':

            $id_arqueo_caja = $_GET["id_arqueo_caja"];
            $empresa = ArqueoCajaModelo::mdlObtenerDatosEmisor(1);
            $arqueo_caja = ArqueoCajaModelo::mdlObtenerArqueoPorId($id_arqueo_caja);
            // $compra = ComprasModelo::mdlImpresionObtenerCompraPorId($_GET["id_compra"]);
            // $detalle_compra = ComprasModelo::mdlObtenerDetalleCompraPorId($_GET["id_compra"]);
            // $datos_emisor = VentasModelo::mdlObtenerDatosEmisor(1);

            ob_start();

            require "impresiones/imprimir_ticket_compra.php";

            $html = ob_get_clean();

            $dompdf = new Dompdf();


            $dompdf->loadHtml($html);
            $dompdf->set_paper(array(0, 0, 260, 1000), 'portrait');
            $dompdf->render();
            $frame = $dompdf->getTree()->get_frame(0);
            $height = $frame->get_style()->height;
            $dompdf->stream('ticket_compra.pdf', array('Attachment' => false));

            break;
    }
}
