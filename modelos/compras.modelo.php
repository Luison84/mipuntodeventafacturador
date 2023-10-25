<?php

require_once "conexion.php";

class ComprasModelo
{

    static public function mdlObtenerCompras($post)
    {

        $column = [
            "id", "id_proveedor", "proveedor", "fecha_compra", "id_tipo_comprobante", "comprobante", "serie", "correlativo",
            "id_moneda", "ope_exonerada", "ope_inafecta", "ope_gravada", "total_igv", "descuento", "total_compra", "estado"
        ];

        $query = " SELECT '' as opciones,
                            c.id, 
                            c.id_proveedor, 
                            p.razon_social as proveedor,
                            DATE(c.fecha_compra) as fecha_compra,
                            c.id_tipo_comprobante, 
                            tc.descripcion as comprobante,
                            c.serie, 
                            c.correlativo, 
                            c.id_moneda, 
                            format(c.ope_gravada,2) as ope_gravada, 
                            format(c.ope_exonerada,2) as ope_exonerada, 
                            format(c.ope_inafecta,2) as ope_inafecta, 
                            format(c.total_igv,2) as total_igv, 
                            format(c.descuento,2) as descuento, 
                            format(c.total_compra,2) as total_compra, 
                            case when c.estado = 1 then 'REGISTRADO' else 'CONFIRMADO' end as estado
                    FROM compras c inner join tipo_comprobante tc on c.id_tipo_comprobante = tc.codigo
                                    inner join proveedores p on p.id = c.id_proveedor";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE c.id like "%' . $post["search"]["value"] . '%"
                        or c.fecha_compra like "%' . $post["search"]["value"] . '%"
                        or tc.descripcion like "%' . $post["search"]["value"] . '%"
                        or c.serie like "%' . $post["search"]["value"] . '%"
                        or c.correlativo like "%' . $post["search"]["value"] . '%"
                        or case when c.estado = 1 then "REGISTRADO" else "CONFIRMADO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $column[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY c.id desc ';
        }

        //SE AGREGA PAGINACION
        if ($post["length"] != -1) {
            $query1 = " LIMIT " . $post["start"] . ", " . $post["length"];
        }

        $stmt = Conexion::conectar()->prepare($query);

        $stmt->execute();

        $number_filter_row = $stmt->rowCount();

        $stmt =  Conexion::conectar()->prepare($query . $query1);

        $stmt->execute();

        $results = $stmt->fetchAll(PDO::FETCH_NAMED);

        $data = array();

        foreach ($results as $row) {
            $sub_array = array();
            $sub_array[] = $row['opciones'];
            $sub_array[] = $row['id'];
            $sub_array[] = $row['id_proveedor'];
            $sub_array[] = $row['proveedor'];
            $sub_array[] = $row['fecha_compra'];
            $sub_array[] = $row['id_tipo_comprobante'];
            $sub_array[] = $row['comprobante'];
            $sub_array[] = $row['serie'];
            $sub_array[] = $row['correlativo'];
            $sub_array[] = $row['id_moneda'];
            $sub_array[] = $row['ope_gravada'];
            $sub_array[] = $row['ope_exonerada'];
            $sub_array[] = $row['ope_inafecta'];
            $sub_array[] = $row['total_igv'];
            $sub_array[] = $row['descuento'];
            $sub_array[] = $row['total_compra'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT '1'
                                                FROM compras c inner join tipo_comprobante tc on c.id_tipo_comprobante = tc.id
                                                            inner join proveedores p on p.id = c.id_proveedor");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $output = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $output;
    }

    static public function mdlObtenerSimboloMoneda($moneda)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT id, descripcion, simbolo, estado
                                            FROM moneda
                                            WHERE id = :moneda");

        $stmt->bindParam(":moneda", $moneda, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlRegistrarCompra($formulario_compra, $detalle_compra, $ope_gravadas, $ope_exoneradas, $ope_inafectas, $total_igv, $total_descuento, $total)
    {

        $dbh = Conexion::conectar();

        //VALIDAR QUE EL COMPROBANTE NO EXISTA

        $stmt = Conexion::conectar()->prepare(" SELECT COUNT(1) as existe
                                                FROM compras
                                            WHERE upper(serie) = upper(:serie)
                                            AND correlativo = :correlativo");

        $stmt->bindParam(":serie", $formulario_compra["serie"], PDO::PARAM_STR);
        $stmt->bindParam(":correlativo", $formulario_compra["correlativo"], PDO::PARAM_STR);

        $stmt->execute();
        $existe = $stmt->fetch(PDO::FETCH_NAMED);

        if (intval($existe["existe"]) > 0) {
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "El comprobante de compra: " . strtoupper($formulario_compra["serie"]) . '-' . $formulario_compra["correlativo"] . ' ya fue registrado';
            return $respuesta;
        }

        //ELIMINAR TABLAS DEL SISTEMA
        try {

            $stmt = $dbh->prepare("INSERT INTO compras(id_proveedor,
                                                        fecha_compra,
                                                        id_tipo_comprobante,
                                                        serie,
                                                        correlativo,
                                                        id_moneda,
                                                        ope_exonerada,
                                                        ope_inafecta,
                                                        ope_gravada,
                                                        total_igv,
                                                        descuento,
                                                        total_compra,
                                                        estado)
                                                VALUES(:id_proveedor,
                                                        :fecha_compra,
                                                        :id_tipo_comprobante,
                                                        upper(:serie),
                                                        :correlativo,
                                                        :id_moneda,
                                                        :ope_exoneradas,
                                                        :ope_inafectas,
                                                        :ope_gravadas,
                                                        :total_igv,
                                                        :descuento,
                                                        :total_compra,
                                                        :estado)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_proveedor' => $formulario_compra["id_proveedor"],
                ':fecha_compra' => $formulario_compra["fecha_registro"],
                ':id_tipo_comprobante' => $formulario_compra["tipo_comprobante"],
                ':serie' => $formulario_compra["serie"],
                ':correlativo' => $formulario_compra["correlativo"],
                ':id_moneda' => $formulario_compra["moneda"],
                ':ope_exoneradas' => $ope_exoneradas,
                ':ope_inafectas' => $ope_inafectas,
                ':ope_gravadas' => $ope_gravadas,
                ':total_igv' => $total_igv,
                ':descuento' => $total_descuento,
                ':total_compra' => $total,
                ':estado' => true
            ));

            $id_compra_inserted = $dbh->lastInsertId();
            $dbh->commit();

            //GUARDAR EL DETALLE DE LA COMPRA:
            // foreach ($detalle_compra as $producto) {

            for ($i = 0; $i < count($detalle_compra); $i++) {
                # code...


                $stmt = $dbh->prepare("INSERT INTO detalle_compra(id_compra,
                                                                codigo_producto,
                                                                cantidad,
                                                                costo_unitario,
                                                                descuento,
                                                                subtotal,
                                                                impuesto,
                                                                total)
                                                VALUES(:id_compra,
                                                        :codigo_producto,
                                                        :cantidad,
                                                        :costo_unitario,
                                                        :descuento,
                                                        :subtotal,
                                                        :impuesto,
                                                        :total)");
                $dbh->beginTransaction();
                $stmt->execute(array(
                    ':id_compra' => $id_compra_inserted,
                    ':codigo_producto' => $detalle_compra[$i]->codigo_producto,
                    ':cantidad' => $detalle_compra[$i]->cantidad_temp,
                    ':costo_unitario' => $detalle_compra[$i]->costo_unitario_temp,
                    ':descuento' => $detalle_compra[$i]->descuento_temp,
                    ':subtotal' => $detalle_compra[$i]->subTotal,
                    ':impuesto' => $detalle_compra[$i]->impuesto,
                    ':total' => $detalle_compra[$i]->total
                ));

                $dbh->commit();

                /**************************************************************************** 
                R E G I S T R A M O S   E L   K A R D E X   D E   E N T R A D A S
                 ****************************************************************************/

                // $concepto = 'COMPRA';

                // $stmt = Conexion::conectar()->prepare("call prc_registrar_kardex_compra (upper(:comprobante),
                //                                                                         :codigo_producto,
                //                                                                         upper(:concepto),
                //                                                                         :cantidad_compra,
                //                                                                         :costo_compra)");

                // $dbh->beginTransaction();
                // $stmt->execute(array(
                //     ':comprobante' =>  $formulario_compra["serie"] . '-' . $formulario_compra["correlativo"],
                //     ':codigo_producto' => $detalle_compra[$i]->codigo_producto,
                //     ':concepto' =>  $concepto,
                //     ':cantidad_compra' => $detalle_compra[$i]->cantidad_temp,
                //     ':costo_compra' => $detalle_compra[$i]->costo_unitario_temp
                // ));
                // $dbh->commit();
            }

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se registró la compra correctamente con Nro: " . $id_compra_inserted;
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al registrar la compra correctamente " . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlActualizarCompra($formulario_compra, $detalle_compra, $ope_gravadas, $ope_exoneradas, $ope_inafectas, $total_igv, $total_descuento, $total)
    {

        $dbh = Conexion::conectar();

        //VALIDAR QUE EL COMPROBANTE NO EXISTA
        $stmt = Conexion::conectar()->prepare("SELECT COUNT(1) as existe
                                                FROM compras
                                                WHERE upper(serie) = upper(:serie)
                                                AND correlativo = :correlativo
                                                AND id != :id_compra");

        $stmt->bindParam(":serie", $formulario_compra["serie"], PDO::PARAM_STR);
        $stmt->bindParam(":correlativo", $formulario_compra["correlativo"], PDO::PARAM_STR);
        $stmt->bindParam(":id_compra", $formulario_compra["id_compra"], PDO::PARAM_STR);

        $stmt->execute();
        $existe = $stmt->fetch(PDO::FETCH_NAMED);

        if (intval($existe["existe"]) > 0) {
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "El comprobante de compra: " . strtoupper($formulario_compra["serie"]) . '-' . $formulario_compra["correlativo"] . ' ya fue registrado';
            return $respuesta;
        }

        //ELIMINAR TABLAS DEL SISTEMA
        try {

            $stmt = $dbh->prepare("UPDATE compras
                                        SET id_proveedor = :id_proveedor,
                                            fecha_compra = :fecha_compra,
                                            id_tipo_comprobante = :id_tipo_comprobante,
                                            serie = upper(:serie),
                                            correlativo = :correlativo,
                                            id_moneda = :id_moneda,
                                            ope_exonerada = :ope_exoneradas,
                                            ope_inafecta = :ope_inafectas,
                                            ope_gravada = :ope_gravadas,
                                            total_igv = :total_igv,
                                            descuento = :descuento,
                                            total_compra = :total_compra
                                    WHERE id = :id_compra");

            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_proveedor' => $formulario_compra["id_proveedor"],
                ':fecha_compra' => $formulario_compra["fecha_registro"],
                ':id_tipo_comprobante' => $formulario_compra["tipo_comprobante"],
                ':serie' => $formulario_compra["serie"],
                ':correlativo' => $formulario_compra["correlativo"],
                ':id_moneda' => $formulario_compra["moneda"],
                ':ope_exoneradas' => $ope_exoneradas,
                ':ope_inafectas' => $ope_inafectas,
                ':ope_gravadas' => $ope_gravadas,
                ':total_igv' => $total_igv,
                ':descuento' => $total_descuento,
                ':total_compra' => $total,
                ':id_compra' => $formulario_compra["id_compra"]
            ));

            $dbh->commit();

            $stmt = $dbh->prepare("DELETE FROM detalle_compra WHERE id_compra = :id_compra");
            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_compra' => $formulario_compra["id_compra"]
            ));

            $dbh->commit();

            //GUARDAR EL DETALLE DE LA COMPRA:
            for ($i = 0; $i < count($detalle_compra); $i++) {

                $stmt = $dbh->prepare("INSERT INTO detalle_compra(id_compra,
                                                                codigo_producto,
                                                                cantidad,
                                                                costo_unitario,
                                                                descuento,
                                                                subtotal,
                                                                impuesto,
                                                                total)
                                                VALUES(:id_compra,
                                                        :codigo_producto,
                                                        :cantidad,
                                                        :costo_unitario,
                                                        :descuento,
                                                        :subtotal,
                                                        :impuesto,
                                                        :total)");
                $dbh->beginTransaction();
                $stmt->execute(array(
                    ':id_compra' => $formulario_compra["id_compra"],
                    ':codigo_producto' => $detalle_compra[$i]->codigo_producto,
                    ':cantidad' => $detalle_compra[$i]->cantidad_temp,
                    ':costo_unitario' => $detalle_compra[$i]->costo_unitario_temp,
                    ':descuento' => $detalle_compra[$i]->descuento_temp,
                    ':subtotal' => $detalle_compra[$i]->subTotal,
                    ':impuesto' => $detalle_compra[$i]->impuesto,
                    ':total' => $detalle_compra[$i]->total
                ));

                $dbh->commit();

                /**************************************************************************** 
                R E G I S T R A M O S   E L   K A R D E X   D E   E N T R A D A S
                 ****************************************************************************/

                // $concepto = 'COMPRA';

                // $stmt = Conexion::conectar()->prepare("call prc_registrar_kardex_compra (upper(:comprobante),
                //                                                                         :codigo_producto,
                //                                                                         upper(:concepto),
                //                                                                         :cantidad_compra,
                //                                                                         :costo_compra)");

                // $dbh->beginTransaction();
                // $stmt->execute(array(
                //     ':comprobante' =>  $formulario_compra["serie"] . '-' . $formulario_compra["correlativo"],
                //     ':codigo_producto' => $detalle_compra[$i]->codigo_producto,
                //     ':concepto' =>  $concepto,
                //     ':cantidad_compra' => $detalle_compra[$i]->cantidad_temp,
                //     ':costo_compra' => $detalle_compra[$i]->costo_unitario_temp
                // ));
                // $dbh->commit();
            }

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se actualizó la compra correctamente con Nro: " . $formulario_compra["id_compra"];
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al actualizar la compra correctamente " . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlObtenerCompraPorId($id_compra)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT c.id, 
                                                        c.id_proveedor, 
                                                        p.ruc,
                                                        p.razon_social as proveedor,
                                                        DATE(c.fecha_compra) as fecha_compra, 
                                                        c.id_tipo_comprobante, 
                                                        tc.descripcion as comprobante,
                                                        c.serie, 
                                                        c.correlativo, 
                                                        c.id_moneda, 
                                                        c.ope_exonerada, 
                                                        c.ope_inafecta, 
                                                        c.ope_gravada, 
                                                        c.total_igv, 
                                                        c.descuento, 
                                                        c.total_compra, 
                                                        c.estado
                                                FROM compras c inner join tipo_comprobante tc on c.id_tipo_comprobante = tc.codigo
                                                                inner join proveedores p on p.id = c.id_proveedor
                                                WHERE c.id = :id_compra");

        $stmt->bindParam(":id_compra", $id_compra, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    static public function mdlImpresionObtenerCompraPorId($id_compra)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT c.id, 
                                                        c.id_proveedor, 
                                                        p.ruc,
                                                        p.razon_social as proveedor,
                                                        p.direccion,
                                                        p.telefono,
                                                        DATE(c.fecha_compra) as fecha_compra, 
                                                        c.id_tipo_comprobante, 
                                                        tc.descripcion as comprobante,
                                                        c.serie, 
                                                        c.correlativo, 
                                                        c.id_moneda, 
                                                        c.ope_exonerada, 
                                                        c.ope_inafecta, 
                                                        c.ope_gravada, 
                                                        c.total_igv, 
                                                        c.descuento, 
                                                        c.total_compra, 
                                                        c.estado
                                                FROM compras c inner join tipo_comprobante tc on c.id_tipo_comprobante = tc.codigo
                                                                inner join proveedores p on p.id = c.id_proveedor
                                                WHERE c.id = :id_compra");

        $stmt->bindParam(":id_compra", $id_compra, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    static public function mdlObtenerDetalleCompraPorId($id_compra)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT '' as acciones,
                                                        dc.codigo_producto, 
                                                        p.descripcion as producto,
                                                        dc.cantidad as cantidad, 
                                                        dc.cantidad as cantidad_temp, 
                                                        dc.costo_unitario, 
                                                        dc.costo_unitario as costo_unitario_temp,  
                                                        dc.descuento, 
                                                        dc.descuento as descuento_temp,  
                                                        dc.subtotal, 
                                                        dc.impuesto, 
                                                        total,
                                                        p.id_tipo_afectacion_igv,
                                                        case when p.id_tipo_afectacion_igv = 10 then 1.18 else 1 end as factor_igv,
                                                        case when p.id_tipo_afectacion_igv = 10 then 0.18 else 0 end as porcentaje_igv
                                                FROM compras c inner join detalle_compra dc on c.id = dc.id_compra
                                                                inner join productos p on p.codigo_producto = dc.codigo_producto
                                                            --	inner join tipo_afectacion_igv tai on tai.id = p.id_tipo_afectacion_igv
                                                WHERE c.id = :id_compra");

        $stmt->bindParam(":id_compra", $id_compra, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_NAMED);
    }

    static public function mdlMostrarDetalleCompraPorId($id_compra)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT  dc.codigo_producto, 
                                                        p.descripcion as producto,
                                                        dc.cantidad as cantidad,                                                        
                                                        format(dc.costo_unitario,2)  as costo_unitario,
                                                        format(dc.descuento,2)  as descuento,
                                                        format(dc.subtotal,2)  as subtotal,
                                                        format(dc.impuesto,2)  as impuesto,
                                                        format(total,2) as total
                                                FROM compras c inner join detalle_compra dc on c.id = dc.id_compra
                                                                inner join productos p on p.codigo_producto = dc.codigo_producto
                                                WHERE c.id = :id_compra");

        $stmt->bindParam(":id_compra", $id_compra, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlConfirmarCompra($serie,  $correlativo, $id_compra)
    {

        $dbh = Conexion::conectar();

        $detalle_compra = ComprasModelo::mdlObtenerDetalleCompraPorId($id_compra);

        try {

            for ($i = 0; $i < count($detalle_compra); $i++) {
                // var_dump($detalle_compra[$i]["codigo_producto"]);

                /**************************************************************************** 
                R E G I S T R A M O S   E L   K A R D E X   D E   E N T R A D A S
                 ****************************************************************************/

                $concepto = 'COMPRA';

                $stmt = Conexion::conectar()->prepare("call prc_registrar_kardex_compra (:id_compra,
                                                                                    upper(:comprobante),
                                                                                    :codigo_producto,
                                                                                    upper(:concepto),
                                                                                    :cantidad_compra,
                                                                                    :costo_compra)");

                $dbh->beginTransaction();
                $stmt->execute(array(
                    ':id_compra' =>  $id_compra,
                    ':comprobante' =>  $serie . '-' . $correlativo,
                    ':codigo_producto' => $detalle_compra[$i]["codigo_producto"],
                    ':concepto' =>  $concepto,
                    ':cantidad_compra' => $detalle_compra[$i]["cantidad"],
                    ':costo_compra' => $detalle_compra[$i]["costo_unitario"]
                ));
                $dbh->commit();
            }

            $stmt = Conexion::conectar()->prepare("UPDATE compras set estado = 2 where id = :id_compra");

            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_compra' =>  $id_compra
            ));
            $dbh->commit();


            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se confirmó la compra N° " . $id_compra . ", el Stock de los productos ha sido actualizado";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al confirmar la compra " . $e->getMessage();
        }


        return $respuesta;
    }


    static public function mdlEliminarCompra($id_compra)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = Conexion::conectar()->prepare("DELETE FROM detalle_compra WHERE id_compra = :id_compra");

            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_compra' =>  $id_compra
            ));
            $dbh->commit();

            $stmt = Conexion::conectar()->prepare("DELETE FROM compras WHERE id = :id_compra");

            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_compra' =>  $id_compra
            ));
            $dbh->commit();
        
            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "Se eliminó la compra correctamente";

        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al eliminar la compra " . $e->getMessage();
        }

        return $respuesta;
    }
}
