<?php

require_once "../modelos/dashboard.modelo.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST['accion'])) {

    switch ($_POST['accion']) {

        case 'datos_dashboard':

            $response = DashboardModelo::mdlGetDatosDashboard();
            echo json_encode($response);

            break;

        case 'grafico_barras':

            $response = DashboardModelo::mdlGetVentasMesActual();
            echo json_encode($response, JSON_NUMERIC_CHECK);

            break;

        case 'grafico_doughnut':

            $response = DashboardModelo::mdlVentasPorCategoria();
            echo json_encode($response, JSON_NUMERIC_CHECK);

            break;

        case 'grafico_doughnut_facturas_boletas':

            $response = DashboardModelo::mdlVentasPorTipoComprobante();
            echo json_encode($response, JSON_NUMERIC_CHECK);

            break;

        case 'productos_mas_vendidos':

            $response = DashboardModelo::mdlProductosMasVendidos();
            echo json_encode($response);

            break;

        case 'productos_poco_stock':

            $response = DashboardModelo::mdlProductosPocoStock();
            echo json_encode($response);

            break;

        default:
            # code...
            break;
    }
}
