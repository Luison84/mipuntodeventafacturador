<?php

require_once "../modelos/ventas.modelo.php";
require_once "../modelos/productos.modelo.php";
require_once "apis/api_facturacion.php";



/* ===================================================================================  */
/* P O S T   P E T I C I O N E S  */
/* ===================================================================================  */
if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'obtener_nro_boleta':

            $response = VentasModelo::mdlObtenerNroBoleta();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'registrar_venta':

            //Datos del comprobante
            $formulario_venta = [];
            parse_str($_POST['datos_venta'], $formulario_venta);

            $detalle_productos = json_decode($_POST["arr_detalle_productos"]);

            if (isset($_POST["arr_cronograma"])) {
                $cronograma = json_decode($_POST["arr_cronograma"]);
            }

            // DATOS DEL EMISOR:
            $datos_emisor = VentasModelo::mdlObtenerDatosEmisor($formulario_venta["empresa_emisora"]);

            //DATOS DEL CLIENTE:
            if ($formulario_venta['tipo_documento'] == "0") {
                $formulario_venta['nro_documento'] = "99999999";
                $formulario_venta['nombre_cliente_razon_social'] = "CLIENTES VARIOS";
                $formulario_venta['direccion'] = "-";
                $formulario_venta['telefono'] = "-";
            }

            $datos_cliente = VentasModelo::mdlObtenerDatosCliente(
                $formulario_venta['tipo_documento'],
                $formulario_venta['nro_documento'],
                $formulario_venta['nombre_cliente_razon_social'],
                $formulario_venta['direccion'],
                $formulario_venta['telefono']
            );

            $count_items = 0;

            $total_operaciones_gravadas = 0.00;
            $total_operaciones_exoneradas = 0.00;
            $total_operaciones_inafectas = 0.00;
            $total_igv = 0;
            $total_icbper = 0;
            $detalle_venta = array();


            //RECORREMOS EL DETALLE DE LOS PRODUCTOS DE LA VENTA
            for ($i = 0; $i < count($detalle_productos); $i++) {

                $count_items = $count_items + 1;

                $igv_producto = 0; //EN CASO EL PRODUCTO NO TENGA IGV, SE MANTIENE CON EL VALOR = 0
                $factor_igv = 1; //EN CASO EL PRODUCTO NO TENGA IGV, SE MANTIENE CON EL FACTOR = 1

                if ($detalle_productos[$i]->id_tipo_igv == 10) { //SI ES OPERACION GRAVADA = 10
                    $igv = ProductosModelo::mdlObtenerImpuesto($detalle_productos[$i]->id_tipo_igv);
                    $porcentaje_igv = $igv['impuesto'] / 100; //0.18;
                    $factor_igv = 1 + ($igv['impuesto'] / 100);
                    $igv_producto = $detalle_productos[$i]->precio * $detalle_productos[$i]->cantidad_final * $porcentaje_igv;
                } else $porcentaje_igv = 0.0; // SI ES INAFECTA O EXONERADA

                $total_impuestos_producto = $igv_producto;

                $afectacion = VentasModelo::ObtenerTipoAfectacionIGV($detalle_productos[$i]->id_tipo_igv);
                $costo_unitario = VentasModelo::ObtenerCostoUnitarioUnidadMedida($detalle_productos[$i]->codigo_producto);

                $producto = array(
                    'item'                  => $count_items,
                    'codigo'                => $detalle_productos[$i]->codigo_producto,
                    'descripcion'           => $detalle_productos[$i]->descripcion,
                    'porcentaje_igv'        => $porcentaje_igv * 100, //Para registrar el IGV que se consideró para la venta
                    'unidad'                => $costo_unitario['id_unidad_medida'], //$detalle_productos[$i]->unidad_medida,
                    'cantidad'              => $detalle_productos[$i]->cantidad_final,
                    'costo_unitario'        => round($costo_unitario['costo_unitario'], 2),
                    'valor_unitario'        => round($detalle_productos[$i]->precio, 2),
                    'precio_unitario'       => round($detalle_productos[$i]->precio * $factor_igv, 2),
                    'valor_total'           => round($detalle_productos[$i]->precio * $detalle_productos[$i]->cantidad_final, 2),
                    'igv'                   => round($igv_producto, 2),
                    'importe_total'         => round($detalle_productos[$i]->precio * $detalle_productos[$i]->cantidad_final * $factor_igv, 2),
                    'codigos'               => array($afectacion['letra_tributo'], $afectacion['codigo'], $afectacion['codigo_tributo'], $afectacion['nombre_tributo'], $afectacion['tipo_tributo'])
                );


                array_push($detalle_venta, $producto);

                //CALCULAMOS LOS TOTALES POR TIPO DE OPERACIÓN
                if ($detalle_productos[$i]->id_tipo_igv == 10) {
                    $total_operaciones_gravadas = $total_operaciones_gravadas + $producto['valor_total'];
                }

                if ($detalle_productos[$i]->id_tipo_igv == 20) {
                    $total_operaciones_exoneradas = $total_operaciones_exoneradas + $producto['valor_total'];
                }

                if ($detalle_productos[$i]->id_tipo_igv == 30) {
                    $total_operaciones_inafectas = $total_operaciones_inafectas + $producto['valor_total'];
                }

                $total_igv = $total_igv + $igv_producto;
            }

            //OBTENER LA SERIE DEL COMPROBANTE
            $serie = VentasModelo::mdlObtenerSerie($formulario_venta['serie']);

            if ($formulario_venta["forma_pago"] == "1") {
                $forma_pago = "Contado";
            } else {
                $forma_pago = "Credito";
            }

            $monto_credito = 0;
            $cuotas = array();


            if ($forma_pago == "Credito") {

                for ($i = 0; $i < count($cronograma); $i++) {

                    $cuotas[] = array(
                        "cuota" => $cronograma[$i]->cuota,
                        "importe" => round($cronograma[$i]->importe, 2),
                        "vencimiento" => $cronograma[$i]->fecha_vencimiento
                    );
                }
            }

            //DATOS DE LA VENTA:
            $venta['id_empresa_emisora'] = $datos_emisor["id_empresa"];
            $venta['id_cliente'] = $datos_cliente["id"];
            $venta['tipo_operacion'] = $formulario_venta['tipo_operacion'];
            $venta['tipo_comprobante'] = $formulario_venta["tipo_comprobante"];
            $venta['id_serie'] = $serie['id'];
            $venta['serie'] = $serie['serie'];
            $venta['correlativo'] = intval($serie['correlativo']) + 1;
            $venta['fecha_emision'] = $formulario_venta['fecha_emision'];
            $venta['hora_emision'] = Date('h:m:s');
            $venta['fecha_vencimiento'] = Date('Y-m-d');
            $venta['moneda'] = $formulario_venta["moneda"];
            $venta['forma_pago'] = $forma_pago;
            $venta['monto_credito'] = round($total_operaciones_gravadas + $total_operaciones_exoneradas + $total_operaciones_inafectas + $total_igv, 2);
            $venta['total_impuestos'] = $total_igv;
            $venta['total_operaciones_gravadas'] = round($total_operaciones_gravadas, 2);
            $venta['total_operaciones_exoneradas'] = round($total_operaciones_exoneradas, 2);
            $venta['total_operaciones_inafectas'] = round($total_operaciones_inafectas, 2);
            $venta['total_igv'] = round($total_igv, 2);
            $venta['total_sin_impuestos'] = round($total_operaciones_gravadas + $total_operaciones_exoneradas + $total_operaciones_inafectas, 2);
            $venta['total_con_impuestos'] = round($total_operaciones_gravadas + $total_operaciones_exoneradas + $total_operaciones_inafectas + $total_igv, 2);
            $venta['total_a_pagar'] = round($total_operaciones_gravadas + $total_operaciones_exoneradas + $total_operaciones_inafectas + $total_igv, 2);
            $venta['cuotas'] = $cuotas;


            if ($formulario_venta['rb_generar_venta'] == 1) {

                /*****************************************************************************************
                R E G I S T R A R   V E N T A   Y   D E T A L L E   E N   L A   B D
                 *****************************************************************************************/
                $id_venta = VentasModelo::mdlRegistrarVenta($venta, $detalle_venta, $_POST["id_caja"]);

                if ($venta['forma_pago'] == 'Credito') {
                    $insert_cuotas = VentasModelo::mdlInsertarCuotas($id_venta, $cuotas);
                }

                /*****************************************************************************************
                G E N E R A R    C O M P R O B A N T E    E L E C T R Ó N I C O ( X M L )
                 *****************************************************************************************/

                //INSTANCIA DE APIFACTURACION
                $generar_comprobante = new ApiFacturacion();

                //RUTA Y NOMBRE DEL ARCHIVO XML:
                $path_xml = "../fe/facturas/xml/";
                $name_xml = $datos_emisor['ruc'] . '-' .
                    $venta['tipo_comprobante'] . '-' .
                    $venta['serie'] . '-' .
                    $venta['correlativo'];

                $resultado = ApiFacturacion::Genera_XML_Factura_Boleta($path_xml, $name_xml, $datos_emisor, $datos_cliente, $venta, $detalle_venta);

                /******************************************************************************************/
                // F I R M A R   X M L 
                /******************************************************************************************/
                $response_signature = ApiFacturacion::FirmarXml($path_xml, $name_xml, $datos_emisor);

                if ($response_signature["estado_firma"] == 1) {

                    /******************************************************************************************/
                    // E N V I A R   C O M P R O B A N T E   A   S U N A T
                    /*****************************************************************************************/
                    $resultado = ApiFacturacion::EnviarComprobanteElectronico($path_xml, $name_xml, $datos_emisor, '../fe/facturas/cdr/');

                    if ($resultado["error"] == 0) {

                        /*****************************************************************************************
                        A C T U A L I Z A R   V E N T A   C O N   R E S P U E S T A   D E   S U N A T
                         *****************************************************************************************/
                        $respuesta = VentasModelo::mdlActualizarRespuestaComprobante(
                            $id_venta,
                            $resultado['nombre_xml'],
                            $response_signature['hash_cpe'],
                            $resultado['codigo_error_sunat'],
                            $resultado['mensaje_respuesta_sunat'],
                            $resultado['estado_respuesta_sunat'],
                            $resultado['xml_base64'],
                            $resultado['xml_cdr_sunat_base64']
                        );

                        $resultado["id_venta"] = $id_venta;
                        $resultado['tipo_msj'] = "success";
                        $resultado['msj'] = 'Se envio a Sunat, ' . $resultado['mensaje_respuesta_sunat'];
                        echo json_encode($resultado);
                    }
                } else {
                    $respuesta["id_venta"] = $id_venta;
                    $respuesta['tipo_msj'] = "error";
                    $respuesta['msj'] = $response_signature["mensaje_error_firma"];
                    echo json_encode($respuesta);
                }
            } else {

                /*****************************************************************************************
                R E G I S T R A R   V E N T A   Y   D E T A L L E   E N   L A   B D
                 *****************************************************************************************/
                $id_venta = VentasModelo::mdlRegistrarVenta($venta, $detalle_venta, $_POST["id_caja"]);

                /*****************************************************************************************
                G E N E R A R    C O M P R O B A N T E    E L E C T R Ó N I C O
                 *****************************************************************************************/

                //INSTANCIA DE APIFACTURACION
                // $generar_comprobante = new ApiFacturacion();

                //RUTA Y NOMBRE DEL ARCHIVO XML:
                // $path_xml = "../fe/facturas/xml/";
                // $name_xml = $datos_emisor['ruc'] . '-' .
                //     $venta['tipo_comprobante'] . '-' .
                //     $venta['serie'] . '-' .
                //     $venta['correlativo'];

                // $resultado = ApiFacturacion::Genera_XML_Factura_Boleta($path_xml, $name_xml, $datos_emisor, $datos_cliente, $venta, $detalle_venta);


                /*****************************************************************************************
                F I R M A R   X M L 
                 *****************************************************************************************/
                // $response_signature = ApiFacturacion::FirmarXml($path_xml, $name_xml, $datos_emisor);


                if ($id_venta > 0) {
                    $respuesta["id_venta"] = $id_venta;
                    $respuesta['tipo_msj'] = "success";
                    $respuesta['msj'] = "La venta se guardó correctamente";
                    echo json_encode($respuesta);
                } else {
                    $respuesta["id_venta"] = $id_venta;
                    $respuesta['tipo_msj'] = "error";
                    $respuesta['msj'] = "Error al generar la venta";
                    echo json_encode($respuesta);
                }

                // if ($response_signature["estado_firma"] == 1) {
                //     $respuesta["id_venta"] = $id_venta;
                //     $respuesta['tipo_msj'] = "success";
                //     $respuesta['msj'] = "La venta se guardó correctamente";
                //     echo json_encode($respuesta);
                // } else {
                //     $respuesta["id_venta"] = $id_venta;
                //     $respuesta['tipo_msj'] = "error";
                //     $respuesta['msj'] = $response_signature["mensaje_error_firma"];
                //     echo json_encode($respuesta);
                // }
            }

            break;

        case 'registrar_nota_credito':

            //Datos del comprobante
            $datos_comprobante = [];
            parse_str($_POST['datos_comprobante'], $datos_comprobante);

            //Datos del comprobante modificado
            $datos_comprobante_modificado = [];
            parse_str($_POST['datos_comprobante_modificado'], $datos_comprobante_modificado);

            $detalle_productos = json_decode($_POST["productos"]);

            // DATOS DEL EMISOR:
            $datos_emisor = VentasModelo::mdlObtenerDatosEmisor($datos_comprobante["empresa_emisora"]);

            $count_items = 0;

            $total_operaciones_gravadas = 0.00;
            $total_operaciones_exoneradas = 0.00;
            $total_operaciones_inafectas = 0.00;
            $total_igv = 0;
            $total_icbper = 0;
            $detalle_venta = array();

            //RECORREMOS EL DETALLE DE LOS PRODUCTOS DE LA VENTA
            for ($i = 0; $i < count($detalle_productos); $i++) {

                $count_items = $count_items + 1;

                $igv_producto = 0; //EN CASO EL PRODUCTO NO TENGA IGV, SE MANTIENE CON EL VALOR = 0
                $factor_igv = 1; //EN CASO EL PRODUCTO NO TENGA IGV, SE MANTIENE CON EL FACTOR = 1

                if ($detalle_productos[$i]->id_tipo_igv == 10) { //SI ES OPERACION GRAVADA = 10
                    $igv = ProductosModelo::mdlObtenerImpuesto($detalle_productos[$i]->id_tipo_igv);
                    $porcentaje_igv = $igv['impuesto'] / 100; //0.18;
                    $factor_igv = 1 + ($igv['impuesto'] / 100);
                    $igv_producto = $detalle_productos[$i]->precio * $detalle_productos[$i]->cantidad * $porcentaje_igv;
                } else $porcentaje_igv = 0.0; // SI ES INAFECTA O EXONERADA

                $total_impuestos_producto = $igv_producto;

                $afectacion = VentasModelo::ObtenerTipoAfectacionIGV($detalle_productos[$i]->id_tipo_igv);
                $costo_unitario = VentasModelo::ObtenerCostoUnitarioUnidadMedida($detalle_productos[$i]->codigo_producto);

                $producto = array(
                    'item'                  => $count_items,
                    'codigo'                => $detalle_productos[$i]->codigo_producto,
                    'descripcion'           => $detalle_productos[$i]->descripcion,
                    'porcentaje_igv'        => $porcentaje_igv * 100, //Para registrar el IGV que se consideró para la venta
                    'unidad'                => $costo_unitario['id_unidad_medida'], //$detalle_productos[$i]->unidad_medida,
                    'cantidad'              => $detalle_productos[$i]->cantidad,
                    'valor_unitario'        => round($detalle_productos[$i]->precio, 2), // SIN IGV
                    'precio_unitario'       => round($detalle_productos[$i]->precio * $factor_igv, 2), // CON IGV
                    'valor_total'           => round($detalle_productos[$i]->precio * $detalle_productos[$i]->cantidad, 2),
                    'igv'                   => round($igv_producto, 2),
                    'importe_total'         => round($detalle_productos[$i]->precio * $detalle_productos[$i]->cantidad * $factor_igv, 2),
                    'codigos'               => array($afectacion['letra_tributo'], $afectacion['codigo'], $afectacion['codigo_tributo'], $afectacion['nombre_tributo'], $afectacion['tipo_tributo'])
                );

                array_push($detalle_venta, $producto);

                //CALCULAMOS LOS TOTALES POR TIPO DE OPERACIÓN
                if ($detalle_productos[$i]->id_tipo_igv == 10) {
                    $total_operaciones_gravadas = $total_operaciones_gravadas + $producto['valor_total'];
                }

                if ($detalle_productos[$i]->id_tipo_igv == 20) {
                    $total_operaciones_exoneradas = $total_operaciones_exoneradas + $producto['valor_total'];
                }

                if ($detalle_productos[$i]->id_tipo_igv == 30) {
                    $total_operaciones_inafectas = $total_operaciones_inafectas + $producto['valor_total'];
                }

                $total_igv = $total_igv + $producto['igv'];
            }

            //OBTENER LA SERIE DEL COMPROBANTE
            $serie = VentasModelo::mdlObtenerSerie($datos_comprobante['serie']);


            //DATOS DE LA VENTA:
            $venta['id_empresa_emisora']            = $datos_emisor["id_empresa"];
            $venta['id_cliente']                    = $datos_cliente["id"];
            $venta['tipo_operacion']                = $datos_comprobante['tipo_operacion'];
            $venta['tipo_comprobante']              = $datos_comprobante["tipo_comprobante"];
            $venta['id_serie']                      = $serie['id'];
            $venta['serie']                         = $serie['serie'];
            $venta['correlativo']                   = intval($serie['correlativo']) + 1;
            $venta['fecha_emision']                 = $datos_comprobante['fecha_emision'];
            $venta['hora_emision']                  = Date('h:m:s');
            $venta['fecha_vencimiento']             = Date('Y-m-d');
            $venta['moneda']                        = $datos_comprobante["moneda"];
            $venta['forma_pago']                    = '';
            $venta['monto_credito']                 = round($total_operaciones_gravadas + $total_operaciones_exoneradas + $total_operaciones_inafectas + $total_igv, 2);
            $venta['total_impuestos']               = $total_igv;
            $venta['total_operaciones_gravadas']    = round($total_operaciones_gravadas, 2);
            $venta['total_operaciones_exoneradas']  = round($total_operaciones_exoneradas, 2);
            $venta['total_operaciones_inafectas']   = round($total_operaciones_inafectas, 2);
            $venta['total_igv']                     = round($total_igv, 2);
            $venta['total_sin_impuestos']           = 0.00;
            $venta['total_con_impuestos']           = 0.00;
            $venta['total_a_pagar']                 = round($total_operaciones_gravadas + $total_operaciones_exoneradas + $total_operaciones_inafectas + $total_igv, 2);
            $venta['cuotas']                        = $cuotas;

            $venta['tipo_comprobante_modificado']   = $datos_comprobante_modificado['tipo_comprobante_modificado'];
            $venta['serie_modificado']              = $datos_comprobante_modificado['serie_modificado'];
            $venta['correlativo_modificado']        = $datos_comprobante_modificado['correlativo_modificado'];
            $venta['motivo_nota_credito']           = $datos_comprobante_modificado['motivo_nota_credito'];
            $venta['descripcion_nota_credito']      = $datos_comprobante_modificado['descripcion_nota_credito'];


            if ($formulario_venta['rb_generar_venta'] == 1) {

                /*****************************************************************************************
                R E G I S T R A R   V E N T A   Y   D E T A L L E   E N   L A   B D
                 *****************************************************************************************/
                var_dump($venta);
                $id_venta = VentasModelo::mdlRegistrarNotaCredito($venta, $detalle_venta);
                var_dump('id_venta : ' . $id_venta);
                return;


                /*****************************************************************************************
                    G E N E R A R    C O M P R O B A N T E    E L E C T R Ó N I C O ( X M L )
                 *****************************************************************************************/

                //INSTANCIA DE APIFACTURACION
                $generar_comprobante = new ApiFacturacion();

                //RUTA Y NOMBRE DEL ARCHIVO XML:
                $path_xml = "../fe/facturas/xml/";
                $name_xml = $datos_emisor['ruc'] . '-' .
                    $venta['tipo_comprobante'] . '-' .
                    $venta['serie'] . '-' .
                    $venta['correlativo'];

                $resultado = ApiFacturacion::Genera_XML_Nota_Credito($path_xml, $name_xml, $datos_emisor, $datos_cliente, $venta, $detalle_venta);

                /******************************************************************************************/
                // F I R M A R   X M L 
                /******************************************************************************************/
                $response_signature = ApiFacturacion::FirmarXml($path_xml, $name_xml, $datos_emisor);

                if ($response_signature["estado_firma"] == 1) {

                    /******************************************************************************************/
                    // E N V I A R   C O M P R O B A N T E   A   S U N A T
                    /*****************************************************************************************/
                    $resultado = ApiFacturacion::EnviarComprobanteElectronico($path_xml, $name_xml, $datos_emisor, '../fe/facturas/cdr/');

                    if ($resultado["error"] == 0) {

                        /*****************************************************************************************
                            A C T U A L I Z A R   V E N T A   C O N   R E S P U E S T A   D E   S U N A T
                         *****************************************************************************************/
                        $respuesta = VentasModelo::mdlActualizarRespuestaComprobante(
                            $id_venta,
                            $resultado['nombre_xml'],
                            $response_signature['hash_cpe'],
                            $resultado['codigo_error_sunat'],
                            $resultado['mensaje_respuesta_sunat'],
                            $resultado['estado_respuesta_sunat'],
                            $resultado['xml_base64'],
                            $resultado['xml_cdr_sunat_base64']
                        );

                        $resultado["id_venta"] = $id_venta;
                        $resultado['tipo_msj'] = "success";
                        $resultado['msj'] = 'Se envio a Sunat, ' . $resultado['mensaje_respuesta_sunat'];
                        echo json_encode($resultado);
                    }
                } else {
                    $respuesta["id_venta"] = $id_venta;
                    $respuesta['tipo_msj'] = "error";
                    $respuesta['msj'] = $response_signature["mensaje_error_firma"];
                    echo json_encode($respuesta);
                }
            } else {

                /*****************************************************************************************
                    R E G I S T R A R   V E N T A   Y   D E T A L L E   E N   L A   B D
                 *****************************************************************************************/
                // var_dump('iniciar registro de NC');
                var_dump($venta);
                $id_venta = VentasModelo::mdlRegistrarNotaCredito($venta, $detalle_venta);
                var_dump($id_venta);
                return;

                /*****************************************************************************************
                    G E N E R A R    C O M P R O B A N T E    E L E C T R Ó N I C O
                 *****************************************************************************************/

                //INSTANCIA DE APIFACTURACION
                // $generar_comprobante = new ApiFacturacion();

                //RUTA Y NOMBRE DEL ARCHIVO XML:
                // $path_xml = "../fe/facturas/xml/";
                // $name_xml = $datos_emisor['ruc'] . '-' .
                //     $venta['tipo_comprobante'] . '-' .
                //     $venta['serie'] . '-' .
                //     $venta['correlativo'];

                // $resultado = ApiFacturacion::Genera_XML_Factura_Boleta($path_xml, $name_xml, $datos_emisor, $datos_cliente, $venta, $detalle_venta);


                /*****************************************************************************************
                    F I R M A R   X M L 
                 *****************************************************************************************/
                // $response_signature = ApiFacturacion::FirmarXml($path_xml, $name_xml, $datos_emisor);


                if ($id_venta > 0) {
                    $respuesta["id_venta"] = $id_venta;
                    $respuesta['tipo_msj'] = "success";
                    $respuesta['msj'] = "La venta se guardó correctamente";
                    echo json_encode($respuesta);
                } else {
                    $respuesta["id_venta"] = $id_venta;
                    $respuesta['tipo_msj'] = "error";
                    $respuesta['msj'] = "Error al generar la venta";
                    echo json_encode($respuesta);
                }

                // if ($response_signature["estado_firma"] == 1) {
                //     $respuesta["id_venta"] = $id_venta;
                //     $respuesta['tipo_msj'] = "success";
                //     $respuesta['msj'] = "La venta se guardó correctamente";
                //     echo json_encode($respuesta);
                // } else {
                //     $respuesta["id_venta"] = $id_venta;
                //     $respuesta['tipo_msj'] = "error";
                //     $respuesta['msj'] = $response_signature["mensaje_error_firma"];
                //     echo json_encode($respuesta);
                // }
            }

            break;
        case 'obtener_ventas':

            $response = VentasModelo::mdlListarVentas($_POST["fechaDesde"], $_POST["fechaHasta"]);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_tipo_comprobante':

            $response = VentasModelo::mdlObtenerTipoComprobante();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_serie_comprobante':

            $response = VentasModelo::mdlObtenerSerieComprobante($_POST["id_filtro"]);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_moneda':

            $response = VentasModelo::mdlObtenerMoneda();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_tipo_documento':

            $response = VentasModelo::mdlObtenerTipoDocumento();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_forma_pago':

            $response = VentasModelo::mdlObtenerFormaPago();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_correlativo_serie':

            $response = VentasModelo::mdlObtenerCorrelativoSerie($_POST["id_serie"]);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_tipo_operacion':

            $response = VentasModelo::mdlObtenerTipoOperacion();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_listado_boletas':

            $response = VentasModelo::mdlObtenerListadoBoletas($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_listado_boletas_x_fecha':

            // var_dump($_POST["fecha_emision"]);
            // return;
            $response = VentasModelo::mdlObtenerListadoBoletasPorFecha($_POST, $_POST["fecha_emision"], $_POST["id_empresa"]);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'obtener_listado_facturas':

            $response = VentasModelo::mdlObtenerListadoFacturas($_POST);
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            break;

        case 'enviar_comprobante_sunat':

            // VENTA:
            $venta = VentasModelo::mdlObtenerVentaPorIdXml($_POST["id_venta"]);

            // DATOS DEL EMISOR:
            $datos_emisor = VentasModelo::mdlObtenerDatosEmisor($venta["id_empresa"]);

            // DATOS DEL CLIENTE:
            $datos_cliente = VentasModelo::mdlObtenerDatosClienteXml($venta["id_cliente"]);;

            // DETALLE DE LA VENTA:
            $detalle = VentasModelo::mdlObtenerDetalleVentaPorIdXml($_POST["id_venta"]);

            $monto_credito = 0;
            $cuotas = array();

            if ($venta["forma_pago"] == "Credito") {

                $cronograma = VentasModelo::mdlObtenerCuotas($_POST["id_venta"]);

                for ($i = 0; $i < count($cronograma); $i++) {

                    $cuotas[] = array(
                        "cuota" => $cronograma[$i]["cuota"],
                        "importe" => round($cronograma[$i]["importe"], 2),
                        "vencimiento" => $cronograma[$i]["fecha_vencimiento"]
                    );
                }
            }
            // $venta['monto_credito'] = $cuotas;
            $venta['cuotas'] = $cuotas;

            $detalle_venta = array();
            $count_items = 1;
            foreach ($detalle as $detalle_producto) {

                $afectacion = VentasModelo::ObtenerTipoAfectacionIGV($detalle_producto["id_tipo_afectacion_igv"]);

                $producto = array(
                    'item'                  => $count_items,
                    'codigo'                => $detalle_producto["codigo_producto"],
                    'descripcion'           => $detalle_producto["descripcion"],
                    'porcentaje_igv'        => $detalle_producto["porcentaje_igv"],
                    'unidad'                => $detalle_producto["unidad"],
                    'cantidad'              => $detalle_producto["cantidad"],
                    'costo_unitario'        => $detalle_producto["costo_unitario"],
                    'valor_unitario'        => $detalle_producto["valor_unitario"],
                    'precio_unitario'       => $detalle_producto["precio_unitario"],
                    'valor_total'           => $detalle_producto["valor_total"],
                    'igv'                   => $detalle_producto["igv"],
                    'importe_total'         => $detalle_producto["importe_total"],
                    'codigos'               => array($afectacion['letra_tributo'], $afectacion['codigo'], $afectacion['codigo_tributo'], $afectacion['nombre_tributo'], $afectacion['tipo_tributo'])
                );

                $count_items = $count_items + 1;
                array_push($detalle_venta, $producto);
            }

            /******************************************************************************************/
            // G E N E R A R    C O M P R O B A N T E    E L E C T R Ó N I C O ( X M L )
            /******************************************************************************************/

            //INSTANCIA DE APIFACTURACION
            $generar_comprobante = new ApiFacturacion();

            //RUTA Y NOMBRE DEL ARCHIVO XML:
            $path_xml = "../fe/facturas/xml/";
            $name_xml = $datos_emisor['ruc'] . '-' .
                $venta['tipo_comprobante'] . '-' .
                $venta['serie'] . '-' .
                $venta['correlativo'];

            $resultado = ApiFacturacion::Genera_XML_Factura_Boleta($path_xml, $name_xml, $datos_emisor, $datos_cliente, $venta, $detalle_venta);


            /******************************************************************************************/
            // F I R M A R   X M L 
            /******************************************************************************************/
            $response_signature = ApiFacturacion::FirmarXml($path_xml, $name_xml, $datos_emisor);

            if ($response_signature["estado_firma"] == 1) {

                /******************************************************************************************/
                // E N V I A R   C O M P R O B A N T E   A   S U N A T
                /*****************************************************************************************/
                $resultado = ApiFacturacion::EnviarComprobanteElectronico($path_xml, $name_xml, $datos_emisor, '../fe/facturas/cdr/');

                if ($resultado["error"] == 0) {

                    /******************************************************************************************/
                    // A C T U A L I Z A R   V E N T A   C O N   R E S P U E S T A   D E   S U N A T
                    /******************************************************************************************/
                    $respuesta = VentasModelo::mdlActualizarRespuestaComprobante(
                        $_POST["id_venta"],
                        $resultado['nombre_xml'],
                        $response_signature['hash_cpe'],
                        $resultado['codigo_error_sunat'],
                        $resultado['mensaje_respuesta_sunat'],
                        $resultado['estado_respuesta_sunat'],
                        $resultado['xml_base64'],
                        $resultado['xml_cdr_sunat_base64']
                    );

                    $resultado["id_venta"] =  $_POST["id_venta"];
                    $resultado['tipo_msj'] = "success";
                    $resultado['msj'] = 'Se envio a Sunat, ' . $resultado['mensaje_respuesta_sunat'];
                    echo json_encode($resultado);
                }
            } else {
                $respuesta["id_venta"] =  $_POST["id_venta"];
                $respuesta['tipo_msj'] = "error";
                $respuesta['msj'] = $response_signature["mensaje_error_firma"];
                echo json_encode($respuesta);
            }

            break;

        case 'enviar_resumen_comprobantes':

            $comprobantes = [];
            parse_str($_POST['ventas'], $comprobantes);

            //CAPTURAMOS DATOS:
            $datos_emisor = VentasModelo::mdlObtenerDatosEmisor($_POST["empresa_emisora"]);

            $fecha_emision = $_POST['fecha_emision'];

            $serie = str_replace("-", "", $fecha_emision);

            $correlativo = VentasModelo::mdlObtenerCorrelativoResumen(date('Y-m-d'), 1, 0);

            $comprobante = array(
                "tipo_comprobante"  => "RC",
                "serie"             => $serie,
                "correlativo"       => $correlativo,
                "fecha_emision"     => $fecha_emision,
                "fecha_envio"       => date('Y-m-d'),
                "resumen"           => 1,
                "baja"              => 0,
                "estado"            => 0
            );

            $resumen_comprobante = array();

            for ($i = 0; $i < count($comprobantes["id"]); $i++) {

                $boleta = VentasModelo::mdlObtenerVentaParaResumen($comprobantes["id"][$i]);

                $resumen_comprobante[] = array(
                    "item"                => $i + 1,
                    "tipo_comprobante"    => $boleta['id_tipo_comprobante'],
                    "serie"                => $boleta['serie'],
                    "correlativo"        => $boleta['correlativo'],
                    "condicion"            => $_POST['condicion'], // 1:Registrar, 2:Actualizar, 3:Dar de Baja
                    "moneda"            => $boleta['id_moneda'],
                    "importe_total"        => floatval($boleta['importe_total']),
                    "ope_gravadas"        => floatval($boleta['total_operaciones_gravadas']),
                    "ope_exoneradas"    => floatval($boleta['total_operaciones_exoneradas']),
                    "ope_inafectas"        => floatval($boleta['total_operaciones_inafectas']),
                    "igv_total"            => floatval($boleta['total_igv']),
                    "total_impuestos"    => floatval($boleta['total_igv']),
                    "id_comprobante"    => $comprobantes["id"][$i]
                );
            }

            /*****************************************************************************************
            R E G I S T R A R   R E S U M E N  -- C A B E C E R A   Y   D E T A L L E --
             *****************************************************************************************/
            $id_resumen = VentasModelo::mdlInsertarResumen($comprobante, $resumen_comprobante);


            /*****************************************************************************************
            C R E A R   X M L   D E L   R E S U M E N   D E   C O M P R O B A N T E S
             *****************************************************************************************/
            $path_xml = "../fe/facturas/xml/";
            $name_xml = $datos_emisor['ruc'] . '-' .
                $comprobante['tipo_comprobante'] . '-' .
                $comprobante['serie'] . '-' .
                $comprobante['correlativo'];

            $resultado = ApiFacturacion::CrearXMLResumenDocumentos($path_xml, $name_xml, $datos_emisor, $comprobante, $resumen_comprobante);


            /*****************************************************************************************
            E N V I A R   R E S U M E N   D E   C O M P R O B A N T E S   A   S U N A T
             *****************************************************************************************/
            $ticket = ApiFacturacion::EnviarResumenComprobantes($path_xml, $name_xml, $datos_emisor, '../fe/facturas/cdr/');


            /*****************************************************************************************
            C O N S U L T A R   T I C K E T
             *****************************************************************************************/
            $resultado = ApiFacturacion::ConsultarTicket($datos_emisor, $comprobante, $ticket, "../fe/facturas/cdr/");

            $actualizacion_resumen = VentasModelo::mdlActualizarRespuestaResumen(
                $id_resumen,
                $name_xml,
                $resultado["mensaje_sunat"],
                $resultado["codigo_sunat"],
                $ticket,
                $resultado["estado"],
                $resumen_comprobante
            );

            $resultado["tipo_msj"] =  $resultado["estado"] = 1 ? 'success' : 'error';
            $resultado["msj"] =  $resultado["mensaje_sunat"];
            $resultado["actualizacion_resumen"] =  $actualizacion_resumen;
            echo json_encode($resultado);
            break;

        case 'anular_boleta':

            //CAPTURAMOS DATOS:
            $datos_emisor = VentasModelo::mdlObtenerDatosEmisor(1);

            $fecha_emision = $_POST['fecha_emision'];

            $fecha1 = new DateTime($fecha_emision);
            $fecha2 = new DateTime(date('Y-m-d'));

            $diff = $fecha1->diff($fecha2);

            if ($diff->days > 7) {
                $respuesta["tipo_msj"] = "error";
                $respuesta["msj"] = "El comprobante no se puede anular, hasta 7días despues de la emisión";

                echo json_encode($respuesta);
                return;
            }

            $serie = str_replace("-", "", $fecha_emision);

            $correlativo = VentasModelo::mdlObtenerCorrelativoResumen(date('Y-m-d'), 1, 0);

            $comprobante = array(
                "tipo_comprobante"  => "RC",
                "serie"             => $serie,
                "correlativo"       => $correlativo,
                "fecha_emision"     => $fecha_emision,
                "fecha_envio"       => date('Y-m-d'),
                "resumen"           => 1,
                "baja"              => 0,
                "estado"            => 0
            );

            $resumen_comprobante = array();

            $boleta = VentasModelo::mdlObtenerVentaParaResumen($_POST["id_venta"]);

            $resumen_comprobante[] = array(
                "item"                => 1,
                "tipo_comprobante"    => $boleta['id_tipo_comprobante'],
                "serie"                => $boleta['serie'],
                "correlativo"        => $boleta['correlativo'],
                "condicion"            => $_POST['condicion'], // 1:Registrar, 2:Actualizar, 3:Dar de Baja
                "moneda"            => $boleta['id_moneda'],
                "importe_total"        => floatval($boleta['importe_total']),
                "ope_gravadas"        => floatval($boleta['total_operaciones_gravadas']),
                "ope_exoneradas"    => floatval($boleta['total_operaciones_exoneradas']),
                "ope_inafectas"        => floatval($boleta['total_operaciones_inafectas']),
                "igv_total"            => floatval($boleta['total_igv']),
                "total_impuestos"    => floatval($boleta['total_igv']),
                "id_comprobante"    => $_POST["id_venta"]
            );


            /*****************************************************************************************
            R E G I S T R A R   R E S U M E N  -- C A B E C E R A   Y   D E T A L L E --
             *****************************************************************************************/
            $id_resumen = VentasModelo::mdlInsertarResumen($comprobante, $resumen_comprobante);

            /*****************************************************************************************
            C R E A R   X M L   D E L   R E S U M E N   D E   C O M P R O B A N T E S
             *****************************************************************************************/
            $path_xml = "../fe/facturas/xml/";
            $name_xml = $datos_emisor['ruc'] . '-' . $comprobante['tipo_comprobante'] . '-' . $comprobante['serie'] . '-' . $comprobante['correlativo'];

            $resultado = ApiFacturacion::CrearXMLResumenDocumentos($path_xml, $name_xml, $datos_emisor, $comprobante, $resumen_comprobante);


            /*****************************************************************************************
            E N V I A R   R E S U M E N   D E   C O M P R O B A N T E S   A   S U N A T
             *****************************************************************************************/
            $ticket = ApiFacturacion::EnviarResumenComprobantes($path_xml, $name_xml, $datos_emisor, '../fe/facturas/cdr/');


            /*****************************************************************************************
            C O N S U L T A R   T I C K E T
             *****************************************************************************************/
            $resultado = ApiFacturacion::ConsultarTicket($datos_emisor, $comprobante, $ticket, "../fe/facturas/cdr/");


            // ($id_resumen, $name_xml, $mensaje_sunat, $codigo_sunat, $ticket, $estado);
            $actualizacion_resumen = VentasModelo::mdlActualizarRespuestaResumen(
                $id_resumen,
                $name_xml,
                $resultado["mensaje_sunat"],
                $resultado["codigo_sunat"],
                $ticket,
                $resultado["estado"],
                $resumen_comprobante
            );

            $resultado["tipo_msj"] =  $resultado["estado"] = 1 ? 'success' : 'error';
            $resultado["msj"] =  $resultado["mensaje_sunat"];
            $resultado["actualizacion_resumen"] =  $actualizacion_resumen;
            echo json_encode($resultado);
            break;

        case "facturas_x_cobrar":

            $response = VentasModelo::mdlObtenerFacturasPorCobrar($_POST);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case "obtener_cuotas_x_id_venta":

            $response = VentasModelo::mdlObtenerCuotasPorIdVenta($_POST["id_venta"]);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case "pagar_cuota":

            $response = VentasModelo::mdlPagarCuotas($_POST["id_venta"], $_POST["monto_a_pagar"]);

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;

        case 'obtener_detalle_venta':

            $response = VentasModelo::mdlObtenerDetalleVentaPorComprobante($_POST["id_serie"], $_POST["correlativo"]);

            echo json_encode($response, JSON_NUMERIC_CHECK);

            break;


        case "reporte_ventas":

            $response = VentasModelo::mdlReporteVentas();

            echo json_encode($response, JSON_UNESCAPED_UNICODE);

            break;
    }
}

/* ===================================================================================  */
/* G E T   P E T I C I O N E S  */
/* ===================================================================================  */
if (isset($_GET["accion"])) {

    switch ($_GET["accion"]) {

        case 'generar_ticket':

            require('../vistas/assets/plugins/fpdf/fpdf.php');
            require("../phpqrcode/qrlib.php");

            $venta = VentasModelo::mdlObtenerVentaPorId($_GET["id_venta"]);

            if ($venta["forma_pago"] == "Credito") {
                $cuotas = VentasModelo::mdlObtenerCuotas($_GET["id_venta"]);
            }

            $pdf = new FPDF($orientation = 'P', $unit = 'mm', array(80, 1000));
            $pdf->AddPage();
            $pdf->setMargins(5, 5, 5);


            //NOMBRE DE LA EMPRESA
            $pdf->SetFont('Arial', 'B', 12);
            $pdf->Cell(60, 10, 'TUTORIALES PHPERU', 0, 0, 'C');

            //LOGO
            $pdf->Image('../vistas/assets/dist/img/mi_logo_tutorialesphperu.png', 30, 18, 20, 20, 'PNG');

            $pdf->Ln(25);

            //EMPRESA
            $pdf->SetFont('Arial', '', 8);
            $pdf->Cell(70, 15, strlen(utf8_decode($venta["empresa"])) > 30 ? substr(utf8_decode($venta["empresa"]), 0, 30) . "..." : utf8_decode($venta["empresa"]), 0, 0, 'C');

            //DIRECCION
            $pdf->Ln(5);
            $pdf->SetFont('Arial', '', 8);
            $pdf->Cell(70, 15, $venta["direccion_empresa"], 0, 0, 'C');

            //UBIGEO
            $pdf->Ln(5);
            $pdf->SetFont('Arial', '', 8);
            $pdf->Cell(70, 15, $venta["ubigeo"], 0, 0, 'C');


            //RUC
            $pdf->Ln(5);
            $pdf->SetFont('Arial', 'B', 8);
            $pdf->Cell(70, 15, utf8_decode("RUC: " . $venta["ruc"]), 0, 0, 'C');

            //BOLETA DE VENTA ELECTRONICA
            $pdf->Ln(15);
            $pdf->SetFont('Arial', '', 8);
            if ($venta["id_tipo_comprobante"] == "01") {
                $pdf->Cell(70, 6, utf8_decode("FACTURA DE VENTA ELECTRÓNICA"), 0, 0, 'C');
            } else {
                $pdf->Cell(70, 6, utf8_decode("BOLETA DE VENTA ELECTRÓNICA"), 0, 0, 'C');
            }

            $pdf->Ln(5);
            $pdf->Cell(70, 6, utf8_decode("SERIE: " . $venta["serie"]) . " " . utf8_decode("CORRELATIVO: " . $venta["correlativo"]), 0, 0, 'C');
            $pdf->Ln(5);
            $pdf->Cell(70, 6, utf8_decode("FECHA EMISIÓN: " . $venta["fecha_emision"] . "  " . $venta["hora_emision"]), 0, 0, 'C');
            $pdf->Ln(5);
            $pdf->Cell(70, 6, strtoupper(utf8_decode("CAJERO: " . $venta["nombre_cajero"] . " " . $venta["apellido_cajero"])), 0, 0, 'C');
            $pdf->Ln(5);
            $pdf->Cell(70, 6, strtoupper(utf8_decode("CLIENTE: " . $venta["nombres_apellidos_razon_social"])), 0, 0, 'C');
            $pdf->Ln(5);
            $pdf->Cell(70, 6, strtoupper(utf8_decode("NRO. DOC.: " . $venta["nro_documento"])), 0, 0, 'C');


            $pdf->Ln(10);

            //INICIO DETALLE DE LA VENTA
            $pdf->Cell(70, 5, utf8_decode("-------------------------------------------------------------------------"), 0, 0, 'C');
            $pdf->Ln(5);
            $pdf->SetFont('Arial', 'B', 6);
            $pdf->Cell(13, 4, utf8_decode("CODIGO"), 0, 0, 'L');
            $pdf->Cell(30, 4, utf8_decode("DESCRIPCIÓN"), 0, 0, 'L');
            $pdf->Cell(8, 4, utf8_decode("CANT."), 0, 0, 'L');
            $pdf->Cell(10, 4, utf8_decode("P. UNIT"), 0, 0, 'L');
            $pdf->Cell(8, 4, utf8_decode("IMP."), 0, 0, 'C');

            $detalle_venta = VentasModelo::mdlObtenerDetalleVentaPorId($_GET["id_venta"]);

            foreach ($detalle_venta as $detalle) {
                $pdf->Ln(5);
                $pdf->SetFont('Arial', '', 6);
                $pdf->Cell(13, 4, strlen(utf8_decode($detalle["codigo_producto"])) > 6 ? substr(utf8_decode($detalle["codigo_producto"]), 0, 6) . "..." : utf8_decode($detalle["codigo_producto"]), 0, 0, 'L');
                $pdf->Cell(30, 4, strtoupper(strlen(utf8_decode($detalle["descripcion"])) > 25 ? substr(utf8_decode($detalle["descripcion"]), 0, 25) . "..." : utf8_decode($detalle["descripcion"])), 0, 0, 'L');
                $pdf->Cell(8, 4, $detalle["cantidad"], 0, 0, 'C');
                $pdf->Cell(10, 4, $detalle["precio_unitario"], 0, 0, 'C');
                $pdf->Cell(8, 4, $detalle["importe_total"], 0, 0, 'R');
            }

            $pdf->Ln(5);
            $pdf->Cell(70, 5, utf8_decode("--------------------------------------------------------------------------------------------------"), 0, 0, 'C');
            $pdf->Ln();
            //FIN DETALLE DE LA VENTA

            //INICIO RESUMEN IMPORTES
            $pdf->SetFont('Arial', 'B', 6);
            $pdf->Cell(50, 4, "OP. GRAVADA:", 0, 0, 'R');
            $pdf->Cell(20, 4, $venta["simbolo"] . " " . $venta["ope_gravada"], 0, 0, 'R');
            $pdf->Ln();

            $pdf->Cell(50, 4, "OP. INAFECTA:", 0, 0, 'R');
            $pdf->Cell(20, 4, $venta["simbolo"] . " " . $venta["ope_inafecta"], 0, 0, 'R');
            $pdf->Ln();

            $pdf->Cell(50, 4, "OP. EXONERADA:", 0, 0, 'R');
            $pdf->Cell(20, 4, $venta["simbolo"] . " " . $venta["ope_exonerada"], 0, 0, 'R');
            $pdf->Ln();

            $pdf->Cell(50, 4, "I.G.V.:", 0, 0, 'R');
            $pdf->Cell(20, 4, $venta["simbolo"] . " " . $venta["total_igv"], 0, 0, 'R');
            $pdf->Ln();

            $pdf->Cell(50, 4, "IMPORTE TOTAL:", 0, 0, 'R');
            $pdf->Cell(20, 4, $venta["simbolo"] . " " . $venta["importe_total"], 0, 0, 'R');
            $pdf->Ln(10);
            //FIN RESUMEN IMPORTES


            //FORMA DE PAGO
            $pdf->Cell(20, 4, strtoupper("Forma de Pago: "), 0, 0, 'L');
            $pdf->Cell(40, 4, strtoupper($venta["forma_pago"]), 0, 0, 'L');

            //CALENDARIO DE PAGOS
            if ($venta["forma_pago"] == "Credito") {

                $pdf->Ln(5);
                $pdf->SetFont('Arial', '', 6);
                $pdf->Cell(10, 4, "Cuota", 0, 0, 'L');
                $pdf->Cell(20, 4, "Fecha Vencimiento", 0, 0, 'L');
                $pdf->Cell(20, 4, "Importe", 0, 0, 'C');
                $pdf->Cell(20, 4, "", 0, 0, 'C');

                for ($i = 0; $i < count($cuotas); $i++) {

                    $pdf->Ln(5);
                    $pdf->SetFont('Arial', '', 6);

                    $pdf->Cell(10, 4, $cuotas[$i]["cuota"], 0, 0, 'L');
                    $pdf->Cell(20, 4, $cuotas[$i]["fecha_vencimiento"], 0, 0, 'L');
                    $pdf->Cell(20, 4, $cuotas[$i]["importe"], 0, 0, 'C');
                    $pdf->Cell(20, 4, "", 0, 0, 'L');
                }
            }

            $pdf->Ln(30);
            $pdf->SetFont('Arial', '', 6);
            //QR
            /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE | NUMERO DE DOCUMENTO ADQUIRENTE |*/
            $text_qr = $venta["ruc"] . " | " . $venta["id_tipo_comprobante"] . " | " . $venta["serie"] . " | " . $venta["correlativo"] . " | " . $venta["total_igv"] . " | " . $venta["importe_total"] . " | " . $venta["fecha_emision"] . " | " . $venta["id_tipo_documento"] . " | " . $venta["nro_documento"];
            $ruta_qr = "../fe/qr/" . "prueba_qr" . '.png';

            QRcode::png($text_qr, $ruta_qr, 'Q', 15, 0);

            $pdf->Image($ruta_qr, 28, $pdf->GetY() - 20, 25, 25);

            $pdf->Ln(5);

            //HASH SIGNATURE
            $pdf->Cell(70, 4, $venta["hash_signature"], 0, 0, 'C');
            $pdf->Ln(10);

            //TEXTO
            $pdf->SetFillColor(255, 255, 255);
            $pdf->Cell(70, 4, utf8_decode("Representación impresa de la Boleta de Venta Electrónica, esta puede"), 0, 0, 'L');
            $pdf->Ln();
            $pdf->Cell(70, 4, utf8_decode("ser consultada en: www.tutorialesphperu.com"), 0, 0, 'L');

            $pdf->Ln(10);
            $pdf->SetFont('Arial', 'B', 8);
            $pdf->Cell(70, 4, "GRACIAS POR TU COMPRA", 0, 0, 'C');

            // $detalle_venta = VentasModelo::mdlObtenerDetalleVenta($_GET["nro_boleta"]);

            $pdf->SetFont('Arial', '', 8);



            $pdf->Output();

            break;
    }
}
