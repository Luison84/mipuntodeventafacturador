<?php
session_start();

require_once "conexion.php";

class ArqueoCajaModelo
{

    static public function mdlObtenerArqueoPorUsuario()
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $stmt = Conexion::conectar()->prepare("select '' as opciones,
                                                ac.id,
                                                usu.usuario,
                                                ac.fecha_apertura,
                                                ac.fecha_cierre,
                                                FORMAT(ifnull(FORMAT(ac.monto_apertura,2),0),2) as monto_apertura,
                                                FORMAT(ifnull(FORMAT(ac.ingresos,2),0),2) as ingresos,
                                                FORMAT(ifnull(FORMAT(ac.devoluciones,2),0),2) as devoluciones,
                                                FORMAT(ifnull(FORMAT(ac.gastos,2),0),2) as gastos,
                                                FORMAT(ifnull(FORMAT(ac.monto_final,2),0),2) as monto_final,
                                                case when ac.estado = 1 then 'CAJA ABIERTA' else 'CAJA CERRADA' end estado
                                        from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
                                        where ac.id_usuario = :id_usuario
                                        order by ac.id desc");

        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll();
    }

    static public function mdlObtenerArqueoPorDia()
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $stmt = Conexion::conectar()->prepare("select ifnull(ac.id,0) as id,
                                                    usu.usuario,
                                                    ac.fecha_apertura,
                                                    ac.fecha_cierre,
                                                    ifnull(ac.monto_apertura,0) as monto_apertura,
                                                    ifnull(FORMAT(ac.monto_apertura,2),0) as monto_apertura,
                                                    ifnull(FORMAT(ac.ingresos,2),0) as ingresos,
                                                    ifnull(FORMAT(ac.devoluciones,2),0) as devoluciones,
                                                    ifnull(FORMAT(ac.gastos,2),0) as gastos,
                                                    ifnull(FORMAT(ac.monto_final,2),0) as monto_final,
                                                    ac.estado,
                                                    count(1) as cantidad,
                                                    (select simbolo from moneda where id = 'PEN') as simbolo_moneda
                                            from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
                                            where ac.id_usuario = :id_usuario
                                            and ac.estado = 1
                                            and date(ac.fecha_apertura) = curdate()");

        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    static public function mdlObtenerArqueoPorId($id_arqueo)
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $stmt = Conexion::conectar()->prepare("SELECT ifnull(ac.id,0) as id,
                                                    usu.usuario,
                                                    ac.fecha_apertura,
                                                    ac.fecha_cierre,
                                                    ifnull(ac.monto_apertura,0) as monto_apertura,
                                                    ifnull(FORMAT(ac.monto_apertura,2),0) as monto_apertura,
                                                    ifnull(FORMAT(ac.ingresos,2),0) as ingresos,
                                                    round((select sum(ifnull(x.monto,0)) 
                                                            from movimientos_arqueo_caja x
                                                            where x.id_arqueo_caja = ac.id
                                                            and x.id_tipo_movimiento = 3
                                                            and (UPPER(x.descripcion) like '%CONTADO%' or UPPER(x.descripcion) like '%PAGO%')),2) as ingresos_efectivo,
                                                    round((select sum(ifnull(x.monto,0)) 
                                                            from movimientos_arqueo_caja x
                                                            where x.id_arqueo_caja = ac.id
                                                            and x.id_tipo_movimiento = 3
                                                            and UPPER(x.descripcion) like '%CRÉDITO%'),2) as ingresos_credito,
                                                    ifnull(FORMAT(ac.devoluciones,2),0) as devoluciones,
                                                    ifnull(FORMAT(ac.gastos,2),0) as gastos,
                                                    ifnull(FORMAT(ac.monto_final,2),0) as monto_final,
                                                    ac.estado,
                                                    count(1) as cantidad,
                                                    (select simbolo from moneda where id = 'PEN') as simbolo_moneda
                                            from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
                                            where ac.id_usuario = :id_usuario
                                            and ac.id = :id_arqueo");

        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_STR);
        $stmt->bindParam(":id_arqueo", $id_arqueo, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_OBJ);
    }


    static public function mdlObtenerMovimientosArqueoCajaPorUsuario($id_caja)
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $stmt = Conexion::conectar()->prepare('call prc_movimentos_arqueo_caja_por_usuario(:id_usuario, :id_caja)');

        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
        $stmt->bindParam(":id_caja", $id_caja, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }

    static public function mdlCerrarCaja($id_caja, $ingresos, $devoluciones, $gastos, $monto_final, $monto_real, $sobrante, $faltante)
    {

        try {

            $dbh = Conexion::conectar();

            $stmt = $dbh->prepare("update arqueo_caja
                                     set fecha_cierre = current_timestamp(),
                                            ingresos = ?,
                                            devoluciones = ?,
                                            gastos = ?,
                                            monto_final = ?,
                                            monto_real = ?,
                                            sobrante = ?,
                                            faltante = ?,
                                            estado = 0
                                    where id = ?");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $ingresos,
                $devoluciones,
                $gastos,
                $monto_final,
                $monto_real,
                $sobrante,
                $faltante,
                $id_caja
            ));

            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "La caja se ha cerrado correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al cerrar la caja " . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlAbrirCaja($id_caja, $monto_apertura)
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $stmt = Conexion::conectar()->prepare('SELECT count(1) as cantidad
                                                FROM arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
                                                WHERE ac.id_usuario = :id_usuario
                                                AND ac.estado = 1
                                                order by ac.id desc');

        $stmt->bindParam(":id_usuario", $id_usuario, PDO::PARAM_INT);
        $stmt->execute();

        $response = $stmt->fetch(PDO::FETCH_OBJ);

        if ($response->cantidad > 0) {
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Se encontraron cajas pendientes de cerrar, por favor cierre las cajas abiertas";

            return $respuesta;
        }

        try {

            $dbh = Conexion::conectar();


            $stmt = $dbh->prepare("insert into arqueo_caja(id_usuario, fecha_apertura, monto_apertura, monto_final)
                                        values(?,current_timestamp(), ?, ?)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $id_usuario,
                $monto_apertura,
                $monto_apertura
            ));

            $id_arqueo_inserted = $dbh->lastInsertId();

            $dbh->commit();

            $dbh = Conexion::conectar();


            $stmt = $dbh->prepare("INSERT INTO movimientos_arqueo_caja(id_arqueo_caja, 
                                                                        id_tipo_movimiento, 
                                                                        descripcion, 
                                                                        monto, 
                                                                        estado)
                                        VALUES(:id_arqueo_caja, 
                                                :id_tipo_movimiento, 
                                                :descripcion, 
                                                :monto, 
                                                :estado)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                ':id_arqueo_caja' => $id_arqueo_inserted,
                ':id_tipo_movimiento' => 4,
                ':descripcion' => 'APERTURA CAJA',
                ':monto' => $monto_apertura,
                ':estado' => 1
            ));
            $dbh->commit();


            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "La caja se aperturó correctamente";

            // else {
            //     $stmt = $dbh->prepare("update arqueo_caja
            //                          set fecha_apertura = current_timestamp(),
            //                          monto_apertura = monto_apertura + ?,
            //                             estado = 1
            //                         where id = ?");

            //     $dbh->beginTransaction();
            //     $stmt->execute(array(
            //         $monto_apertura,
            //         $id_caja
            //     ));
            //     $dbh->commit();

            //     $respuesta["tipo_msj"] = "success";
            //     $respuesta["msj"] = "La caja se aperturó correctamente";
            // }
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al aperturar la caja " . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlRegistrarDevolucion($id_arqueo_caja, $descripcion_devolucion, $monto_devolucion)
    {

        try {

            $dbh = Conexion::conectar();

            $stmt = $dbh->prepare("insert into movimientos_arqueo_caja(id_arqueo_caja, id_tipo_movimiento, descripcion, monto)
                                        values(?, 1, ?, ?)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $id_arqueo_caja,
                $descripcion_devolucion,
                $monto_devolucion
            ));
            $dbh->commit();

            $stmt = $dbh->prepare("update arqueo_caja
                                    set devoluciones = (select sum(monto)  from movimientos_arqueo_caja where id_arqueo_caja = ? and id_tipo_movimiento = 1),
                                        monto_final = ifnull(monto_apertura,0) + ifnull(ingresos,0) - (ifnull(devoluciones,0) + ifnull(gastos,0))
                                where id = ?");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $id_arqueo_caja,
                $id_arqueo_caja,
            ));
            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "La devolución se registró correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al registrar la devolución " . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlRegistrarGasto($id_arqueo_caja, $descripcion_gasto, $monto_gasto)
    {

        try {

            $dbh = Conexion::conectar();

            $stmt = $dbh->prepare("insert into movimientos_arqueo_caja(id_arqueo_caja, id_tipo_movimiento, descripcion, monto)
                                        values(?, 2, ?, ?)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $id_arqueo_caja,
                $descripcion_gasto,
                $monto_gasto
            ));
            $dbh->commit();

            $stmt = $dbh->prepare("update arqueo_caja
                                    set gastos = (select sum(monto)  from movimientos_arqueo_caja where id_arqueo_caja = ? and id_tipo_movimiento = 2),
                                        monto_final = ifnull(monto_apertura,0) + ifnull(ingresos,0) - (ifnull(devoluciones,0) + ifnull(gastos,0))
                                where id = ?");

            $dbh->beginTransaction();
            $stmt->execute(array(
                $id_arqueo_caja,
                $id_arqueo_caja,
            ));
            $dbh->commit();

            $respuesta["tipo_msj"] = "success";
            $respuesta["msj"] = "El gasto se registró correctamente";
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta["tipo_msj"] = "error";
            $respuesta["msj"] = "Error al registrar el gasto " . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlObtenerDevoluciones($id_arqueo_caja, $draw)
    {

        $stmt = Conexion::conectar()->prepare('SELECT "" as opciones,
                                                        ac.id,
                                                        ac.descripcion,
                                                        ac.monto
                                                FROM movimientos_arqueo_caja ac
                                                where id_arqueo_caja = :id_arqueo_caja
                                                and id_tipo_movimiento = 1');

        $stmt->bindParam(":id_arqueo_caja", $id_arqueo_caja, PDO::PARAM_STR);

        $stmt->execute();

        $number_filter_row = $stmt->rowCount();

        $results = $stmt->fetchAll();

        $data = array();

        foreach ($results as $row) {
            $sub_array = array();
            $sub_array[] = $row['id'];
            $sub_array[] = $row['descripcion'];
            $sub_array[] = $row['monto'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare('SELECT *
                    FROM movimientos_arqueo_caja ac
                    where id_arqueo_caja = :id_arqueo_caja
                    and id_tipo_movimiento = 1');

        $stmt->bindParam(":id_arqueo_caja", $id_arqueo_caja, PDO::PARAM_STR);

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $output = array(
            'draw' => $draw,
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $output;
    }

    static public function mdlObtenerGastos($id_arqueo_caja, $draw)
    {

        $stmt = Conexion::conectar()->prepare('SELECT ac.id,ac.descripcion,ac.monto
                                                FROM movimientos_arqueo_caja ac
                                                where id_arqueo_caja = :id_arqueo_caja
                                                and id_tipo_movimiento = 2');

        $stmt->bindParam(":id_arqueo_caja", $id_arqueo_caja, PDO::PARAM_STR);

        $stmt->execute();

        $number_filter_row = $stmt->rowCount();

        $results = $stmt->fetchAll();

        $data = array();

        foreach ($results as $row) {
            $sub_array = array();
            $sub_array[] = $row['id'];
            $sub_array[] = $row['descripcion'];
            $sub_array[] = $row['monto'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare('SELECT *
                    FROM movimientos_arqueo_caja ac
                    where id_arqueo_caja = :id_arqueo_caja
                    and id_tipo_movimiento = 2');

        $stmt->bindParam(":id_arqueo_caja", $id_arqueo_caja, PDO::PARAM_STR);

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $output = array(
            'draw' => $draw,
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $output;
    }

    static public function mdlObtenerDatosEmisor($id_empresa)
    {
        $stmt = Conexion::conectar()->prepare("SELECT id_empresa, 
                                                        razon_social, 
                                                        nombre_comercial, 
                                                        id_tipo_documento as tipo_documento, 
                                                        ruc, 
                                                        direccion, 
                                                        simbolo_moneda, 
                                                        email, 
                                                        telefono, 
                                                        provincia, 
                                                        departamento, 
                                                        distrito, 
                                                        ubigeo, 
                                                        usuario_sol, 
                                                        clave_sol
                                                FROM empresas
                                                where id_empresa = :id_empresa");
        $stmt->bindParam(":id_empresa", $id_empresa, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }
}
