<?php

require_once "../modelos/reportes.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'reporte_kardex':

            $response = ReportesModelo::mdlReporteKardex($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'reporte_kardex_x_producto':

            $response = ReportesModelo::mdlReporteKardexPorProducto($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'reporte_ventas_por_categoria':

            $response = ReportesModelo::mdlReporteVentasPorCategoria($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'reporte_ventas_por_producto':

            $response = ReportesModelo::mdlReporteVentasPorProducto($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;
    }
}
