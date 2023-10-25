<?php

require_once "conexion.php";

use PhpOffice\PhpSpreadsheet\IOFactory;


class ProductosModelo
{

    /*===================================================================
    REALIZAR LA CARGA MASIVA DE PRODUCTOS MEDIANTE ARCHIVO EXCEL
    ====================================================================*/
    static public function mdlCargaMasivaProductos($fileProductos)
    {

        $nombreArchivo = $fileProductos['tmp_name'];

        $documento = IOFactory::load($nombreArchivo);

        //CATEGORIAS
        $hojaCategorias = $documento->getSheetByName("Categorias");
        $numeroFilasCategorias = $hojaCategorias->getHighestDataRow();

        //TIPO AFECTACION
        $hojaTipoAfectacion = $documento->getSheetByName("Tipo_Afectacion");
        $numeroFilasTipoAfectacion = $hojaTipoAfectacion->getHighestDataRow();

        //UNIDAD MEDIDA
        $hojaUnidadMedida = $documento->getSheetByName("Unidad_Medida");
        $numeroFilasUnidadMedida = $hojaUnidadMedida->getHighestDataRow();

        //PRODUCTOS
        $hojaProductos = $documento->getSheetByName("Productos");
        $numeroFilasProductos = $hojaProductos->getHighestDataRow();

        $categoriasRegistradas = 0;
        $productosRegistrados = 0;


        $dbh = Conexion::conectar();

        /*=====================================================================================
        ELIMINAR TABLAS DEL SISTEMA (venta - detalle_venta - kardex - categorias - 
                                    tipo_afectacion_igv - codigo_unidad_medida - productos)
        =====================================================================================*/
        try {
            $stmt = $dbh->prepare("call prc_truncate_all_tables()");
            $stmt->execute();
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al eliminar las tablas del sistema" . $e->getMessage();
            return $respuesta;
        }


        /*=====================================================================================
        CICLO FOR PARA REGISTROS DE CATEGORIAS
        =====================================================================================*/
        for ($i = 2; $i <= $numeroFilasCategorias; $i++) {

            $categoria = $hojaCategorias->getCellByColumnAndRow(1, $i);

            if (!empty($categoria)) {

                try {
                    $stmt = $dbh->prepare("INSERT INTO categorias(descripcion)
                                                        values(?);");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        $categoria,
                    ));

                    $dbh->commit();
                } catch (Exception $e) {
                    $dbh->rollBack();
                    $respuesta["tipo_msj"] = "error";
                    $respuesta["msj"] = "Error al cargar las categorías al sistema " . $e->getMessage();
                    return $respuesta;
                }
            }
        }

        /*=====================================================================================
        CICLO FOR PARA TIPOS DE AFECTACION
        =====================================================================================*/
        for ($i = 2; $i <= $numeroFilasTipoAfectacion; $i++) {

            $codigo = $hojaTipoAfectacion->getCellByColumnAndRow(1, $i);
            $tipo_afectacion = $hojaTipoAfectacion->getCellByColumnAndRow(2, $i);
            $letra_tributo = $hojaTipoAfectacion->getCellByColumnAndRow(3, $i);
            $codigo_tributo = $hojaTipoAfectacion->getCellByColumnAndRow(4, $i);
            $nombre_tributo = $hojaTipoAfectacion->getCellByColumnAndRow(5, $i);
            $tipo_tributo = $hojaTipoAfectacion->getCellByColumnAndRow(6, $i);

            if (!empty($codigo)) {

                try {
                    $stmt = $dbh->prepare("INSERT INTO tipo_afectacion_igv(codigo, 
                                                                            descripcion, 
                                                                            letra_tributo, 
                                                                            codigo_tributo, 
                                                                            nombre_tributo, 
                                                                            tipo_tributo)
                                                        values(?,upper(?),upper(?),upper(?),upper(?),upper(?));");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        $codigo,
                        $tipo_afectacion,
                        $letra_tributo,
                        $codigo_tributo,
                        $nombre_tributo,
                        $tipo_tributo
                    ));

                    $dbh->commit();
                } catch (Exception $e) {
                    $dbh->rollBack();
                    $respuesta["tipo_msj"] = "error";
                    $respuesta["msj"] = "Error al cargar los tipos de afectacion al sistema " . $e->getMessage();
                    return $respuesta;
                }
            }
        }

        /*=====================================================================================
        CICLO FOR PARA UNIDADES DE MEDIDA
        =====================================================================================*/
        for ($i = 2; $i <= $numeroFilasUnidadMedida; $i++) {

            $id = $hojaUnidadMedida->getCellByColumnAndRow(1, $i);
            $unidad_medida = $hojaUnidadMedida->getCellByColumnAndRow(2, $i);

            if (!empty($id)) {

                try {
                    $stmt = $dbh->prepare("INSERT INTO codigo_unidad_medida(id, descripcion)
                                                        values(?,?);");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        $id,
                        $unidad_medida
                    ));

                    $dbh->commit();
                } catch (Exception $e) {
                    $dbh->rollBack();
                    $respuesta["tipo_msj"] = "error";
                    $respuesta["msj"] = "Error al cargar las unidades de medida " . $e->getMessage();
                    return $respuesta;
                }
            }
        }

        /*=====================================================================================
        CICLO FOR PARA REGISTROS DE PRODUCTOS
        =====================================================================================*/
        for ($i = 2; $i <= $numeroFilasProductos; $i++) {

            $codigo_producto = $hojaProductos->getCell("A" . $i);
            $id_categoria = ProductosModelo::mdlBuscarIdCategoria($hojaProductos->getCell("B" . $i));
            $descripcion = $hojaProductos->getCell("C" . $i);
            $id_tipo_afectacion_igv =  ProductosModelo::mdlBuscarIdTipoAfectacion($hojaProductos->getCell("D" . $i)->getCalculatedValue());
            $id_unidad_medida =  ProductosModelo::mdlBuscarIdUnidadMedida($hojaProductos->getCell("E" . $i)->getCalculatedValue());
            $costo_unitario = $hojaProductos->getCell("F" . $i);
            $precio_unitario_con_igv = $hojaProductos->getCell("G" . $i);
            $precio_unitario_sin_igv = $hojaProductos->getCell("H" . $i)->getCalculatedValue();
            $precio_unitario_mayor_con_igv = $hojaProductos->getCell("I" . $i);
            $precio_unitario_mayor_sin_igv = $hojaProductos->getCell("J" . $i)->getCalculatedValue();
            $precio_unitario_oferta_con_igv = $hojaProductos->getCell("K" . $i);
            $precio_unitario_oferta_sin_igv = $hojaProductos->getCell("L" . $i)->getCalculatedValue();
            $stock = $hojaProductos->getCell("M" . $i);
            $minimo_stock = $hojaProductos->getCell("N" . $i);
            $ventas = $hojaProductos->getCell("O" . $i);
            $costo_total = $hojaProductos->getCell("P" . $i)->getCalculatedValue();

            if (!empty($codigo_producto) && strlen($codigo_producto) > 0) {

                try {
                    $stmt = $dbh->prepare("INSERT INTO productos(
                                                                codigo_producto, 
                                                                id_categoria, 
                                                                descripcion, 
                                                                id_tipo_afectacion_igv, 
                                                                id_unidad_medida,
                                                                costo_unitario, 
                                                                precio_unitario_con_igv, 
                                                                precio_unitario_sin_igv, 
                                                                precio_unitario_mayor_con_igv, 
                                                                precio_unitario_mayor_sin_igv, 
                                                                precio_unitario_oferta_con_igv, 
                                                                precio_unitario_oferta_sin_igv, 
                                                                stock, 
                                                                minimo_stock, 
                                                                ventas, 
                                                                costo_total
                                                                )
                                                                values(?,?,?,?,?,ROUND(?,2),ROUND(?,2),ROUND(?,2),ROUND(?,2),ROUND(?,2),ROUND(?,2),ROUND(?,2),?,?,?,ROUND(?,2))");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        $codigo_producto,
                        $id_categoria[0],
                        $descripcion,
                        $id_tipo_afectacion_igv[0],
                        $id_unidad_medida[0],
                        $costo_unitario,
                        $precio_unitario_con_igv,
                        $precio_unitario_sin_igv,
                        $precio_unitario_mayor_con_igv,
                        $precio_unitario_mayor_sin_igv,
                        $precio_unitario_oferta_con_igv,
                        $precio_unitario_oferta_sin_igv,
                        $stock,
                        $minimo_stock,
                        $ventas,
                        $costo_total
                    ));

                    $dbh->commit();

                    $concepto = 'INVENTARIO INICIAL';
                    $comprobante = '';

                    //REGISTRAMOS KARDEX - INVENTARIO INICIAL
                    $stmt = $dbh->prepare("call prc_registrar_kardex_existencias(?,?,?,?,?,?)");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        $codigo_producto,
                        $concepto,
                        $comprobante,
                        $stock,
                        $costo_unitario,
                        $costo_total
                    ));

                    $dbh->commit();
                    // }
                } catch (Exception $e) {
                    $dbh->rollBack();
                    $respuesta["tipo_msj"] = "error";
                    $respuesta["msj"] = "Error al cargar el kardex al sistema";
                    return $respuesta;
                }
            }
        }

        $respuesta["tipo_msj"] = "success";
        $respuesta["msj"] = "La carga masiva se realizó correctamente";

        return $respuesta;
    }

    /*===================================================================
    BUSCAR EL ID DE UNA CATEGORIA POR EL NOMBRE DE LA CATEGORIA
    ====================================================================*/
    static public function mdlBuscarIdCategoria($nombreCategoria)
    {

        $stmt = Conexion::conectar()->prepare("select id from categorias where descripcion = :nombreCategoria");
        $stmt->bindParam(":nombreCategoria", $nombreCategoria, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetch();
    }
    /*===================================================================
    BUSCAR EL ID DE UNA CATEGORIA POR EL NOMBRE DE LA CATEGORIA
    ====================================================================*/
    static public function mdlBuscarIdTipoAfectacion($nombreTipoAfectacion)
    {

        $stmt = Conexion::conectar()->prepare("select codigo from tipo_afectacion_igv where upper(descripcion) = upper(:nombreTipoAfectacion)");
        $stmt->bindParam(":nombreTipoAfectacion", $nombreTipoAfectacion, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetch();
    }

    /*===================================================================
    BUSCAR EL ID DE UNA CATEGORIA POR EL NOMBRE DE LA CATEGORIA
    ====================================================================*/
    static public function mdlBuscarIdUnidadMedida($nombreUnidadMedida)
    {

        $stmt = Conexion::conectar()->prepare("select id from codigo_unidad_medida where descripcion = :nombreUnidadMedida");
        $stmt->bindParam(":nombreUnidadMedida", $nombreUnidadMedida, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetch();
    }

    /*===================================================================
    OBTENER LISTADO TOTAL DE PRODUCTOS PARA EL DATATABLE
    ====================================================================*/
    static public function mdlListarProductos()
    {

        $stmt = Conexion::conectar()->prepare('call prc_ListarProductos');

        $stmt->execute();

        return $stmt->fetchAll();
    }

    /*===================================================================
    REGISTRAR PRODUCTO POR MODULO DE INVENTARIO
    ====================================================================*/
    static public function mdlRegistrarProducto($array_datos_producto, $imagen = null)
    {

        try {

            $dbh = Conexion::conectar();

            $fecha = date('Y-m-d');
            $costo_total_producto = 0;

            $stmt = $dbh->prepare("INSERT INTO PRODUCTOS(codigo_producto, 
                                                        id_categoria,
                                                        descripcion, 
                                                        id_tipo_afectacion_igv, 
                                                        id_unidad_medida,
                                                        precio_unitario_con_igv,
                                                        precio_unitario_sin_igv, 
                                                        precio_unitario_mayor_con_igv,
                                                        precio_unitario_mayor_sin_igv,
                                                        precio_unitario_oferta_con_igv,
                                                        precio_unitario_oferta_sin_igv,
                                                        imagen,
                                                        minimo_stock,
                                                        fecha_creacion,
                                                        fecha_actualizacion) 
                                                VALUES (?,?,upper(?),?,?,?,?,?,?,?,?,?,?,?,?)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $array_datos_producto["codigo_producto"],
                $array_datos_producto["id_categoria"],
                $array_datos_producto["descripcion"],
                $array_datos_producto["id_tipo_afectacion_igv"],
                $array_datos_producto["id_unidad_medida"],
                $array_datos_producto["precio_unitario_con_igv"],
                $array_datos_producto["precio_unitario_sin_igv"],
                $array_datos_producto["precio_unitario_mayor_con_igv"],
                $array_datos_producto["precio_unitario_mayor_sin_igv"],
                $array_datos_producto["precio_unitario_oferta_con_igv"],
                $array_datos_producto["precio_unitario_oferta_sin_igv"],
                $imagen["nuevoNombre"] ?? null,
                $array_datos_producto["minimo_stock"],
                $fecha,
                $fecha
            ));
            $dbh->commit();

            //GUARDAMOS LA IMAGEN EN LA CARPETA
            if ($imagen) {
                $guardarImagen = new ProductosModelo();
                $guardarImagen->guardarImagen($imagen["folder"], $imagen["ubicacionTemporal"], $imagen["nuevoNombre"]);
            }

            $concepto = 'REGISTRADO EN SISTEMA';
            $comprobante = '';

            //REGISTRAMOS KARDEX - INVENTARIO INICIAL
            $stmt = $dbh->prepare("call prc_registrar_kardex_existencias(?,?,?,?,?,?);");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $array_datos_producto["codigo_producto"],
                $concepto,
                $comprobante,
                0,
                0,
                $costo_total_producto
            ));

            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se registró el producto correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al registrar el producto " . $e->getMessage();
        }

        return $respuesta;
    }

    /*===================================================================
    ACTUALIZAR PRODUCTO
    ====================================================================*/
    static public function mdlActualizarProducto($array_datos_producto, $imagen = null)
    {

        $stmt = Conexion::conectar()->prepare("select imagen from productos where codigo_producto = :codigo_producto");
        $stmt->bindParam(":codigo_producto", $array_datos_producto["codigo_producto"], PDO::PARAM_STR);
        $stmt->execute();

        $imagen_actual = $stmt->fetch()[0];

        try {

            $dbh = Conexion::conectar();

            $fecha_actualizacion = date('Y-m-d');

            $stmt = $dbh->prepare(" UPDATE  
                                        productos
                                    SET 
                                    id_categoria = ?,
                                    descripcion = ?, 
                                    id_tipo_afectacion_igv = ?, 
                                    id_unidad_medida = ?,
                                    precio_unitario_con_igv = ?,
                                    precio_unitario_sin_igv = ?, 
                                    precio_unitario_mayor_con_igv = ?,
                                    precio_unitario_mayor_sin_igv = ?,
                                    precio_unitario_oferta_con_igv = ?,
                                    precio_unitario_oferta_sin_igv = ?,
                                    imagen = ?,
                                    minimo_stock = ?, 
                                    fecha_actualizacion = ?
                                    WHERE 
                                        codigo_producto = ?");

            $dbh->beginTransaction();
            $stmt->execute(array(

                $array_datos_producto["id_categoria"],
                $array_datos_producto["descripcion"],
                $array_datos_producto["id_tipo_afectacion_igv"],
                $array_datos_producto["id_unidad_medida"],
                $array_datos_producto["precio_unitario_con_igv"],
                $array_datos_producto["precio_unitario_sin_igv"],
                $array_datos_producto["precio_unitario_mayor_con_igv"],
                $array_datos_producto["precio_unitario_mayor_sin_igv"],
                $array_datos_producto["precio_unitario_oferta_con_igv"],
                $array_datos_producto["precio_unitario_oferta_sin_igv"],
                $imagen["nuevoNombre"] ?? $imagen_actual,
                $array_datos_producto["minimo_stock"],
                $fecha_actualizacion,
                $array_datos_producto["codigo_producto"],
            ));

            $dbh->commit();

            //GUARDAMOS LA IMAGEN EN LA CARPETA
            if ($imagen) {
                $guardarImagen = new ProductosModelo();
                $guardarImagen->guardarImagen($imagen["folder"], $imagen["ubicacionTemporal"], $imagen["nuevoNombre"]);
            }


            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se actualizó el producto correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al actualizar el producto " . $e->getMessage();
        }

        return $respuesta;
    }

    /*===================================================================
    ELIMINAR PRODUCTOS
    ====================================================================*/
    static public function mdlEliminarProducto($codigo_producto)
    {

        try {

            $dbh = Conexion::conectar();

            $stmt = $dbh->prepare(" UPDATE  
                                        productos
                                    SET 
                                        estado = 0
                                    WHERE 
                                        codigo_producto = ?");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $codigo_producto
            ));

            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se eliminó el producto correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al eliminar el producto " . $e->getMessage();
        }

        return $respuesta;
    }

    /*=============================================
    AUMENTAR STOCK
    =============================================*/
    static public function mdlAumentarStock($codigo_producto, $nuevo_stock)
    {

        $concepto = 'AUMENTO DE STOCK POR MODULO DE INVENTARIO';

        try {

            $dbh = Conexion::conectar();

            $stmt = $dbh->prepare("call prc_registrar_kardex_bono(?,?,?);");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $codigo_producto,
                $concepto,
                $nuevo_stock
            ));

            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se aumento el stock del producto correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al aumentar el stock del producto " . $e->getMessage();
        }

        return $respuesta;
    }

    /*=============================================
    DISMINUIR STOCK
    =============================================*/
    static public function mdlDisminuirStock($codigo_producto, $nuevo_stock)
    {

        $concepto = 'DISMINUCIÓN DE STOCK POR MODULO DE INVENTARIO';

        try {

            $dbh = Conexion::conectar();

            $stmt = $dbh->prepare("call prc_registrar_kardex_vencido(?,?,?)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $codigo_producto,
                $concepto,
                $nuevo_stock
            ));

            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se disminuyó el stock del producto correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al dismiunir el stock del producto " . $e->getMessage();
        }

        return $respuesta;
    }

    /*===================================================================
    LISTAR NOMBRE DE PRODUCTOS PARA INPUT DE AUTO COMPLETADO
    ====================================================================*/
    static public function mdlListarNombreProductos()
    {

        $stmt = Conexion::conectar()->prepare(
            "SELECT Concat(codigo_producto , ' / ' ,
                                                             c.nombre_categoria,' / ',
                                                             descripcion_producto, ' - S./ ' , 
                                                             p.precio_venta_producto, ' / Stock: ',
                                                             p.stock_producto)  as descripcion_producto
                                                FROM productos p inner join categorias c on p.id_categoria_producto = c.id_categoria"
        );

        $stmt->execute();

        return $stmt->fetchAll();
    }

    /*===================================================================
    BUSCAR PRODUCTO POR SU CODIGO DE BARRAS
    ====================================================================*/
    static public function mdlGetDatosProducto($codigoProducto)
    {

        $stmt = Conexion::conectar()->prepare("SELECT p.codigo_producto, 
                                                    p.id_categoria, 
                                                    p.descripcion, 
                                                    p.id_tipo_afectacion_igv, 
                                                    case when p.id_tipo_afectacion_igv = 10 
                                                            then 'GRAVADO' 
                                                        when p.id_tipo_afectacion_igv = 20 
                                                            then 'EXONERADO' 
                                                        when p.id_tipo_afectacion_igv = 30
                                                            then 'INAFECTO' 
                                                    end as tipo_afectacion_igv,
                                                    p.id_unidad_medida, 
                                                    cum.descripcion as unidad_medida,
                                                    p.costo_unitario, 
                                                    p.precio_unitario_con_igv, 
                                                    p.precio_unitario_sin_igv, 
                                                    p.precio_unitario_mayor_con_igv, 
                                                    p.precio_unitario_mayor_sin_igv, 
                                                    p.precio_unitario_oferta_con_igv, 
                                                    p.precio_unitario_oferta_sin_igv, 
                                                    p.stock,         
                                                    p.costo_total,
                                                    case when p.id_tipo_afectacion_igv = 10 then 1.18 else 1 end as factor_igv,
                                                    case when p.id_tipo_afectacion_igv = 10 then 0.18 else 0 end as porcentaje_igv
                                                FROM productos p inner join tipo_afectacion_igv tai on tai.codigo = p.id_tipo_afectacion_igv
                                                                inner join codigo_unidad_medida cum on cum.id = p.id_unidad_medida
                                                WHERE codigo_producto = :codigoProducto
                                                AND p.stock > 0");

        $stmt->bindParam(":codigoProducto", $codigoProducto, PDO::PARAM_STR);

        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    /*===================================================================
    BUSCAR PRODUCTO POR SU CODIGO DE BARRAS
    ====================================================================*/
    static public function mdlObtenerProducto($codigoProducto)
    {

        $stmt = Conexion::conectar()->prepare("SELECT p.codigo_producto, 
                                                    p.id_categoria, 
                                                    p.descripcion, 
                                                    p.id_tipo_afectacion_igv, 
                                                    case when p.id_tipo_afectacion_igv = 10 
                                                            then 'GRAVADO' 
                                                        when p.id_tipo_afectacion_igv = 20 
                                                            then 'EXONERADO' 
                                                        when p.id_tipo_afectacion_igv = 30
                                                            then 'INAFECTO' 
                                                    end as tipo_afectacion_igv,
                                                    p.id_unidad_medida, 
                                                    cum.descripcion as unidad_medida,
                                                    p.costo_unitario, 
                                                    p.precio_unitario_con_igv, 
                                                    p.precio_unitario_sin_igv, 
                                                    p.precio_unitario_mayor_con_igv, 
                                                    p.precio_unitario_mayor_sin_igv, 
                                                    p.precio_unitario_oferta_con_igv, 
                                                    p.precio_unitario_oferta_sin_igv, 
                                                    p.stock,         
                                                    p.costo_total,
                                                    case when p.id_tipo_afectacion_igv = 10 then 1.18 else 1 end as factor_igv,
                                                    case when p.id_tipo_afectacion_igv = 10 then 0.18 else 0 end as porcentaje_igv
                                                FROM productos p inner join tipo_afectacion_igv tai on tai.codigo = p.id_tipo_afectacion_igv
                                                                inner join codigo_unidad_medida cum on cum.id = p.id_unidad_medida
                                                WHERE codigo_producto = :codigoProducto");

        $stmt->bindParam(":codigoProducto", $codigoProducto, PDO::PARAM_STR);

        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    /*===================================================================
    VERIFICAR EL STOCK DE UN PRODUCTO
    ====================================================================*/
    static public function mdlVerificaStockProducto($codigo_producto, $cantidad_a_comprar)
    {

        $stmt = Conexion::conectar()->prepare("SELECT   count(*) as existe, stock
                                                    FROM productos p 
                                                   WHERE p.codigo_producto = :codigo_producto");
                                                    // AND p.stock >= :cantidad_a_comprar");

        $stmt->bindParam(":codigo_producto", $codigo_producto, PDO::PARAM_STR);
        // $stmt->bindParam(":cantidad_a_comprar", $cantidad_a_comprar, PDO::PARAM_STR);

        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    public function guardarImagen($folder, $ubicacionTemporal, $nuevoNombre)
    {
        file_put_contents(strtolower($folder . $nuevoNombre), file_get_contents($ubicacionTemporal));
    }

    /*=============================================
    FUNCION PARA DESACTIVAR UN PRODUCTO
    =============================================*/
    static public function mdlDesactivarProducto($codigo_producto)
    {

        $stmt = Conexion::conectar()->prepare("UPDATE productos 
                                                  SET estado = 0 
                                                WHERE codigo_producto = :codigo_producto");

        $stmt->bindParam(":codigo_producto", $codigo_producto, PDO::PARAM_STR);

        if ($stmt->execute()) {
            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se desactivó el Producto correctamente";
        } else {
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al desactivar el Producto." . Conexion::conectar()->errorInfo();
        }

        return $respuesta;
    }

    /*=============================================
    FUNCION PARA ACTIVAR UN PRODUCTO
    =============================================*/
    static public function mdlActivarProducto($codigo_producto)
    {

        $stmt = Conexion::conectar()->prepare("UPDATE productos 
                                                  SET estado = 1
                                                WHERE codigo_producto = :codigo_producto");

        $stmt->bindParam(":codigo_producto", $codigo_producto, PDO::PARAM_STR);

        if ($stmt->execute()) {
            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se activó el Producto correctamente";
        } else {
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al activar el Producto." . Conexion::conectar()->errorInfo();
        }

        return $respuesta;
    }

    static public function mdlListarTipoAfectacion()
    {
        $stmt = Conexion::conectar()->prepare("select codigo,concat(codigo, ' - ', descripcion) as descripcion  from tipo_afectacion_igv where estado = 1;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlListarUnidadMedida()
    {
        $stmt = Conexion::conectar()->prepare("select id,concat(id, ' - ', descripcion) as descripcion from codigo_unidad_medida where estado = 1;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerImpuesto($id_tipo_operacion)
    {
        $stmt = Conexion::conectar()->prepare("select id_tipo_operacion, impuesto
                                                from impuestos 
                                                where estado = 1
                                                and id_tipo_operacion = :id_tipo_operacion");

        $stmt->bindParam(":id_tipo_operacion", $id_tipo_operacion, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlValidarCodigoProducto($codigo_producto)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM productos p
                                            WHERE codigo_producto = :codigo_producto");

        $stmt->bindParam(":codigo_producto", $codigo_producto, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }
}
