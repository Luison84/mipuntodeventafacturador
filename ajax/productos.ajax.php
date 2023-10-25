<?php

require_once "../modelos/productos.modelo.php";

require_once "../vendor/autoload.php";

//=========================================================================================
// PETICIONES POST
//=========================================================================================
if (isset($_POST['accion'])) {

    switch ($_POST['accion']) {

        case 'listar_productos':

            $response = ProductosModelo::mdlListarProductos();
            echo json_encode($response);

            break;

        case 'listar_tipo_afectacion':

            $response = ProductosModelo::mdlListarTipoAfectacion();
            echo json_encode($response);

            break;

        case 'listar_unidad_medida':

            $response = ProductosModelo::mdlListarUnidadMedida();
            echo json_encode($response);

            break;

        case 'registrar_producto':

            $array_datos_producto = [];
            parse_str($_POST['detalle_producto'], $array_datos_producto);

            if (isset($_FILES["archivo"]["name"])) {

                $imagen["ubicacionTemporal"] =  $_FILES["archivo"]["tmp_name"][0];

                //capturamos el nombre de la imagen
                $info = new SplFileInfo($_FILES["archivo"]["name"][0]);

                //generamos un nombre aleatorio y unico para la imagen
                $imagen["nuevoNombre"] = sprintf("%s_%d.%s", uniqid(), rand(100, 999), $info->getExtension());

                $imagen["folder"] = '../vistas/assets/imagenes/productos/';

                $response = ProductosModelo::mdlRegistrarProducto($array_datos_producto, $imagen);
            } else {
                $response = ProductosModelo::mdlRegistrarProducto($array_datos_producto);
            }

            echo json_encode($response);

            break;

        case 'aumentar_disminuir_stock': //3

            if ($_POST['tipo_movimiento'] == 'aumentar_stock') {
                $response = ProductosModelo::mdlAumentarStock($_POST["codigo_producto"], $_POST["nuevoStock"]);
                echo json_encode($response);
            } else {
                $response = ProductosModelo::mdlDisminuirStock($_POST["codigo_producto"], $_POST["nuevoStock"]);
                echo json_encode($response);
            }

            break;

        case 'actualizar_producto': //4

            $array_datos_producto = [];
            parse_str($_POST['detalle_producto'], $array_datos_producto);

            if (isset($_FILES["archivo"]["name"])) {

                $imagen["ubicacionTemporal"] =  $_FILES["archivo"]["tmp_name"][0];

                //capturamos el nombre de la imagen
                $info = new SplFileInfo($_FILES["archivo"]["name"][0]);

                //generamos un nombre aleatorio y unico para la imagen
                $imagen["nuevoNombre"] = sprintf("%s_%d.%s", uniqid(), rand(100, 999), $info->getExtension());

                $imagen["folder"] = '../vistas/assets/imagenes/productos/';

                $response = ProductosModelo::mdlActualizarProducto($array_datos_producto, $imagen);
            } else {
                $response = ProductosModelo::mdlActualizarProducto($array_datos_producto);
            }

            echo json_encode($response);

            break;

        case 'eliminar_producto': //5

            $response = ProductosModelo::mdlEliminarProducto($_POST["codigo_producto"]);
            echo json_encode($response);

            break;

        case 'listar_productos_autocomplete': //6

            $response = ProductosModelo::mdlListarNombreProductos();
            echo json_encode($response);

            break;

        case 'obtener_producto_x_codigo': //7

            $response = ProductosModelo::mdlGetDatosProducto($_POST["codigo_producto"]);
            echo json_encode($response);

            break;

        case 'obtener_producto': //7

                $response = ProductosModelo::mdlObtenerProducto($_POST["codigo_producto"]);
                echo json_encode($response);
    
                break;

        case 'verificar_stock': //8

            $response = ProductosModelo::mdlVerificaStockProducto($_POST["codigo_producto"], $_POST["cantidad_a_comprar"]);
            echo json_encode($response);

            break;

        case 'carga_masiva_productos': //final

            $response = ProductosModelo::mdlCargaMasivaProductos($_FILES['fileProductos']);
            echo json_encode($response);

            break;

        case 'desactivar_producto': //8

            $response = ProductosModelo::mdlDesactivarProducto($_POST["codigo_producto"]);
            echo json_encode($response);

            break;

        case 'activar_producto': //8

            $response = ProductosModelo::mdlActivarProducto($_POST["codigo_producto"]);
            echo json_encode($response);

            break;


        case 'obtener_impuesto_tipo_operacion':

            $response = ProductosModelo::mdlObtenerImpuesto($_POST["id_tipo_afectacion"]);
            echo json_encode($response);

            break;

        case 'validar_codigo_producto': //1

            $response = ProductosModelo::mdlValidarCodigoProducto($_POST["codigo_producto"]);
            echo json_encode($response);

            break;
    }
}