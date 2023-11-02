-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2023 a las 13:54:11
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mitiendaposfacturador`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ActualizarDetalleVenta` (IN `p_codigo_producto` VARCHAR(20), IN `p_cantidad` FLOAT, IN `p_id` INT)   BEGIN

 declare v_nro_boleta varchar(20);
 declare v_total_venta float;

/*
ACTUALIZAR EL STOCK DEL PRODUCTO QUE SEA MODIFICADO
......
.....
.......
*/

/*
ACTULIZAR CODIGO, CANTIDAD Y TOTAL DEL ITEM MODIFICADO
*/

 UPDATE venta_detalle 
 SET codigo_producto = p_codigo_producto, 
 cantidad = p_cantidad, 
 total_venta = (p_cantidad * (select precio_venta_producto from productos where codigo_producto = p_codigo_producto))
 WHERE id = p_id;
 
 set v_nro_boleta = (select nro_boleta from venta_detalle where id = p_id);
 set v_total_venta = (select sum(total_venta) from venta_detalle where nro_boleta = v_nro_boleta);
 
 update venta_cabecera
   set total_venta = v_total_venta
 where nro_boleta = v_nro_boleta;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_eliminar_venta` (IN `p_nro_boleta` VARCHAR(8))   BEGIN

DECLARE v_codigo VARCHAR(20);
DECLARE v_cantidad FLOAT;
DECLARE done INT DEFAULT FALSE;

DECLARE cursor_i CURSOR FOR 
SELECT codigo_producto,cantidad 
FROM venta_detalle 
where CAST(nro_boleta AS CHAR CHARACTER SET utf8)  = CAST(p_nro_boleta AS CHAR CHARACTER SET utf8) ;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN cursor_i;
read_loop: LOOP
FETCH cursor_i INTO v_codigo, v_cantidad;

	IF done THEN
	  LEAVE read_loop;
	END IF;
    
    UPDATE PRODUCTOS 
       SET stock_producto = stock_producto + v_cantidad
    WHERE CAST(codigo_producto AS CHAR CHARACTER SET utf8) = CAST(v_codigo AS CHAR CHARACTER SET utf8);
    
END LOOP;
CLOSE cursor_i;

DELETE FROM VENTA_DETALLE WHERE CAST(nro_boleta AS CHAR CHARACTER SET utf8) = CAST(p_nro_boleta AS CHAR CHARACTER SET utf8) ;
DELETE FROM VENTA_CABECERA WHERE CAST(nro_boleta AS CHAR CHARACTER SET utf8)  = CAST(p_nro_boleta AS CHAR CHARACTER SET utf8) ;

SELECT 'Se eliminó correctamente la venta';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarCategorias` ()   BEGIN
select * from categorias;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarProductos` ()   SELECT  '' as acciones,
		codigo_producto,
		p.id_categoria,
        
		upper(c.descripcion) as nombre_categoria,
		upper(p.descripcion) as producto,
        imagen,
        p.id_tipo_afectacion_igv,
        upper(tai.descripcion) as tipo_afectacion_igv,
        p.id_unidad_medida,
        upper(cum.descripcion) as unidad_medida,
		ROUND(costo_unitario,2) as costo_unitario,
		ROUND(precio_unitario_con_igv,2) as precio_unitario_con_igv,
        ROUND(precio_unitario_sin_igv,2) as precio_unitario_sin_igv,
        ROUND(precio_unitario_mayor_con_igv,2) as precio_unitario_mayor_con_igv,
        ROUND(precio_unitario_mayor_sin_igv,2) as precio_unitario_mayor_sin_igv,
        ROUND(precio_unitario_oferta_con_igv,2) as precio_unitario_oferta_con_igv,
        ROUND(precio_unitario_oferta_sin_igv,2) as precio_unitario_oferta_sin_igv,
		stock,
		minimo_stock,
		ventas,
		ROUND(costo_total,2) as costo_total,
		p.fecha_creacion,
		p.fecha_actualizacion,
        case when p.estado = 1 then 'ACTIVO' else 'INACTIVO' end estado
	FROM productos p INNER JOIN categorias c on p.id_categoria = c.id
					 inner join tipo_afectacion_igv tai on tai.codigo = p.id_tipo_afectacion_igv
					inner join codigo_unidad_medida cum on cum.id = p.id_unidad_medida
    WHERE p.estado in (0,1)
	order by p.codigo_producto desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarProductosMasVendidos` ()  NO SQL BEGIN

select  p.codigo_producto,
		p.descripcion,
        sum(vd.cantidad) as cantidad,
        sum(Round(vd.importe_total,2)) as total_venta
from detalle_venta vd inner join productos p on vd.codigo_producto = p.codigo_producto
group by p.codigo_producto,
		p.descripcion
order by  sum(Round(vd.importe_total,2)) DESC
limit 10;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarProductosPocoStock` ()  NO SQL BEGIN
select p.codigo_producto,
		p.descripcion,
        p.stock,
        p.minimo_stock
from productos p
where p.stock <= p.minimo_stock
order by p.stock asc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_movimentos_arqueo_caja_por_usuario` (`p_id_usuario` INT, `p_id_caja` INT)   BEGIN

	select 
	ac.monto_apertura as y,
	'APERTURA' as label,
	"#6c757d" as color
	from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
	where ac.id_usuario = p_id_usuario
    and ac.id = p_id_caja
	and date(ac.fecha_apertura) = curdate()
	union  
	select 
	ac.ingresos as y,
	'INGRESOS' as label,
	"#28a745" as color
	from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
	where ac.id_usuario = p_id_usuario
    and ac.id = p_id_caja
	and date(ac.fecha_apertura) = curdate()
	union
	select 
	ac.devoluciones as y,
	'DEVOLUCIONES' as label,
	"#ffc107" as color
	from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
	where ac.id_usuario = p_id_usuario
    and ac.id = p_id_caja
	and date(ac.fecha_apertura) = curdate()
	union
	select 
	ac.gastos as y,
	'GASTOS' as label,
	"#17a2b8" as color
	from arqueo_caja ac inner join usuarios usu on ac.id_usuario = usu.id_usuario
	where ac.id_usuario = p_id_usuario
    and ac.id = p_id_caja
	and date(ac.fecha_apertura) = curdate();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ObtenerDatosDashboard` ()  NO SQL BEGIN
  DECLARE totalProductos int;
  DECLARE totalCompras float;
  DECLARE totalVentas float;
  DECLARE ganancias float;
  DECLARE productosPocoStock int;
  DECLARE ventasHoy float;

  SET totalProductos = (SELECT
      COUNT(*)
    FROM productos p);
    
  SET totalCompras = (SELECT
      SUM(p.costo_total)
    FROM productos p);  

	SET totalVentas = 0;
  SET totalVentas = (SELECT
      SUM(v.importe_total)
    FROM venta v);

  SET ganancias = 0;
  SET ganancias = (SELECT
      SUM(dv.importe_total) - SUM(dv.cantidad * dv.costo_unitario)
    FROM detalle_venta dv);
    
  SET productosPocoStock = (SELECT
      COUNT(1)
    FROM productos p
    WHERE p.stock <= p.minimo_stock);
    
    SET ventasHoy = 0;
  SET ventasHoy = (SELECT
      SUM(v.importe_total)
    FROM venta v
    WHERE DATE(v.fecha_emision) = CURDATE());

  SELECT
    IFNULL(totalProductos, 0) AS totalProductos,
    IFNULL(CONCAT('S./ ', FORMAT(totalCompras, 2)), 0) AS totalCompras,
    IFNULL(CONCAT('S./ ', FORMAT(totalVentas, 2)), 0) AS totalVentas,
    IFNULL(CONCAT('S./ ', FORMAT(ganancias, 2), ' - ','  % ', FORMAT((ganancias / totalVentas) *100,2)), 0) AS ganancias,
    IFNULL(productosPocoStock, 0) AS productosPocoStock,
    IFNULL(CONCAT('S./ ', FORMAT(ventasHoy, 2)), 0) AS ventasHoy;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_obtenerNroBoleta` ()  NO SQL select serie_boleta,
		IFNULL(LPAD(max(c.nro_correlativo_venta)+1,8,'0'),'00000001') nro_venta 
from empresa c$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ObtenerVentasMesActual` ()  NO SQL BEGIN
SELECT date(vc.fecha_emision) as fecha_venta,
		sum(round(vc.importe_total,2)) as total_venta,
        ifnull((SELECT sum(round(vc1.importe_total,2))
			FROM venta vc1
		where date(vc1.fecha_emision) >= date(last_day(now() - INTERVAL 2 month) + INTERVAL 1 day)
		and date(vc1.fecha_emision) <= last_day(last_day(now() - INTERVAL 2 month) + INTERVAL 1 day)
        and date(vc1.fecha_emision) = DATE_ADD(date(vc.fecha_emision), INTERVAL -1 MONTH)
		group by date(vc1.fecha_emision)),0) as total_venta_ant
FROM venta vc
where date(vc.fecha_emision) >= date(last_day(now() - INTERVAL 1 month) + INTERVAL 1 day)
and date(vc.fecha_emision) <= last_day(date(CURRENT_DATE))
group by date(vc.fecha_emision);


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ObtenerVentasMesAnterior` ()  NO SQL BEGIN
SELECT date(vc.fecha_venta) as fecha_venta,
		sum(round(vc.total_venta,2)) as total_venta,
        sum(round(vc.total_venta,2)) as total_venta_ant
FROM venta_cabecera vc
where date(vc.fecha_venta) >= date(last_day(now() - INTERVAL 2 month) + INTERVAL 1 day)
and date(vc.fecha_venta) <= last_day(last_day(now() - INTERVAL 2 month) + INTERVAL 1 day)
group by date(vc.fecha_venta);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_anulacion` (IN `p_id_venta` INT, IN `p_codigo_producto` VARCHAR(20))   BEGIN

	/*VARIABLES PARA EXISTENCIAS ACTUALES*/
	declare v_unidades_ex float;
	declare v_costo_unitario_ex float;    
	declare v_costo_total_ex float;
    
    declare v_unidades_in float;
	declare v_costo_unitario_in float;    
	declare v_costo_total_in float;
    
    declare v_cantidad_devolucion float;
	declare v_costo_unitario_devolucion float;   
    declare v_comprobante_devolucion varchar(20);   
    declare v_concepto_devolucion varchar(50);   
    
	/*OBTENEMOS LAS ULTIMAS EXISTENCIAS DEL PRODUCTO*/    
    SELECT k.ex_costo_unitario , k.ex_unidades, k.ex_costo_total
    into v_costo_unitario_ex, v_unidades_ex, v_costo_total_ex
    FROM KARDEX K
    WHERE K.CODIGO_PRODUCTO = p_codigo_producto
    ORDER BY ID DESC
    LIMIT 1;
    
    select   cantidad, 
			costo_unitario,
			concat(v.serie,'-',v.correlativo) as comprobante,
			'DEVOLUCIÓN' as concepto
	  into v_cantidad_devolucion, v_costo_unitario_devolucion,
			v_comprobante_devolucion, v_concepto_devolucion 
	from detalle_venta dv inner join venta v on dv.id_venta = v.id
    where dv.id_venta = p_id_venta and dv.codigo_producto = p_codigo_producto;
    
      /*SETEAMOS LOS VALORES PARA EL REGISTRO DE INGRESO*/
    SET v_unidades_in = v_cantidad_devolucion;
    SET v_costo_unitario_in = v_costo_unitario_devolucion;
    SET v_costo_total_in = v_unidades_in * v_costo_unitario_in;
    
    /*SETEAMOS LAS EXISTENCIAS ACTUALES*/
    SET v_unidades_ex = v_unidades_ex + ROUND(v_cantidad_devolucion,2);    
    SET v_costo_total_ex = ROUND(v_costo_total_ex + v_costo_total_in,2);
    SET v_costo_unitario_ex = ROUND(v_costo_total_ex/v_unidades_ex,2);


	INSERT INTO KARDEX(codigo_producto,
						fecha,
                        concepto,
                        comprobante,
                        in_unidades,
                        in_costo_unitario,
                        in_costo_total,
                        ex_unidades,
                        ex_costo_unitario,
                        ex_costo_total)
				VALUES(p_codigo_producto,
						curdate(),
                        v_concepto_devolucion,
                        v_comprobante_devolucion,
                        v_unidades_in,
                        v_costo_unitario_in,
                        v_costo_total_in,
                        v_unidades_ex,
                        v_costo_unitario_ex,
                        v_costo_total_ex);

	/*ACTUALIZAMOS EL STOCK, EL NRO DE VENTAS DEL PRODUCTO*/
	UPDATE PRODUCTOS 
	SET stock = v_unidades_ex, 
         costo_unitario = v_costo_unitario_ex,
         costo_total= v_costo_total_ex
	WHERE codigo_producto = p_codigo_producto ;  

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_bono` (IN `p_codigo_producto` VARCHAR(20), IN `p_concepto` VARCHAR(100), IN `p_nuevo_stock` FLOAT)   BEGIN

	/*VARIABLES PARA EXISTENCIAS ACTUALES*/
	declare v_unidades_ex float;
	declare v_costo_unitario_ex float;    
	declare v_costo_total_ex float;
    
    declare v_unidades_in float;
	declare v_costo_unitario_in float;    
	declare v_costo_total_in float;
    
	/*OBTENEMOS LAS ULTIMAS EXISTENCIAS DEL PRODUCTO*/    
    SELECT k.ex_costo_unitario , k.ex_unidades, k.ex_costo_total
    into v_costo_unitario_ex, v_unidades_ex, v_costo_total_ex
    FROM KARDEX K
    WHERE K.CODIGO_PRODUCTO = p_codigo_producto
    ORDER BY ID DESC
    LIMIT 1;
    
    /*SETEAMOS LOS VALORES PARA EL REGISTRO DE INGRESO*/
    SET v_unidades_in = p_nuevo_stock - v_unidades_ex;
    SET v_costo_unitario_in = v_costo_unitario_ex;
    SET v_costo_total_in = v_unidades_in * v_costo_unitario_in;
    
    /*SETEAMOS LAS EXISTENCIAS ACTUALES*/
    SET v_unidades_ex = ROUND(p_nuevo_stock,2);    
    SET v_costo_total_ex = ROUND(v_costo_total_ex + v_costo_total_in,2);
    
    IF(v_costo_total_ex > 0) THEN
		SET v_costo_unitario_ex = ROUND(v_costo_total_ex/v_unidades_ex,2);
	else
		SET v_costo_unitario_ex = ROUND(0,2);
    END IF;
    
        
	INSERT INTO KARDEX(codigo_producto,
						fecha,
                        concepto,
                        comprobante,
                        in_unidades,
                        in_costo_unitario,
                        in_costo_total,
                        ex_unidades,
                        ex_costo_unitario,
                        ex_costo_total)
				VALUES(p_codigo_producto,
						curdate(),
                        p_concepto,
                        '',
                        v_unidades_in,
                        v_costo_unitario_in,
                        v_costo_total_in,
                        v_unidades_ex,
                        v_costo_unitario_ex,
                        v_costo_total_ex);

	/*ACTUALIZAMOS EL STOCK, EL NRO DE VENTAS DEL PRODUCTO*/
	UPDATE PRODUCTOS 
	SET stock = v_unidades_ex, 
         costo_unitario = v_costo_unitario_ex,
         costo_total= v_costo_total_ex
	WHERE codigo_producto = p_codigo_producto ;                      

END$$

CREATE PROCEDURE `prc_registrar_kardex_compra` (IN `p_id_compra` INT, IN `p_comprobante` VARCHAR(20), IN `p_codigo_producto` VARCHAR(20), IN `p_concepto` VARCHAR(100), IN `p_cantidad_compra` FLOAT, IN `p_costo_compra` FLOAT)   BEGIN

	/*VARIABLES PARA EXISTENCIAS ACTUALES*/
	declare v_unidades_ex float;
	declare v_costo_unitario_ex float;    
	declare v_costo_total_ex float;
    
    declare v_unidades_in float;
	declare v_costo_unitario_in float;    
	declare v_costo_total_in float;
    
	/*OBTENEMOS LAS ULTIMAS EXISTENCIAS DEL PRODUCTO*/    
    SELECT k.ex_costo_unitario , k.ex_unidades, k.ex_costo_total
    into v_costo_unitario_ex, v_unidades_ex, v_costo_total_ex
    FROM kardex k
    WHERE k.codigo_producto = p_codigo_producto
    ORDER BY id DESC
    LIMIT 1;
    
    /*SETEAMOS LOS VALORES PARA EL REGISTRO DE INGRESO*/
    SET v_unidades_in = p_cantidad_compra;
    SET v_costo_unitario_in = p_costo_compra;
    SET v_costo_total_in = v_unidades_in * v_costo_unitario_in;
    
    /*SETEAMOS LAS EXISTENCIAS ACTUALES*/
    SET v_unidades_ex = v_unidades_ex + ROUND(p_cantidad_compra,2);    
    SET v_costo_total_ex = ROUND(v_costo_total_ex + v_costo_total_in,2);
    SET v_costo_unitario_ex = ROUND(v_costo_total_ex/v_unidades_ex,2);

	INSERT INTO kardex(codigo_producto,
						fecha,
                        concepto,
                        comprobante,
                        in_unidades,
                        in_costo_unitario,
                        in_costo_total,
                        ex_unidades,
                        ex_costo_unitario,
                        ex_costo_total)
				VALUES(p_codigo_producto,
						curdate(),
                        p_concepto,
                        p_comprobante,
                        v_unidades_in,
                        v_costo_unitario_in,
                        v_costo_total_in,
                        v_unidades_ex,
                        v_costo_unitario_ex,
                        v_costo_total_ex);

	/*ACTUALIZAMOS EL STOCK, EL NRO DE VENTAS DEL PRODUCTO*/
	UPDATE productos 
	SET stock = v_unidades_ex, 
         costo_unitario = v_costo_unitario_ex,
         costo_total= v_costo_total_ex
	WHERE codigo_producto = p_codigo_producto ;  
  

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_existencias` (IN `p_codigo_producto` VARCHAR(25), IN `p_concepto` VARCHAR(100), IN `p_comprobante` VARCHAR(100), IN `p_unidades` FLOAT, IN `p_costo_unitario` FLOAT, IN `p_costo_total` FLOAT)   BEGIN
  INSERT INTO kardex (codigo_producto, fecha, concepto, comprobante, in_unidades, in_costo_unitario, in_costo_total,ex_unidades, ex_costo_unitario, ex_costo_total)
    VALUES (p_codigo_producto, CURDATE(), p_concepto, p_comprobante, p_unidades, p_costo_unitario, p_costo_total, p_unidades, p_costo_unitario, p_costo_total);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_vencido` (IN `p_codigo_producto` VARCHAR(20), IN `p_concepto` VARCHAR(100), IN `p_nuevo_stock` FLOAT)   BEGIN

	declare v_unidades_ex float;
	declare v_costo_unitario_ex float;    
	declare v_costo_total_ex float;
    
    declare v_unidades_out float;
	declare v_costo_unitario_out float;    
	declare v_costo_total_out float;
    
	/*OBTENEMOS LAS ULTIMAS EXISTENCIAS DEL PRODUCTO*/    
    SELECT k.ex_costo_unitario , k.ex_unidades, k.ex_costo_total
    into v_costo_unitario_ex, v_unidades_ex, v_costo_total_ex
    FROM KARDEX K
    WHERE K.CODIGO_PRODUCTO = p_codigo_producto
    ORDER BY ID DESC
    LIMIT 1;
    
    /*SETEAMOS LOS VALORES PARA EL REGISTRO DE SALIDA*/
    SET v_unidades_out = v_unidades_ex - p_nuevo_stock;
    SET v_costo_unitario_out = v_costo_unitario_ex;
    SET v_costo_total_out = v_unidades_out * v_costo_unitario_out;
    
    /*SETEAMOS LAS EXISTENCIAS ACTUALES*/
    SET v_unidades_ex = ROUND(p_nuevo_stock,2);    
    SET v_costo_total_ex = ROUND(v_costo_total_ex - v_costo_total_out,2);
    
    IF(v_costo_total_ex > 0) THEN
		SET v_costo_unitario_ex = ROUND(v_costo_total_ex/v_unidades_ex,2);
	else
		SET v_costo_unitario_ex = ROUND(0,2);
    END IF;
    
        
	INSERT INTO KARDEX(codigo_producto,
						fecha,
                        concepto,
                        comprobante,
                        out_unidades,
                        out_costo_unitario,
                        out_costo_total,
                        ex_unidades,
                        ex_costo_unitario,
                        ex_costo_total)
				VALUES(p_codigo_producto,
						curdate(),
                        p_concepto,
                        '',
                        v_unidades_out,
                        v_costo_unitario_out,
                        v_costo_total_out,
                        v_unidades_ex,
                        v_costo_unitario_ex,
                        v_costo_total_ex);

	/*ACTUALIZAMOS EL STOCK, EL NRO DE VENTAS DEL PRODUCTO*/
	UPDATE PRODUCTOS 
	SET stock = v_unidades_ex, 
         costo_unitario = v_costo_unitario_ex,
        costo_total = v_costo_total_ex
	WHERE codigo_producto = p_codigo_producto ;                      

END$$

CREATE PROCEDURE `prc_registrar_kardex_venta` (IN `p_codigo_producto` VARCHAR(20), IN `p_fecha` DATE, IN `p_concepto` VARCHAR(100), IN `p_comprobante` VARCHAR(100), IN `p_unidades` FLOAT)   BEGIN

	declare v_unidades_ex float;
	declare v_costo_unitario_ex float;    
	declare v_costo_total_ex float;
    
    declare v_unidades_out float;
	declare v_costo_unitario_out float;    
	declare v_costo_total_out float;
    

	/*OBTENEMOS LAS ULTIMAS EXISTENCIAS DEL PRODUCTO*/
    
    SELECT k.ex_costo_unitario , k.ex_unidades, k.ex_costo_total
    into v_costo_unitario_ex, v_unidades_ex, v_costo_total_ex
    FROM kardex k
    WHERE k.codigo_producto = p_codigo_producto
    ORDER BY id DESC
    LIMIT 1;
    
    /*SETEAMOS LOS VALORES PARA EL REGISTRO DE SALIDA*/
    SET v_unidades_out = p_unidades;
    SET v_costo_unitario_out = v_costo_unitario_ex;
    SET v_costo_total_out = p_unidades * v_costo_unitario_ex;
    
    /*SETEAMOS LAS EXISTENCIAS ACTUALES*/
    SET v_unidades_ex = ROUND(v_unidades_ex - v_unidades_out,2);    
    SET v_costo_total_ex = ROUND(v_costo_total_ex -  v_costo_total_out,2);
    
    IF(v_costo_total_ex > 0) THEN
		SET v_costo_unitario_ex = ROUND(v_costo_total_ex/v_unidades_ex,2);
	else
		SET v_costo_unitario_ex = ROUND(0,2);
    END IF;
    
        
	INSERT INTO kardex(codigo_producto,
						fecha,
                        concepto,
                        comprobante,
                        out_unidades,
                        out_costo_unitario,
                        out_costo_total,
                        ex_unidades,
                        ex_costo_unitario,
                        ex_costo_total)
				VALUES(p_codigo_producto,
						p_fecha,
                        p_concepto,
                        p_comprobante,
                        v_unidades_out,
                        v_costo_unitario_out,
                        v_costo_total_out,
                        v_unidades_ex,
                        v_costo_unitario_ex,
                        v_costo_total_ex);

	/*ACTUALIZAMOS EL STOCK, EL NRO DE VENTAS DEL PRODUCTO*/
	UPDATE productos 
	SET stock = v_unidades_ex, 
		ventas = ventas + v_unidades_out,
        costo_unitario = v_costo_unitario_ex,
        costo_total = v_costo_total_ex
	WHERE codigo_producto = p_codigo_producto ;                      

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_venta_detalle` (IN `p_nro_boleta` VARCHAR(8), IN `p_codigo_producto` VARCHAR(20), IN `p_cantidad` FLOAT, IN `p_total_venta` FLOAT)   BEGIN
declare v_precio_compra float;
declare v_precio_venta float;

SELECT p.precio_compra_producto,p.precio_venta_producto
into v_precio_compra, v_precio_venta
FROM productos p
WHERE p.codigo_producto  = p_codigo_producto;
    
INSERT INTO venta_detalle(nro_boleta,codigo_producto, cantidad, costo_unitario_venta,precio_unitario_venta,total_venta, fecha_venta) 
VALUES(p_nro_boleta,p_codigo_producto,p_cantidad, v_precio_compra, v_precio_venta,p_total_venta,curdate());
                                                        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_top_ventas_categorias` ()   BEGIN

select cast(sum(vd.importe_total)  AS DECIMAL(8,2)) as y, c.descripcion as label
    from detalle_venta vd inner join productos p on vd.codigo_producto = p.codigo_producto
                        inner join categorias c on c.id = p.id_categoria
    group by c.descripcion
    LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_truncate_all_tables` ()   BEGIN

SET FOREIGN_KEY_CHECKS = 0;

truncate table venta;
truncate table detalle_venta;
truncate table cuotas;

truncate table resumenes;
truncate table resumenes_detalle;


truncate table compras;
truncate table detalle_compra;

truncate table kardex;

truncate table categorias;

truncate table tipo_afectacion_igv;

truncate table codigo_unidad_medida;

truncate table arqueo_caja;
truncate table movimientos_arqueo_caja;

truncate table proveedores;
truncate table clientes;

truncate table productos;

SET FOREIGN_KEY_CHECKS = 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `arqueo_caja`
--

CREATE TABLE `arqueo_caja` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_apertura` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_cierre` datetime DEFAULT NULL,
  `monto_apertura` float NOT NULL,
  `ingresos` float DEFAULT NULL,
  `devoluciones` float DEFAULT NULL,
  `gastos` float DEFAULT NULL,
  `monto_final` float DEFAULT NULL,
  `monto_real` float DEFAULT NULL,
  `sobrante` float DEFAULT NULL,
  `faltante` float DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `arqueo_caja`
--

INSERT INTO `arqueo_caja` (`id`, `id_usuario`, `fecha_apertura`, `fecha_cierre`, `monto_apertura`, `ingresos`, `devoluciones`, `gastos`, `monto_final`, `monto_real`, `sobrante`, `faltante`, `estado`) VALUES
(1, 1, '2023-10-24 13:39:39', NULL, 50, 33.89, NULL, NULL, 83.89, NULL, NULL, NULL, 0),
(2, 1, '2023-10-24 01:25:43', '2023-10-25 12:02:24', 50, 0, 0, 0, 0, 5, 5, 0, 0),
(3, 1, '2023-10-24 12:02:50', '2023-10-25 12:04:12', 50, 0, 0, 0, 0, 10, 10, 0, 0),
(4, 1, '2023-10-24 12:21:09', '2023-10-25 12:29:25', 180, 0, 0, 0, 0, 251.13, 0, 0, 0),
(5, 1, '2023-10-25 12:29:30', '2023-10-25 12:29:43', 180, 0, 0, 0, 180, 180, 0, 0, 0),
(6, 1, '2023-10-25 12:33:14', '2023-10-25 12:33:23', 14, 0, 0, 0, 14, 14, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

CREATE TABLE `cajas` (
  `id` int(11) NOT NULL,
  `nombre_caja` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `cajas`
--

INSERT INTO `cajas` (`id`, `nombre_caja`, `estado`) VALUES
(1, 'Sin Caja', 1),
(2, 'Caja Barrancio Mod 1', 1),
(3, 'Caja Barrancio Mod 2', 1),
(4, 'Caja Barrancio Mod 3', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `descripcion`, `fecha_creacion`, `fecha_actualizacion`, `estado`) VALUES
(1, 'Frutas', '2023-10-24 18:39:24', NULL, 1),
(2, 'Verduras', '2023-10-24 18:39:24', NULL, 1),
(3, 'Snack', '2023-10-24 18:39:24', NULL, 1),
(4, 'Avena', '2023-10-24 18:39:24', NULL, 1),
(5, 'Energizante', '2023-10-24 18:39:24', NULL, 1),
(6, 'Jugo', '2023-10-24 18:39:24', NULL, 1),
(7, 'Refresco', '2023-10-24 18:39:24', NULL, 1),
(8, 'Mantequilla', '2023-10-24 18:39:24', NULL, 1),
(9, 'Gaseosa', '2023-10-24 18:39:24', NULL, 1),
(10, 'Aceite', '2023-10-24 18:39:24', NULL, 1),
(11, 'Yogurt', '2023-10-24 18:39:24', NULL, 1),
(12, 'Arroz', '2023-10-24 18:39:24', NULL, 1),
(13, 'Leche', '2023-10-24 18:39:24', NULL, 1),
(14, 'Papel Higiénico', '2023-10-24 18:39:24', NULL, 1),
(15, 'Atún', '2023-10-24 18:39:24', NULL, 1),
(16, 'Chocolate', '2023-10-24 18:39:24', NULL, 1),
(17, 'Wafer', '2023-10-24 18:39:24', NULL, 1),
(18, 'Golosina', '2023-10-24 18:39:24', NULL, 1),
(19, 'Galletas', '2023-10-24 18:39:24', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `id_tipo_documento` int(11) DEFAULT NULL,
  `nro_documento` varchar(20) DEFAULT NULL,
  `nombres_apellidos_razon_social` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `id_tipo_documento`, `nro_documento`, `nombres_apellidos_razon_social`, `direccion`, `telefono`, `estado`) VALUES
(1, 6, '20108808749', 'INFORMATICA DEL NORTE S.A.', 'AV. LA LIBERTAD NRO 815 INT. 1 URB. SANTA VICTORIA ', '', 1),
(2, 0, '99999999', 'CLIENTES VARIOS', '-', '-', 1),
(3, 1, '45257895', 'LUIS ANGEL LOZANO ARICA', 'CALLE BUENAVENTURA AGUIRRE 302', '978451245', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigo_unidad_medida`
--

CREATE TABLE `codigo_unidad_medida` (
  `id` varchar(3) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `codigo_unidad_medida`
--

INSERT INTO `codigo_unidad_medida` (`id`, `descripcion`, `estado`) VALUES
('BO', 'BOTELLAS', 1),
('BX', 'CAJA', 1),
('DZN', 'DOCENA', 1),
('KGM', 'KILOGRAMO', 1),
('LTR', 'LITRO', 1),
('MIL', 'MILLARES', 1),
('NIU', 'UNIDAD', 1),
('PK', 'PAQUETE', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `fecha_compra` datetime DEFAULT NULL,
  `id_tipo_comprobante` varchar(3) DEFAULT NULL,
  `serie` varchar(10) DEFAULT NULL,
  `correlativo` varchar(20) DEFAULT NULL,
  `id_moneda` varchar(3) DEFAULT NULL,
  `ope_exonerada` float DEFAULT NULL,
  `ope_inafecta` float DEFAULT NULL,
  `ope_gravada` float DEFAULT NULL,
  `total_igv` float DEFAULT NULL,
  `descuento` float DEFAULT NULL,
  `total_compra` float DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas`
--

CREATE TABLE `cuotas` (
  `id` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `cuota` varchar(3) DEFAULT NULL,
  `importe` decimal(15,6) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `cuotas`
--

INSERT INTO `cuotas` (`id`, `id_venta`, `cuota`, `importe`, `fecha_vencimiento`, `estado`) VALUES
(1, 1, '1', 43.330000, '2023-10-24', '1'),
(2, 9, '1', 20.000000, '2023-10-25', '1'),
(3, 9, '2', 28.710000, '2023-11-03', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id` int(11) NOT NULL,
  `id_compra` int(11) DEFAULT NULL,
  `codigo_producto` varchar(20) DEFAULT NULL,
  `cantidad` float DEFAULT NULL,
  `costo_unitario` float DEFAULT NULL,
  `descuento` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `impuesto` float DEFAULT NULL,
  `total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `item` int(11) DEFAULT NULL,
  `codigo_producto` varchar(20) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `porcentaje_igv` float DEFAULT NULL,
  `cantidad` float DEFAULT NULL,
  `costo_unitario` float DEFAULT NULL,
  `valor_unitario` float DEFAULT NULL,
  `precio_unitario` float DEFAULT NULL,
  `valor_total` float DEFAULT NULL,
  `igv` float DEFAULT NULL,
  `importe_total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id`, `id_venta`, `item`, `codigo_producto`, `descripcion`, `porcentaje_igv`, `cantidad`, `costo_unitario`, `valor_unitario`, `precio_unitario`, `valor_total`, `igv`, `importe_total`) VALUES
(1, 1, 1, '7755139002873', 'Battimix', 18, 12, 2.89, 3.06, 3.61, 36.72, 6.61, 43.33),
(2, 2, 1, '7755139002830', 'Big cola 400ml', 18, 1, 1, 1.06, 1.25, 1.06, 0.19, 1.25),
(3, 3, 1, '7755139002877', 'A1 Trozos', 18, 1, 5.17, 5.48, 6.47, 5.48, 0.99, 6.47),
(4, 4, 1, '7755139002873', 'Battimix', 18, 1, 2.89, 3.06, 3.61, 3.06, 0.55, 3.61),
(5, 5, 1, '7755139002873', 'Battimix', 18, 1, 2.89, 3.06, 3.61, 3.06, 0.55, 3.61),
(6, 6, 1, '7755139002873', 'Battimix', 18, 1, 2.89, 3.06, 3.61, 3.06, 0.55, 3.61),
(7, 7, 1, '7755139002873', 'Battimix', 18, 1, 2.89, 3.06, 3.61, 3.06, 0.55, 3.61),
(8, 8, 1, '7755139002873', 'Battimix', 18, 1, 2.89, 3.06, 3.61, 3.06, 0.55, 3.61),
(9, 9, 1, '7755139002870', 'Canchita natural', 18, 12, 3.25, 3.44, 4.06, 41.28, 7.43, 48.71),
(10, 10, 1, '7755139002870', 'Canchita natural', 18, 1, 3.25, 3.44, 4.06, 3.44, 0.62, 4.06),
(11, 11, 1, '7755139002870', 'Canchita natural', 18, 1, 3.25, 3.44, 4.06, 3.44, 0.62, 4.06),
(12, 12, 1, '7755139002877', 'A1 Trozos', 18, 11, 5.17, 5.48, 6.47, 60.28, 10.85, 71.13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL,
  `razon_social` text NOT NULL,
  `nombre_comercial` varchar(255) DEFAULT NULL,
  `id_tipo_documento` varchar(20) DEFAULT NULL,
  `ruc` bigint(20) NOT NULL,
  `direccion` text NOT NULL,
  `simbolo_moneda` varchar(5) DEFAULT NULL,
  `email` text NOT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `departamento` varchar(100) DEFAULT NULL,
  `distrito` varchar(100) DEFAULT NULL,
  `ubigeo` varchar(6) DEFAULT NULL,
  `certificado_digital` varchar(255) DEFAULT NULL,
  `clave_certificado` varchar(45) DEFAULT NULL,
  `usuario_sol` varchar(45) DEFAULT NULL,
  `clave_sol` varchar(45) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `razon_social`, `nombre_comercial`, `id_tipo_documento`, `ruc`, `direccion`, `simbolo_moneda`, `email`, `telefono`, `provincia`, `departamento`, `distrito`, `ubigeo`, `certificado_digital`, `clave_certificado`, `usuario_sol`, `clave_sol`, `estado`) VALUES
(1, '3D INVERSIONES Y SERVICIOS GENERALES E.I.R.L.	', '3D INVERSIONES Y SERVICIOS GENERALES E.I.R.L.	', '6', 10467291240, 'CALLE BUENAVENTURA AGUIRRE 302 ', 'S/ ', 'cfredes@innred.cl', '+56983851526 - +56999688639', 'LIMA', 'LIMA', 'BARRANCO', '150104', 'LLAMA-PE-CERTIFICADO-DEMO-20480674414.pfx', '123456', 'moddatos', 'moddatos', 1),
(2, 'NEGOCIOS WAIMAKU \" E.I.R.L', 'NEGOCIOS WAIMAKU \" E.I.R.L', '6', 20480674414, 'AV GRAU 123', 'S/', 'audio@gmail.com', '987654321', 'LIMA', 'LIMA', 'BARRANCO', '787878', 'LLAMA-PE-CERTIFICADO-DEMO-20494099153.pfx', '123456', 'moddatos', 'moddatos', 1),
(3, 'IMPORTACIONES FVC EIRL', 'IMPORTACIONES FVC EIRL', '6', 20494099153, 'CALLE LIMA 123', 'S/', 'empresa@gmail.com', '987654321', 'LIMA', 'LIMA', 'JESUS MARIA', '124545', 'LLAMA-PE-CERTIFICADO-DEMO-20480674414.pfx', '123456', 'moddatos', 'moddatos', 1),
(10, 'TUTORIALESPHPERU SAC', 'TUTOTIALESPHPERU SOLUCIONES WEB', '6', 10467291241, 'CALLE BUENAVENTURA AGUIRRE 302', NULL, 'tutorialesphperu@gmail.com', '978451245', 'LIMA', 'LIMA', 'BARRANCO', '121245', 'certificado_phperu.pfx', 'Emilia1109$', 'moddatos', 'moddatos', 1),
(15, 'Luis Lozano', 'LUIS LOZANO ARICA', '6', 10452578951, 'CALLE FALSA 123', NULL, '', '', 'LIMA', 'LIMA', 'LIMA', '123456', 'LLAMA-PE-CERTIFICADO-DEMO-20480674414.pfx', '123456', '', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `forma_pago`
--

CREATE TABLE `forma_pago` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `forma_pago`
--

INSERT INTO `forma_pago` (`id`, `descripcion`, `estado`) VALUES
(1, 'Contado', 1),
(2, 'Crédito', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestos`
--

CREATE TABLE `impuestos` (
  `id_tipo_operacion` int(11) NOT NULL,
  `impuesto` float DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `impuestos`
--

INSERT INTO `impuestos` (`id_tipo_operacion`, `impuesto`, `estado`) VALUES
(10, 18, 1),
(20, 0, 1),
(30, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE `kardex` (
  `id` int(11) NOT NULL,
  `codigo_producto` varchar(20) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `concepto` varchar(100) DEFAULT NULL,
  `comprobante` varchar(50) DEFAULT NULL,
  `in_unidades` float DEFAULT NULL,
  `in_costo_unitario` float DEFAULT NULL,
  `in_costo_total` float DEFAULT NULL,
  `out_unidades` float DEFAULT NULL,
  `out_costo_unitario` float DEFAULT NULL,
  `out_costo_total` float DEFAULT NULL,
  `ex_unidades` float DEFAULT NULL,
  `ex_costo_unitario` float DEFAULT NULL,
  `ex_costo_total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `kardex`
--

INSERT INTO `kardex` (`id`, `codigo_producto`, `fecha`, `concepto`, `comprobante`, `in_unidades`, `in_costo_unitario`, `in_costo_total`, `out_unidades`, `out_costo_unitario`, `out_costo_total`, `ex_unidades`, `ex_costo_unitario`, `ex_costo_total`) VALUES
(1, '7755139002890', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 5.9, 141.6, NULL, NULL, NULL, 24, 5.9, 141.6),
(2, '7755139002903', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 12.1, 278.3, NULL, NULL, NULL, 23, 12.1, 278.3),
(3, '7755139002904', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 12.4, 359.6, NULL, NULL, NULL, 29, 12.4, 359.6),
(4, '7755139002870', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 3.25, 84.5, NULL, NULL, NULL, 26, 3.25, 84.5),
(5, '7755139002880', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 5.15, 118.45, NULL, NULL, NULL, 23, 5.15, 118.45),
(6, '7755139002902', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 9.8, 284.2, NULL, NULL, NULL, 29, 9.8, 284.2),
(7, '7755139002898', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 7.49, 202.23, NULL, NULL, NULL, 27, 7.49, 202.23),
(8, '7755139002899', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 8, 208, NULL, NULL, NULL, 26, 8, 208),
(9, '7755139002901', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 10, 260, NULL, NULL, NULL, 26, 10, 260),
(10, '7755139002810', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 3.79, 79.59, NULL, NULL, NULL, 21, 3.79, 79.59),
(11, '7755139002878', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 3.99, 99.75, NULL, NULL, NULL, 25, 3.99, 99.75),
(12, '7755139002838', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 1.29, 34.83, NULL, NULL, NULL, 27, 1.29, 34.83),
(13, '7755139002839', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 1, 27, NULL, NULL, NULL, 27, 1, 27),
(14, '7755139002848', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 1.9, 47.5, NULL, NULL, NULL, 25, 1.9, 47.5),
(15, '7755139002863', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 2.8, 75.6, NULL, NULL, NULL, 27, 2.8, 75.6),
(16, '7755139002864', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 20, 4.4, 88, NULL, NULL, NULL, 20, 4.4, 88),
(17, '7755139002865', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 3.79, 87.17, NULL, NULL, NULL, 23, 3.79, 87.17),
(18, '7755139002866', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 3.79, 98.54, NULL, NULL, NULL, 26, 3.79, 98.54),
(19, '7755139002867', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 3.65, 87.6, NULL, NULL, NULL, 24, 3.65, 87.6),
(20, '7755139002868', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 20, 3.5, 70, NULL, NULL, NULL, 20, 3.5, 70),
(21, '7755139002871', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 3.17, 85.59, NULL, NULL, NULL, 27, 3.17, 85.59),
(22, '7755139002877', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 30, 5.17, 155.1, NULL, NULL, NULL, 30, 5.17, 155.1),
(23, '7755139002879', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 4.58, 128.24, NULL, NULL, NULL, 28, 4.58, 128.24),
(24, '7755139002881', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 5, 110, NULL, NULL, NULL, 22, 5, 110),
(25, '7755139002882', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 4.66, 125.82, NULL, NULL, NULL, 27, 4.66, 125.82),
(26, '7755139002883', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 4.65, 106.95, NULL, NULL, NULL, 23, 4.65, 106.95),
(27, '7755139002884', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 4.63, 97.23, NULL, NULL, NULL, 21, 4.63, 97.23),
(28, '7755139002885', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 5.7, 153.9, NULL, NULL, NULL, 27, 5.7, 153.9),
(29, '7755139002887', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 6.08, 164.16, NULL, NULL, NULL, 27, 6.08, 164.16),
(30, '7755139002888', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 5.9, 129.8, NULL, NULL, NULL, 22, 5.9, 129.8),
(31, '7755139002889', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 5.9, 165.2, NULL, NULL, NULL, 28, 5.9, 165.2),
(32, '7755139002891', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 5.9, 171.1, NULL, NULL, NULL, 29, 5.9, 171.1),
(33, '7755139002892', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 5.08, 106.68, NULL, NULL, NULL, 21, 5.08, 106.68),
(34, '7755139002893', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 5.63, 163.27, NULL, NULL, NULL, 29, 5.63, 163.27),
(35, '7755139002895', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 5.9, 171.1, NULL, NULL, NULL, 29, 5.9, 171.1),
(36, '7755139002896', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 5.9, 159.3, NULL, NULL, NULL, 27, 5.9, 159.3),
(37, '7755139002897', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 5.33, 117.26, NULL, NULL, NULL, 22, 5.33, 117.26),
(38, '7755139002900', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 8.9, 186.9, NULL, NULL, NULL, 21, 8.9, 186.9),
(39, '7755139002886', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 5.7, 119.7, NULL, NULL, NULL, 21, 5.7, 119.7),
(40, '7755139002809', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 18.29, 384.09, NULL, NULL, NULL, 21, 18.29, 384.09),
(41, '7755139002874', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 2.8, 78.4, NULL, NULL, NULL, 28, 2.8, 78.4),
(42, '7755139002830', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 20, 1, 20, NULL, NULL, NULL, 20, 1, 20),
(43, '7755139002869', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 3.25, 68.25, NULL, NULL, NULL, 21, 3.25, 68.25),
(44, '7755139002872', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 30, 3.1, 93, NULL, NULL, NULL, 30, 3.1, 93),
(45, '7755139002876', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 3.39, 71.19, NULL, NULL, NULL, 21, 3.39, 71.19),
(46, '7755139002852', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 20, 1.3, 26, NULL, NULL, NULL, 20, 1.3, 26),
(47, '7755139002853', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 1.99, 55.72, NULL, NULL, NULL, 28, 1.99, 55.72),
(48, '7755139002840', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 1, 29, NULL, NULL, NULL, 29, 1, 29),
(49, '7755139002894', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 5.4, 124.2, NULL, NULL, NULL, 23, 5.4, 124.2),
(50, '7755139002814', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 0.53, 13.25, NULL, NULL, NULL, 25, 0.53, 13.25),
(51, '7755139002831', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 0.9, 20.7, NULL, NULL, NULL, 23, 0.9, 20.7),
(52, '7755139002832', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 0.9, 22.5, NULL, NULL, NULL, 25, 0.9, 22.5),
(53, '7755139002835', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 30, 0.67, 20.1, NULL, NULL, NULL, 30, 0.67, 20.1),
(54, '7755139002846', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 1.39, 30.58, NULL, NULL, NULL, 22, 1.39, 30.58),
(55, '7755139002847', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 30, 1.39, 41.7, NULL, NULL, NULL, 30, 1.39, 41.7),
(56, '7755139002850', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 1.39, 29.19, NULL, NULL, NULL, 21, 1.39, 29.19),
(57, '7755139002851', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 1.39, 34.75, NULL, NULL, NULL, 25, 1.39, 34.75),
(58, '7755139002854', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 2.8, 58.8, NULL, NULL, NULL, 21, 2.8, 58.8),
(59, '7755139002855', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 2.6, 57.2, NULL, NULL, NULL, 22, 2.6, 57.2),
(60, '7755139002856', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 2.6, 62.4, NULL, NULL, NULL, 24, 2.6, 62.4),
(61, '7755139002857', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 2.19, 52.56, NULL, NULL, NULL, 24, 2.19, 52.56),
(62, '7755139002861', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 2.19, 61.32, NULL, NULL, NULL, 28, 2.19, 61.32),
(63, '7755139002811', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 3.4, 85, NULL, NULL, NULL, 25, 3.4, 85),
(64, '7755139002812', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 0.5, 14, NULL, NULL, NULL, 28, 0.5, 14),
(65, '7755139002833', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 0.88, 21.12, NULL, NULL, NULL, 24, 0.88, 21.12),
(66, '7755139002837', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 1.5, 36, NULL, NULL, NULL, 24, 1.5, 36),
(67, '7755139002815', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 0.37, 10.73, NULL, NULL, NULL, 29, 0.37, 10.73),
(68, '7755139002817', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 0.68, 14.28, NULL, NULL, NULL, 21, 0.68, 14.28),
(69, '7755139002822', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 0.52, 12.48, NULL, NULL, NULL, 24, 0.52, 12.48),
(70, '7755139002823', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 20, 0.52, 10.4, NULL, NULL, NULL, 20, 0.52, 10.4),
(71, '7755139002824', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 0.52, 11.96, NULL, NULL, NULL, 23, 0.52, 11.96),
(72, '7755139002826', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 0.47, 12.69, NULL, NULL, NULL, 27, 0.47, 12.69),
(73, '7755139002827', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 0.47, 11.28, NULL, NULL, NULL, 24, 0.47, 11.28),
(74, '7755139002828', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 0.47, 13.63, NULL, NULL, NULL, 29, 0.47, 13.63),
(75, '7755139002842', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 0.9, 26.1, NULL, NULL, NULL, 29, 0.9, 26.1),
(76, '7755139002818', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 24, 0.62, 14.88, NULL, NULL, NULL, 24, 0.62, 14.88),
(77, '7755139002836', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 0.56, 12.32, NULL, NULL, NULL, 22, 0.56, 12.32),
(78, '7755139002825', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 0.5, 12.5, NULL, NULL, NULL, 25, 0.5, 12.5),
(79, '7755139002849', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 1.8, 50.4, NULL, NULL, NULL, 28, 1.8, 50.4),
(80, '7755139002875', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 3.69, 81.18, NULL, NULL, NULL, 22, 3.69, 81.18),
(81, '7755139002860', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 27, 2.8, 75.6, NULL, NULL, NULL, 27, 2.8, 75.6),
(82, '7755139002813', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 0.33, 7.26, NULL, NULL, NULL, 22, 0.33, 7.26),
(83, '7755139002816', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 20, 0.43, 8.6, NULL, NULL, NULL, 20, 0.43, 8.6),
(84, '7755139002829', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 29, 0.75, 21.75, NULL, NULL, NULL, 29, 0.75, 21.75),
(85, '7755139002819', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 28, 0.6, 16.8, NULL, NULL, NULL, 28, 0.6, 16.8),
(86, '7755139002834', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 0.85, 17.85, NULL, NULL, NULL, 21, 0.85, 17.85),
(87, '7755139002841', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 0.92, 23.92, NULL, NULL, NULL, 26, 0.92, 23.92),
(88, '7755139002843', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 1.06, 24.38, NULL, NULL, NULL, 23, 1.06, 24.38),
(89, '7755139002844', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 1.5, 39, NULL, NULL, NULL, 26, 1.5, 39),
(90, '7755139002845', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 1.5, 31.5, NULL, NULL, NULL, 21, 1.5, 31.5),
(91, '7755139002858', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 23, 2.6, 59.8, NULL, NULL, NULL, 23, 2.6, 59.8),
(92, '7755139002859', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 3, 63, NULL, NULL, NULL, 21, 3, 63),
(93, '7755139002862', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 26, 3.2, 83.2, NULL, NULL, NULL, 26, 3.2, 83.2),
(94, '7755139002873', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 25, 2.89, 72.25, NULL, NULL, NULL, 25, 2.89, 72.25),
(95, '7755139002820', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 21, 0.57, 11.97, NULL, NULL, NULL, 21, 0.57, 11.97),
(96, '7755139002821', '2023-10-24 00:00:00', 'INVENTARIO INICIAL', '', 22, 0.53, 11.66, NULL, NULL, NULL, 22, 0.53, 11.66),
(97, '7755139002873', '2023-10-24 00:00:00', 'VENTA', 'F001-123', NULL, NULL, NULL, 12, 2.89, 34.68, 13, 2.89, 37.57),
(98, '7755139002830', '2023-10-24 00:00:00', 'VENTA', 'B001-325', NULL, NULL, NULL, 1, 1, 1, 19, 1, 19),
(99, '7755139002877', '2023-10-24 00:00:00', 'VENTA', 'B001-326', NULL, NULL, NULL, 1, 5.17, 5.17, 29, 5.17, 149.93),
(100, '7755139002873', '2023-10-24 00:00:00', 'VENTA', 'B001-327', NULL, NULL, NULL, 1, 2.89, 2.89, 12, 2.89, 34.68),
(101, '7755139002873', '2023-10-24 00:00:00', 'VENTA', 'B001-328', NULL, NULL, NULL, 1, 2.89, 2.89, 11, 2.89, 31.79),
(102, '7755139002873', '2023-10-24 00:00:00', 'VENTA', 'B001-329', NULL, NULL, NULL, 1, 2.89, 2.89, 10, 2.89, 28.9),
(103, '7755139002873', '2023-10-24 00:00:00', 'VENTA', 'B001-330', NULL, NULL, NULL, 1, 2.89, 2.89, 9, 2.89, 26.01),
(104, '7755139002873', '2023-10-24 00:00:00', 'VENTA', 'B001-331', NULL, NULL, NULL, 1, 2.89, 2.89, 8, 2.89, 23.12),
(105, '7755139002870', '2023-10-24 00:00:00', 'VENTA', 'F001-124', NULL, NULL, NULL, 12, 3.25, 39, 14, 3.25, 45.5),
(106, '7755139002870', '2023-10-24 00:00:00', 'VENTA', 'B001-332', NULL, NULL, NULL, 1, 3.25, 3.25, 13, 3.25, 42.25),
(107, '7755139002870', '2023-10-24 00:00:00', 'VENTA', 'B001-333', NULL, NULL, NULL, 1, 3.25, 3.25, 12, 3.25, 39),
(108, '7755139002877', '2023-10-25 00:00:00', 'VENTA', 'B001-334', NULL, NULL, NULL, 11, 5.17, 56.87, 18, 5.17, 93.06);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` int(11) NOT NULL,
  `modulo` varchar(45) DEFAULT NULL,
  `padre_id` int(11) DEFAULT NULL,
  `vista` varchar(45) DEFAULT NULL,
  `icon_menu` varchar(45) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id`, `modulo`, `padre_id`, `vista`, `icon_menu`, `orden`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'Tablero Principal', 0, 'dashboard.php', 'fas fa-tachometer-alt', 0, NULL, NULL),
(2, 'Comprobantes', 0, '', 'fas fa-file-invoice-dollar', 1, NULL, NULL),
(3, 'Punto de Venta', 2, 'ventas.php', 'far fa-circle', 6, NULL, NULL),
(4, 'Administrar Ventas', 2, 'administrar_ventas.php', 'far fa-circle', 7, NULL, NULL),
(5, 'Productos', 0, NULL, 'fas fa-cart-plus', 8, NULL, NULL),
(6, 'Inventario', 5, 'productos.php', 'far fa-circle', 10, NULL, NULL),
(7, 'Carga Masiva', 5, 'carga_masiva_productos.php', 'far fa-circle', 11, NULL, NULL),
(8, 'Categorías', 5, 'categorias.php', 'far fa-circle', 9, NULL, NULL),
(9, 'Compras', 0, 'compras.php', 'fas fa-dolly', 13, NULL, NULL),
(10, 'Reportes', 0, '', 'fas fa-chart-pie', 14, NULL, NULL),
(11, 'Administracion', 0, NULL, 'fas fa-cogs', 18, NULL, NULL),
(13, 'Módulos / Perfiles', 31, 'seguridad_modulos_perfiles.php', 'far fa-circle', 29, NULL, NULL),
(15, 'Caja', 0, 'caja.php', 'fas fa-cash-register', 12, '2022-12-05 14:44:08', NULL),
(22, 'Tipo Afectación', 11, 'administrar_tipo_afectacion.php', 'far fa-circle', 24, '2023-09-22 05:46:29', NULL),
(23, 'Tipo Comprobante', 11, 'administrar_tipo_comprobante.php', 'far fa-circle', 23, '2023-09-22 05:50:12', NULL),
(24, 'Series', 11, 'administrar_series.php', 'far fa-circle', 25, '2023-09-22 06:15:56', NULL),
(25, 'Clientes', 11, 'administrar_clientes.php', 'far fa-circle', 20, '2023-09-22 06:19:20', NULL),
(26, 'Proveedores', 11, 'administrar_proveedores.php', 'far fa-circle', 21, '2023-09-22 06:19:31', NULL),
(27, 'Empresa', 11, 'administrar_empresas.php', 'far fa-circle', 19, '2023-09-22 06:20:56', NULL),
(28, 'Emitir Boleta', 2, 'venta_boleta.php', 'far fa-circle', 2, '2023-09-26 15:46:51', NULL),
(29, 'Emitir Factura', 2, 'venta_factura.php', 'far fa-circle', 3, '2023-09-26 15:47:09', NULL),
(30, 'Resumen de Boletas', 2, 'venta_resumen_boletas.php', 'far fa-circle', 5, '2023-09-26 15:47:39', NULL),
(31, 'Seguridad', 0, '', 'fas fa-user-shield', 26, '2023-09-26 21:03:11', NULL),
(33, 'Perfiles', 31, 'seguridad_perfiles.php', 'far fa-circle', 27, '2023-09-26 21:04:53', NULL),
(34, 'Usuarios', 31, 'seguridad_usuarios.php', 'far fa-circle', 28, '2023-09-26 21:05:08', NULL),
(37, 'Tipo Documento', 11, 'administrar_tipo_documento.php', 'far fa-circle', 22, '2023-09-30 04:07:02', NULL),
(38, 'Kardex', 10, 'reporte_kardex.php', 'far fa-circle', 15, '2023-09-30 04:07:02', NULL),
(39, 'Ventas x Categoría', 10, 'reporte_ventas.php', 'far fa-circle', 16, '2023-09-30 04:07:02', NULL),
(40, 'Ventas x Producto', 10, 'reporte_ventas_producto.php', 'far fa-circle', 17, '2023-09-30 04:07:02', NULL),
(41, 'Nota de Crédito', 2, 'venta_nota_credito.php', 'far fa-circle', 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `id` char(3) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `simbolo` char(5) DEFAULT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`id`, `descripcion`, `simbolo`, `estado`) VALUES
('PEN', 'SOLES', 'S/', 1),
('USD', 'DOLARES', '$', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_arqueo_caja`
--

CREATE TABLE `movimientos_arqueo_caja` (
  `id` int(11) NOT NULL,
  `id_arqueo_caja` int(11) DEFAULT NULL,
  `id_tipo_movimiento` int(11) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `monto` float DEFAULT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimientos_arqueo_caja`
--

INSERT INTO `movimientos_arqueo_caja` (`id`, `id_arqueo_caja`, `id_tipo_movimiento`, `descripcion`, `monto`, `estado`) VALUES
(1, 1, 4, 'APERTURA CAJA', 50, 1),
(2, 1, 3, 'INGRESO - Credito', 43.33, 1),
(3, 1, 3, 'INGRESO - Contado', 1.25, 1),
(4, 1, 3, 'INGRESO - Contado', 6.47, 1),
(5, 1, 3, 'INGRESO - Contado', 3.61, 1),
(6, 1, 3, 'INGRESO - Contado', 3.61, 1),
(7, 1, 3, 'INGRESO - Contado', 3.61, 1),
(8, 1, 3, 'INGRESO - Contado', 3.61, 1),
(9, 1, 3, 'INGRESO - Contado', 3.61, 1),
(10, 1, 3, 'INGRESO - Credito', 48.71, 1),
(11, 1, 3, 'INGRESO - Contado', 4.06, 1),
(12, 1, 3, 'INGRESO - Contado', 4.06, 1),
(13, 2, 4, 'APERTURA CAJA', 50, 1),
(14, 3, 4, 'APERTURA CAJA', 50, 1),
(15, 4, 4, 'APERTURA CAJA', 180, 1),
(16, 4, 3, 'INGRESO - Contado', 71.13, 1),
(17, 5, 4, 'APERTURA CAJA', 180, 1),
(18, 6, 4, 'APERTURA CAJA', 14, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles`
--

CREATE TABLE `perfiles` (
  `id_perfil` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `perfiles`
--

INSERT INTO `perfiles` (`id_perfil`, `descripcion`, `estado`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'ADMINISTRADOR', 1, NULL, NULL),
(2, 'VENDEDOR', 1, NULL, NULL),
(3, 'MESERO', 1, NULL, NULL),
(4, 'DEMO POS', 1, NULL, NULL),
(5, 'PERFIL DEMO', 1, NULL, NULL),
(6, 'PERFIL DEMO HOSTING IFASNET', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_modulo`
--

CREATE TABLE `perfil_modulo` (
  `idperfil_modulo` int(11) NOT NULL,
  `id_perfil` int(11) DEFAULT NULL,
  `id_modulo` int(11) DEFAULT NULL,
  `vista_inicio` tinyint(4) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `perfil_modulo`
--

INSERT INTO `perfil_modulo` (`idperfil_modulo`, `id_perfil`, `id_modulo`, `vista_inicio`, `estado`) VALUES
(13, 1, 13, 0, 1),
(624, 2, 15, 0, 1),
(625, 2, 28, 1, 1),
(626, 2, 2, 0, 1),
(627, 2, 29, 0, 1),
(628, 2, 25, 0, 1),
(629, 2, 11, 0, 1),
(715, 4, 1, 1, 1),
(716, 4, 28, 0, 1),
(717, 4, 2, 0, 1),
(718, 4, 29, 0, 1),
(719, 4, 6, 0, 1),
(720, 4, 5, 0, 1),
(721, 4, 8, 0, 1),
(722, 4, 9, 0, 1),
(723, 4, 27, 0, 1),
(724, 4, 11, 0, 1),
(725, 4, 25, 0, 1),
(726, 4, 26, 0, 1),
(727, 4, 37, 0, 1),
(728, 4, 23, 0, 1),
(729, 4, 22, 0, 1),
(730, 4, 24, 0, 1),
(831, 1, 1, 1, 1),
(832, 1, 28, 0, 1),
(833, 1, 2, 0, 1),
(834, 1, 29, 0, 1),
(835, 1, 30, 0, 1),
(836, 1, 8, 0, 1),
(837, 1, 5, 0, 1),
(838, 1, 6, 0, 1),
(839, 1, 7, 0, 1),
(840, 1, 15, 0, 1),
(841, 1, 9, 0, 1),
(842, 1, 38, 0, 1),
(843, 1, 10, 0, 1),
(844, 1, 39, 0, 1),
(845, 1, 40, 0, 1),
(846, 1, 27, 0, 1),
(847, 1, 11, 0, 1),
(848, 1, 25, 0, 1),
(849, 1, 26, 0, 1),
(850, 1, 37, 0, 1),
(851, 1, 23, 0, 1),
(852, 1, 22, 0, 1),
(853, 1, 24, 0, 1),
(854, 1, 33, 0, 1),
(855, 1, 31, 0, 1),
(856, 1, 34, 0, 1),
(857, 1, 41, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `codigo_producto` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `id_tipo_afectacion_igv` int(11) NOT NULL,
  `id_unidad_medida` varchar(3) NOT NULL,
  `costo_unitario` float DEFAULT 0,
  `precio_unitario_con_igv` float DEFAULT 0,
  `precio_unitario_sin_igv` float DEFAULT 0,
  `precio_unitario_mayor_con_igv` float DEFAULT 0,
  `precio_unitario_mayor_sin_igv` float DEFAULT 0,
  `precio_unitario_oferta_con_igv` float DEFAULT 0,
  `precio_unitario_oferta_sin_igv` float DEFAULT NULL,
  `stock` float DEFAULT 0,
  `minimo_stock` float DEFAULT 0,
  `ventas` float DEFAULT 0,
  `costo_total` float DEFAULT 0,
  `imagen` varchar(255) DEFAULT 'no_image.jpg',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_actualizacion` date DEFAULT NULL,
  `estado` int(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`codigo_producto`, `id_categoria`, `descripcion`, `id_tipo_afectacion_igv`, `id_unidad_medida`, `costo_unitario`, `precio_unitario_con_igv`, `precio_unitario_sin_igv`, `precio_unitario_mayor_con_igv`, `precio_unitario_mayor_sin_igv`, `precio_unitario_oferta_con_igv`, `precio_unitario_oferta_sin_igv`, `stock`, `minimo_stock`, `ventas`, `costo_total`, `imagen`, `fecha_creacion`, `fecha_actualizacion`, `estado`) VALUES
('7755139002809', 12, 'Paisana extra 5k', 10, 'NIU', 18.29, 22.86, 19.37, 21.95, 18.6, 21.4, 18.13, 21, 11, 0, 384.09, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002810', 11, 'Gloria Fresa 500ml', 10, 'NIU', 3.79, 4.74, 4.01, 4.55, 3.85, 4.43, 3.76, 21, 11, 0, 79.59, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002811', 13, 'Gloria evaporada ligth 400g', 10, 'NIU', 3.4, 4.25, 3.6, 4.08, 3.46, 3.98, 3.37, 25, 15, 0, 85, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002812', 19, 'soda san jorge 40g', 10, 'NIU', 0.5, 0.62, 0.53, 0.6, 0.51, 0.58, 0.5, 28, 18, 0, 14, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002813', 19, 'vainilla field 37g', 10, 'NIU', 0.33, 0.41, 0.35, 0.4, 0.34, 0.39, 0.33, 22, 12, 0, 7.26, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002814', 19, 'Margarita', 10, 'NIU', 0.53, 0.66, 0.56, 0.64, 0.54, 0.62, 0.53, 25, 15, 0, 13.25, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002815', 19, 'soda field 34g', 10, 'NIU', 0.37, 0.46, 0.39, 0.44, 0.38, 0.43, 0.37, 29, 19, 0, 10.73, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002816', 19, 'ritz original', 10, 'NIU', 0.43, 0.54, 0.46, 0.52, 0.44, 0.5, 0.43, 20, 10, 0, 8.6, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002817', 19, 'ritz queso 34g', 10, 'NIU', 0.68, 0.85, 0.72, 0.82, 0.69, 0.8, 0.67, 21, 11, 0, 14.28, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002818', 16, 'Chocobum', 10, 'NIU', 0.62, 0.77, 0.66, 0.74, 0.63, 0.73, 0.61, 24, 14, 0, 14.88, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002819', 19, 'Picaras', 10, 'NIU', 0.6, 0.75, 0.64, 0.72, 0.61, 0.7, 0.59, 28, 18, 0, 16.8, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002820', 19, 'oreo original 36g', 10, 'NIU', 0.57, 0.71, 0.6, 0.68, 0.58, 0.67, 0.57, 21, 11, 0, 11.97, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002821', 19, 'club social 26g', 10, 'NIU', 0.53, 0.66, 0.56, 0.64, 0.54, 0.62, 0.53, 22, 12, 0, 11.66, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002822', 19, 'frac vanilla 45.5g', 10, 'NIU', 0.52, 0.65, 0.55, 0.62, 0.53, 0.61, 0.52, 24, 14, 0, 12.48, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002823', 19, 'frac chocolate 45.5g', 10, 'NIU', 0.52, 0.65, 0.55, 0.62, 0.53, 0.61, 0.52, 20, 10, 0, 10.4, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002824', 19, 'frac chasica 45.5g', 10, 'NIU', 0.52, 0.65, 0.55, 0.62, 0.53, 0.61, 0.52, 23, 13, 0, 11.96, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002825', 16, 'tuyo 22g', 10, 'NIU', 0.5, 0.62, 0.53, 0.6, 0.51, 0.58, 0.5, 25, 15, 0, 12.5, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002826', 19, 'gn rellenitas 36g chocolate', 10, 'NIU', 0.47, 0.59, 0.5, 0.56, 0.48, 0.55, 0.47, 27, 17, 0, 12.69, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002827', 19, 'gn rellenitas 36g coco', 10, 'NIU', 0.47, 0.59, 0.5, 0.56, 0.48, 0.55, 0.47, 24, 14, 0, 11.28, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002828', 19, 'gn rellenitas 36g coco', 10, 'NIU', 0.47, 0.59, 0.5, 0.56, 0.48, 0.55, 0.47, 29, 19, 0, 13.63, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002829', 16, 'cancun', 10, 'NIU', 0.75, 0.94, 0.79, 0.9, 0.76, 0.88, 0.74, 29, 19, 0, 21.75, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002830', 9, 'Big cola 400ml', 10, 'NIU', 1, 1.25, 1.06, 1.2, 1.02, 1.17, 0.99, 19, 10, 1, 19, 'no_image.jpg', '2023-10-24 18:46:01', NULL, 1),
('7755139002831', 7, 'Zuko Piña', 10, 'NIU', 0.9, 1.12, 0.95, 1.08, 0.92, 1.05, 0.89, 23, 13, 0, 20.7, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002832', 7, 'Zuko Durazno', 10, 'NIU', 0.9, 1.12, 0.95, 1.08, 0.92, 1.05, 0.89, 25, 15, 0, 22.5, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002833', 16, 'chin chin 32g', 10, 'NIU', 0.88, 1.1, 0.93, 1.06, 0.89, 1.03, 0.87, 24, 14, 0, 21.12, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002834', 19, 'Morocha 30g', 10, 'NIU', 0.85, 1.06, 0.9, 1.02, 0.86, 0.99, 0.84, 21, 11, 0, 17.85, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002835', 7, 'Zuko Emoliente', 10, 'NIU', 0.67, 0.84, 0.71, 0.8, 0.68, 0.78, 0.66, 30, 20, 0, 20.1, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002836', 19, 'Choco donuts', 10, 'NIU', 0.56, 0.7, 0.59, 0.67, 0.57, 0.66, 0.56, 22, 12, 0, 12.32, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002837', 9, 'Pepsi 355ml', 10, 'NIU', 1.5, 1.88, 1.59, 1.8, 1.53, 1.75, 1.49, 24, 14, 0, 36, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002838', 4, 'Quaker 120gr', 10, 'NIU', 1.29, 1.61, 1.37, 1.55, 1.31, 1.51, 1.28, 27, 17, 0, 34.83, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002839', 6, 'Pulp Durazno 315ml', 10, 'NIU', 1, 1.25, 1.06, 1.2, 1.02, 1.17, 0.99, 27, 17, 0, 27, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002840', 19, 'morochas wafer 37g', 10, 'NIU', 1, 1.25, 1.06, 1.2, 1.02, 1.17, 0.99, 29, 19, 0, 29, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002841', 16, 'Wafer sublime', 10, 'NIU', 0.92, 1.15, 0.97, 1.1, 0.94, 1.08, 0.91, 26, 16, 0, 23.92, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002842', 19, 'hony bran 33g', 10, 'NIU', 0.9, 1.12, 0.95, 1.08, 0.92, 1.05, 0.89, 29, 19, 0, 26.1, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002843', 16, 'Sublime clásico', 10, 'NIU', 1.06, 1.33, 1.12, 1.27, 1.08, 1.24, 1.05, 23, 13, 0, 24.38, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002844', 11, 'Gloria fresa 180ml', 10, 'NIU', 1.5, 1.88, 1.59, 1.8, 1.53, 1.75, 1.49, 26, 16, 0, 39, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002845', 11, 'Gloria durazno 180ml', 10, 'NIU', 1.5, 1.88, 1.59, 1.8, 1.53, 1.75, 1.49, 21, 11, 0, 31.5, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002846', 11, 'Frutado fresa vasito', 10, 'NIU', 1.39, 1.74, 1.47, 1.67, 1.41, 1.63, 1.38, 22, 12, 0, 30.58, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002847', 11, 'Frutado durazno vasito', 10, 'NIU', 1.39, 1.74, 1.47, 1.67, 1.41, 1.63, 1.38, 30, 20, 0, 41.7, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002848', 4, '3 ositos quinua', 10, 'NIU', 1.9, 2.38, 2.01, 2.28, 1.93, 2.22, 1.88, 25, 15, 0, 47.5, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002849', 9, 'Seven Up 500ml', 10, 'NIU', 1.8, 2.25, 1.91, 2.16, 1.83, 2.11, 1.78, 28, 18, 0, 50.4, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002850', 9, 'Fanta Kola Inglesa 500ml', 10, 'NIU', 1.39, 1.74, 1.47, 1.67, 1.41, 1.63, 1.38, 21, 11, 0, 29.19, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002851', 9, 'Fanta Naranja 500ml', 10, 'NIU', 1.39, 1.74, 1.47, 1.67, 1.41, 1.63, 1.38, 25, 15, 0, 34.75, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002852', 14, 'Noble pq 2 unid', 10, 'NIU', 1.3, 1.62, 1.38, 1.56, 1.32, 1.52, 1.29, 20, 10, 0, 26, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002853', 14, 'Suave pq 2 unid', 10, 'NIU', 1.99, 2.49, 2.11, 2.39, 2.02, 2.33, 1.97, 28, 18, 0, 55.72, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002854', 9, 'Pepsi 750ml', 10, 'NIU', 2.8, 3.5, 2.97, 3.36, 2.85, 3.28, 2.78, 21, 11, 0, 58.8, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002855', 9, 'Coca cola 600ml', 10, 'NIU', 2.6, 3.25, 2.75, 3.12, 2.64, 3.04, 2.58, 22, 12, 0, 57.2, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002856', 9, 'Inca Kola 600ml', 10, 'NIU', 2.6, 3.25, 2.75, 3.12, 2.64, 3.04, 2.58, 24, 14, 0, 62.4, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002857', 14, 'Elite Megarrollo', 10, 'NIU', 2.19, 2.74, 2.32, 2.63, 2.23, 2.56, 2.17, 24, 14, 0, 52.56, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002858', 13, 'Pura vida 395g', 10, 'NIU', 2.6, 3.25, 2.75, 3.12, 2.64, 3.04, 2.58, 23, 13, 0, 59.8, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002859', 13, 'Ideal cremosita 395g', 10, 'NIU', 3, 3.75, 3.18, 3.6, 3.05, 3.51, 2.97, 21, 11, 0, 63, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002860', 13, 'Ideal Light 395g', 10, 'NIU', 2.8, 3.5, 2.97, 3.36, 2.85, 3.28, 2.78, 27, 17, 0, 75.6, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002861', 11, 'Fresa 370ml Laive', 10, 'NIU', 2.19, 2.74, 2.32, 2.63, 2.23, 2.56, 2.17, 28, 18, 0, 61.32, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002862', 13, 'Gloria evaporada entera', 10, 'NIU', 3.2, 4, 3.39, 3.84, 3.25, 3.74, 3.17, 26, 16, 0, 83.2, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002863', 13, 'Laive Ligth caja 480ml', 10, 'NIU', 2.8, 3.5, 2.97, 3.36, 2.85, 3.28, 2.78, 27, 17, 0, 75.6, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002864', 9, 'Pepsi 1.5L', 10, 'NIU', 4.4, 5.5, 4.66, 5.28, 4.47, 5.15, 4.36, 20, 10, 0, 88, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002865', 11, 'Gloria durazno 500ml', 10, 'NIU', 3.79, 4.74, 4.01, 4.55, 3.85, 4.43, 3.76, 23, 13, 0, 87.17, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002866', 11, 'Gloria Vainilla Francesa 500ml', 10, 'NIU', 3.79, 4.74, 4.01, 4.55, 3.85, 4.43, 3.76, 26, 16, 0, 98.54, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002867', 11, 'Griego gloria', 10, 'NIU', 3.65, 4.56, 3.87, 4.38, 3.71, 4.27, 3.62, 24, 14, 0, 87.6, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002868', 9, 'Sabor Oro 1.7L', 10, 'NIU', 3.5, 4.38, 3.71, 4.2, 3.56, 4.09, 3.47, 20, 10, 0, 70, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002869', 3, 'Canchita mantequilla', 10, 'NIU', 3.25, 4.06, 3.44, 3.9, 3.31, 3.8, 3.22, 21, 11, 0, 68.25, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002870', 3, 'Canchita natural', 10, 'NIU', 3.25, 4.06, 3.44, 3.9, 3.31, 3.8, 3.22, 12, 16, 14, 39, 'no_image.jpg', '2023-10-25 04:46:43', NULL, 1),
('7755139002871', 13, 'Laive sin lactosa caja 480ml', 10, 'NIU', 3.17, 3.96, 3.36, 3.8, 3.22, 3.71, 3.14, 27, 17, 0, 85.59, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002872', 12, 'Valle Norte 750g', 10, 'NIU', 3.1, 3.88, 3.28, 3.72, 3.15, 3.63, 3.07, 30, 20, 0, 93, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002873', 11, 'Battimix', 10, 'NIU', 2.89, 3.61, 3.06, 3.47, 2.94, 3.38, 2.87, 8, 15, 17, 23.12, 'no_image.jpg', '2023-10-24 19:00:37', NULL, 1),
('7755139002874', 3, 'Pringles papas', 10, 'NIU', 2.8, 3.5, 2.97, 3.36, 2.85, 3.28, 2.78, 28, 18, 0, 78.4, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002875', 12, 'Costeño 750g', 10, 'NIU', 3.69, 4.61, 3.91, 4.43, 3.75, 4.32, 3.66, 22, 12, 0, 81.18, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002876', 12, 'Faraon amarillo 1k', 10, 'NIU', 3.39, 4.24, 3.59, 4.07, 3.45, 3.97, 3.36, 21, 11, 0, 71.19, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002877', 15, 'A1 Trozos', 10, 'NIU', 5.17, 6.46, 5.48, 6.2, 5.26, 6.05, 5.13, 18, 20, 12, 93.06, 'no_image.jpg', '2023-10-25 17:21:22', NULL, 1),
('7755139002878', 14, 'Nova pq 2 unid', 10, 'NIU', 3.99, 4.99, 4.23, 4.79, 4.06, 4.67, 3.96, 25, 15, 0, 99.75, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002879', 14, 'Suave pq 4 unid', 10, 'NIU', 4.58, 5.72, 4.85, 5.5, 4.66, 5.36, 4.54, 28, 18, 0, 128.24, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002880', 15, 'Florida Trozos', 10, 'NIU', 5.15, 6.44, 5.46, 6.18, 5.24, 6.03, 5.11, 23, 13, 0, 118.45, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002881', 14, 'Paracas pq 4 unid', 10, 'NIU', 5, 6.25, 5.3, 6, 5.08, 5.85, 4.96, 22, 12, 0, 110, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002882', 15, 'Trozos de atún Campomar', 10, 'NIU', 4.66, 5.82, 4.94, 5.59, 4.74, 5.45, 4.62, 27, 17, 0, 125.82, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002883', 15, 'A1 Filete', 10, 'NIU', 4.65, 5.81, 4.93, 5.58, 4.73, 5.44, 4.61, 23, 13, 0, 106.95, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002884', 15, 'Real Trozos', 10, 'NIU', 4.63, 5.79, 4.9, 5.56, 4.71, 5.42, 4.59, 21, 11, 0, 97.23, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002885', 11, 'Durazno 1L laive', 10, 'NIU', 5.7, 7.12, 6.04, 6.84, 5.8, 6.67, 5.65, 27, 17, 0, 153.9, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002886', 11, 'Fresa 1L Laive', 10, 'NIU', 5.7, 7.12, 6.04, 6.84, 5.8, 6.67, 5.65, 21, 11, 0, 119.7, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002887', 15, 'A1 Filete Ligth', 10, 'NIU', 6.08, 7.6, 6.44, 7.3, 6.18, 7.11, 6.03, 27, 17, 0, 164.16, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002888', 11, 'Lúcuma 1L Gloria', 10, 'NIU', 5.9, 7.38, 6.25, 7.08, 6, 6.9, 5.85, 22, 12, 0, 129.8, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002889', 11, 'Fresa 1L Gloria', 10, 'NIU', 5.9, 7.38, 6.25, 7.08, 6, 6.9, 5.85, 28, 18, 0, 165.2, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002890', 11, 'Milkito fresa 1L', 10, 'NIU', 5.9, 7.38, 6.25, 7.08, 6, 6.9, 5.85, 24, 14, 0, 141.6, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002891', 11, 'Gloria Durazno 1L', 10, 'NIU', 5.9, 7.38, 6.25, 7.08, 6, 6.9, 5.85, 29, 19, 0, 171.1, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002892', 15, 'Filete de atún Campomar', 10, 'NIU', 5.08, 6.35, 5.38, 6.1, 5.17, 5.94, 5.04, 21, 11, 0, 106.68, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002893', 15, 'Florida Filete Ligth', 10, 'NIU', 5.63, 7.04, 5.96, 6.76, 5.73, 6.59, 5.58, 29, 19, 0, 163.27, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002894', 15, 'Filete de atún Florida', 10, 'NIU', 5.4, 6.75, 5.72, 6.48, 5.49, 6.32, 5.35, 23, 13, 0, 124.2, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002895', 9, 'Inca Kola 1.5L', 10, 'NIU', 5.9, 7.38, 6.25, 7.08, 6, 6.9, 5.85, 29, 19, 0, 171.1, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002896', 9, 'Coca Cola 1.5L', 10, 'NIU', 5.9, 7.38, 6.25, 7.08, 6, 6.9, 5.85, 27, 17, 0, 159.3, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002897', 5, 'Red Bull 250ml', 10, 'NIU', 5.33, 6.66, 5.65, 6.4, 5.42, 6.24, 5.28, 22, 12, 0, 117.26, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002898', 9, 'Sprite 3L', 10, 'NIU', 7.49, 9.36, 7.93, 8.99, 7.62, 8.76, 7.43, 27, 17, 0, 202.23, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002899', 9, 'Pepsi 3L', 10, 'NIU', 8, 10, 8.47, 9.6, 8.14, 9.36, 7.93, 26, 16, 0, 208, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002900', 13, 'Laive 200gr', 10, 'NIU', 8.9, 11.12, 9.43, 10.68, 9.05, 10.41, 8.82, 21, 11, 0, 186.9, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002901', 8, 'Gloria Pote con sal', 10, 'NIU', 10, 11.49, 9.74, 11.03, 9.35, 10.75, 9.11, 26, 16, 0, 260, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002902', 10, 'Deleite 1L', 10, 'NIU', 9.8, 12.25, 10.38, 11.76, 9.97, 11.47, 9.72, 29, 19, 0, 284.2, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002903', 10, 'Sao 1L', 10, 'NIU', 12.1, 15.12, 12.82, 14.52, 12.31, 14.16, 12, 23, 13, 0, 278.3, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1),
('7755139002904', 10, 'Cocinero 1L', 10, 'NIU', 12.4, 15.5, 13.14, 14.88, 12.61, 14.51, 12.29, 29, 19, 0, 359.6, 'no_image.jpg', '2023-10-24 18:39:24', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `id_tipo_documento` varchar(45) NOT NULL,
  `ruc` varchar(45) NOT NULL,
  `razon_social` varchar(150) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `id_tipo_documento`, `ruc`, `razon_social`, `direccion`, `telefono`, `estado`) VALUES
(1, '6', '20224391464', 'NOR ANDINA SRL CONTARTISTAS GENERALES', 'AVENIDA ABANCAY 489', '015235689', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resumenes`
--

CREATE TABLE `resumenes` (
  `id` int(11) NOT NULL,
  `fecha_envio` date DEFAULT NULL,
  `fecha_referencia` date DEFAULT NULL,
  `correlativo` int(11) DEFAULT NULL,
  `resumen` smallint(6) DEFAULT NULL,
  `baja` smallint(6) DEFAULT NULL,
  `nombrexml` varchar(50) DEFAULT NULL,
  `mensaje_sunat` varchar(200) DEFAULT NULL,
  `codigo_sunat` varchar(20) DEFAULT NULL,
  `ticket` varchar(50) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resumenes_detalle`
--

CREATE TABLE `resumenes_detalle` (
  `id` int(255) NOT NULL,
  `id_envio` int(11) DEFAULT NULL,
  `id_comprobante` int(11) DEFAULT NULL,
  `condicion` smallint(6) DEFAULT NULL COMMENT '1->Creacion, 2->Actualizacion, 3->Baja'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serie`
--

CREATE TABLE `serie` (
  `id` int(11) NOT NULL,
  `id_tipo_comprobante` varchar(3) NOT NULL,
  `serie` varchar(4) NOT NULL,
  `correlativo` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `serie`
--

INSERT INTO `serie` (`id`, `id_tipo_comprobante`, `serie`, `correlativo`, `estado`) VALUES
(1, '03', 'B001', 334, 1),
(2, '01', 'F001', 124, 1),
(3, '03', 'B002', 2, 1),
(4, '03', 'B003', 15, 1),
(6, '01', 'FL01', 8, 1),
(8, '03', 'B004', 1, 1),
(9, 'RC', 'RC', 0, 1),
(10, 'RA', 'RA', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_afectacion_igv`
--

CREATE TABLE `tipo_afectacion_igv` (
  `id` int(11) NOT NULL,
  `codigo` char(3) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `letra_tributo` varchar(45) DEFAULT NULL,
  `codigo_tributo` varchar(45) DEFAULT NULL,
  `nombre_tributo` varchar(45) DEFAULT NULL,
  `tipo_tributo` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_afectacion_igv`
--

INSERT INTO `tipo_afectacion_igv` (`id`, `codigo`, `descripcion`, `letra_tributo`, `codigo_tributo`, `nombre_tributo`, `tipo_tributo`, `estado`) VALUES
(1, '10', 'GRAVADO - OPERACIÓN ONEROSA', 'S', '1000', 'IGV', 'VAT', 1),
(2, '20', 'EXONERADO - OPERACIÓN ONEROSA', 'E', '9997', 'EXO', 'VAT', 1),
(3, '30', 'INAFECTO - OPERACIÓN ONEROSA', 'O', '9998', 'INA', 'FRE', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_comprobante`
--

CREATE TABLE `tipo_comprobante` (
  `id` int(11) NOT NULL,
  `codigo` varchar(3) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tipo_comprobante`
--

INSERT INTO `tipo_comprobante` (`id`, `codigo`, `descripcion`, `estado`) VALUES
(1, '01', 'FACTURA', 1),
(2, '03', 'BOLETA', 1),
(3, '07', 'NOTA DE CRÉDITO', 1),
(4, '08', 'NOTA DE DÉBITO', 1),
(5, '09', 'GUIA DE REMISIÓN', 1),
(6, 'RA', 'RESUMEN ANULACIONES', 1),
(7, 'RC', 'RESUMEN COMPROBANTES', 1),
(8, 'XX', 'PRUEBA', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`id`, `descripcion`, `estado`) VALUES
(0, 'DOC.TRIB.NO.DOM.SIN.RUC', 1),
(1, 'DNI', 1),
(4, 'CARNET DE EXTRANJERIA', 1),
(6, 'RUC', 1),
(7, 'PASAPORTE', 1),
(10, 'PRUEBA 2', 0),
(11, 'PRUEBA 3', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_movimiento_caja`
--

CREATE TABLE `tipo_movimiento_caja` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_movimiento_caja`
--

INSERT INTO `tipo_movimiento_caja` (`id`, `descripcion`, `estado`) VALUES
(1, 'DEVOLUCIÓN', 1),
(2, 'GASTO', 1),
(3, 'INGRESO', 1),
(4, 'APERTURA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_operacion`
--

CREATE TABLE `tipo_operacion` (
  `codigo` varchar(4) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_operacion`
--

INSERT INTO `tipo_operacion` (`codigo`, `descripcion`, `estado`) VALUES
('0101', 'Venta interna', 1),
('0102', 'Venta Interna – Anticipos', 1),
('0103', 'Venta interna - Itinerante', 1),
('0110', 'Venta Interna - Sustenta Traslado de Mercadería - Remitente', 1),
('0111', 'Venta Interna - Sustenta Traslado de Mercadería - Transportista', 1),
('0112', 'Venta Interna - Sustenta Gastos Deducibles Persona Natural', 1),
('0120', 'Venta Interna - Sujeta al IVAP', 1),
('0200', 'Exportación de Bienes ', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_precio_venta_unitario`
--

CREATE TABLE `tipo_precio_venta_unitario` (
  `codigo` varchar(2) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_precio_venta_unitario`
--

INSERT INTO `tipo_precio_venta_unitario` (`codigo`, `descripcion`, `estado`) VALUES
('01', 'Precio unitario (incluye el IGV)', 1),
('02', 'Valor referencial unitario en operaciones no onerosas', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) DEFAULT NULL,
  `apellido_usuario` varchar(100) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `clave` text DEFAULT NULL,
  `id_perfil_usuario` int(11) DEFAULT NULL,
  `id_caja` int(11) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido_usuario`, `usuario`, `clave`, `id_perfil_usuario`, `id_caja`, `estado`) VALUES
(1, 'TUTORIALES', 'PHPERU', 'tperu', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 1, 2, 1),
(2, 'PAOLO', 'GUERRERO', 'pguerrero', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 2, 1, 1),
(3, 'FIORELLA JESSICA', 'OSORES VALLEJO', 'fosoresv29', '123456', 2, 2, 1),
(4, 'RAFAEL', 'LOZANO', 'rlozano', '123456', 2, 1, 1),
(5, 'ANDY', 'POLO', 'apolo', 'asdsad', 2, 2, 1),
(6, 'ALEX', 'VALERA', 'avalera123', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 1, 2, 1),
(7, 'ALDO', 'CORZO', 'acorzo123', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 1, 2, 1),
(8, 'RENATO', 'TAPIA', 'prueba4', '$2a$07$azybxcags23425sdg23sdeV5s.14AcWhL0szWBmqFbPuIRMEC.9eu', 2, 2, 1),
(9, 'EMILIA', 'LOZANO OSORES', 'elozano', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 1, 2, 1),
(10, 'USUARIO ', 'DEMO', 'demo', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 4, 1, 1),
(11, 'EDISON', 'FLORES', 'edisonFlores', '$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq', 2, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id` int(11) NOT NULL,
  `id_empresa_emisora` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_serie` int(11) NOT NULL,
  `serie` varchar(4) NOT NULL,
  `correlativo` int(11) NOT NULL,
  `fecha_emision` date NOT NULL,
  `hora_emision` varchar(10) DEFAULT NULL,
  `fecha_vencimiento` date NOT NULL,
  `id_moneda` varchar(3) NOT NULL,
  `forma_pago` varchar(45) NOT NULL,
  `tipo_operacion` varchar(10) DEFAULT NULL,
  `total_operaciones_gravadas` float DEFAULT 0,
  `total_operaciones_exoneradas` float DEFAULT 0,
  `total_operaciones_inafectas` float DEFAULT 0,
  `total_igv` float DEFAULT 0,
  `importe_total` float DEFAULT 0,
  `nombre_xml` varchar(255) DEFAULT NULL,
  `xml_base64` text DEFAULT NULL,
  `xml_cdr_sunat_base64` text DEFAULT NULL,
  `codigo_error_sunat` text DEFAULT NULL,
  `mensaje_respuesta_sunat` text DEFAULT NULL,
  `hash_signature` varchar(150) DEFAULT NULL,
  `estado_respuesta_sunat` int(11) DEFAULT NULL,
  `estado_comprobante` int(11) DEFAULT 0,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(1, 1, 1, 2, 'F001', 123, '2023-10-24', '01:10:08', '2023-10-24', 'PEN', 'Credito', NULL, 36.72, 0, 0, 6.61, 43.33, '10467291240-01-F001-123.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5ZczNWNmdLdDdLdGNyWGlOT254UTl0TlFMQW89PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPnd2TFVmMU1VUFNuU1gzT00xTDJZUWJhWWVCODUyUXpEVk5GT1VxREJTZVVqbndQK2VvL2VMZURlSFlOQTFFdVp0d1VqTUY2a0RsMHg4Y1ZteU91K0p4cy9uN0JiTGtlNDBkK2xhOGhyY3NmNWNTUS8rbitOckJNL1pQQVVsbVQ4eGlsTDRkMzlJbWVkeXBET1o2TEFTTnU5ay9aaVBtNVE5YmY2aEVMb0FaYWNXdVpmbmphNVo5Mm1KdG84SUdDb1JMV3RWRERQVTVic2o5N1IrcEgvMzdhbjlZRGFaK1ZLUEZOV1ptV2d0bWE0MFU0cCtHRGphYlg5ZDNzVndaNUliYXVTYnhGMEtTeDkwTHNuNyt1dDVVR0dBbWxBcGgwTTBHVGkrTmZGOVhEK1d4TEtjcVlmRFJqeE1xT0F4TERhMTEzNXN4KzZaa203OG51eDdZdWVqQT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ii8+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5GMDAxLTEyMzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTAtMjQ8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MDE6MTA6MDg8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTAtMjQ8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMTwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkYwMDEtMTIzPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VVJJPiNTaWduYXR1cmVTUDwvY2JjOlVSST4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSI+MTUwMTA0PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBZGRyZXNzVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iRXN0YWJsZWNpbWllbnRvcyBhbmV4b3MiPjAwMDA8L2NiYzpBZGRyZXNzVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW0xJTUFdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbQkFSUkFOQ09dXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQ0FMTEUgQlVFTkFWRU5UVVJBIEFHVUlSUkUgMzAyIF1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MjAxMDg4MDg3NDk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbSU5GT1JNQVRJQ0EgREVMIE5PUlRFIFMuQS5dXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbSU5GT1JNQVRJQ0EgREVMIE5PUlRFIFMuQS5dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MjAxMDg4MDg3NDk8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjIwMTA4ODA4NzQ5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbSU5GT1JNQVRJQ0EgREVMIE5PUlRFIFMuQS5dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQVYuIExBIExJQkVSVEFEIE5STyA4MTUgSU5ULiAxIFVSQi4gU0FOVEEgVklDVE9SSUEgXV0+PC9jYmM6TGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBZGRyZXNzTGluZT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ii8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdDdXN0b21lclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+Rm9ybWFQYWdvPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQYXltZW50TWVhbnNJRD5DcmVkaXRvPC9jYmM6UGF5bWVudE1lYW5zSUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40My4zMzwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+PGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+Rm9ybWFQYWdvPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q3VvdGEwMDE8L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40My4zMzwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQYXltZW50RHVlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6UGF5bWVudER1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Ni42MTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjM2LjcyPC9jYmM6VGF4YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Ni42MTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUxNTMiIHNjaGVtZUFnZW5jeUlEPSI2Ij4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT5JR1Y8L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTdWJ0b3RhbD48L2NhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MzYuNzI8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjQzLjMzPC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40My4zMzwvY2JjOlBheWFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6TGVnYWxNb25ldGFyeVRvdGFsPjxjYWM6SW52b2ljZUxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZWRRdWFudGl0eSB1bml0Q29kZT0iTklVIiB1bml0Q29kZUxpc3RJRD0iVU4vRUNFIHJlYyAyMCIgdW5pdENvZGVMaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj4xMjwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zNi43MjwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNpbmdSZWZlcmVuY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My42MTwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj42LjYxPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U3VidG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjM2LjcyPC9jYmM6VGF4YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj42LjYxPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBlcmNlbnQ+MTg8L2NiYzpQZXJjZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEV4ZW1wdGlvblJlYXNvbkNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iQWZlY3RhY2lvbiBkZWwgSUdWIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA3Ij4xMDwvY2JjOlRheEV4ZW1wdGlvblJlYXNvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUxNTMiIHNjaGVtZU5hbWU9IkNvZGlnbyBkZSB0cmlidXRvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT5JR1Y8L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTdWJ0b3RhbD48L2NhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6SXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRlc2NyaXB0aW9uPjwhW0NEQVRBW0JhdHRpbWl4XV0+PC9jYmM6RGVzY3JpcHRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjwhW0NEQVRBWzE5NV1dPjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlIGxpc3RJRD0iVU5TUFNDIiBsaXN0QWdlbmN5TmFtZT0iR1MxIFVTIiBsaXN0TmFtZT0iSXRlbSBDbGFzc2lmaWNhdGlvbiI+MTAxOTE1MDk8L2NiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQcmljZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuMDY8L2NiYzpQcmljZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJbnZvaWNlTGluZT48L0ludm9pY2U+Cg==', '', 'soap-env:Client.3267', 'Fecha del pago único o de las cuotas no puede ser anterior o igual a la fecha de emisión del comprobante - Detalle: xxx.xxx.xxx value=\'ticket: 1698172507433 error: Error en Cuota001: 3267 (nodo: \"cac:PaymentTerms/cbc:PaymentDueDate\" valor: \"2023-10-24\")\'', '', 2, 1, 1),
(2, 1, 2, 1, 'B001', 325, '2023-10-24', '01:10:01', '2023-10-24', 'PEN', 'Contado', NULL, 1.06, 0, 0, 0.19, 1.25, '10467291240-03-B001-325.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT4ydXNjcHBZU05yY1JHVzFwTmxJVXVvWWpTRGc9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPldEZnBya2NNVjF6TXdUc1luRWVKbmlpbXc1Q3ZqTzBIK3kyd0tNU1R3Zm9GeWRWaHNlTE9mUXVrVWdKTDJFanZVMHJoWUpZTEk5R2lWcUprZ2tZcnF2RUZkNFFLRVRma3hiK1hCbk9RcE9aN0lURkFGdG9HZHg2MnJOclhHN2tQeU5hV0ZxemNTemVHNHFnb0U1S08rMGhrV0xMYnZ4QThjTkhOWVVYM3pyRGN2eGoxajlGNmVZTGQyT0dKSHcrRDcwSWNGR2pNL3d2WWtOdlNUZThESHNyME85c3hZRVdZR3d1L2JyMTE3UmdlNnJuam9SRUJtaVFZa0FERnMxdEZmTHlmMXZoS0xOdFJVMjExNnZxbUMvWE53ZWtxcFpOd3BlTjJpMk4rZ2ZFTWkvbVpEMkplWUg3MHBZd2hhZzFpVGZ1dXhGYUpsR05MZittZVpURGpndz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ii8+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMyNTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTAtMjQ8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MDE6MTA6MDE8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTAtMjQ8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMzwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkIwMDEtMzI1PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VVJJPiNTaWduYXR1cmVTUDwvY2JjOlVSST4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSI+MTUwMTA0PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBZGRyZXNzVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iRXN0YWJsZWNpbWllbnRvcyBhbmV4b3MiPjAwMDA8L2NiYzpBZGRyZXNzVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW0xJTUFdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbQkFSUkFOQ09dXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQ0FMTEUgQlVFTkFWRU5UVVJBIEFHVUlSUkUgMzAyIF1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij45OTk5OTk5OTwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4yNTwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjE5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4wNjwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMTk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMDY8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMjU8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMjU8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjA2PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjI1PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMTk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4wNjwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4xOTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVtCaWcgY29sYSA0MDBtbF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjA2PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPjI3MVpSUCtadkpPVFRnSmdUTi9vUXNRTk1OdWlndFNrM0JzZDBsQWFQdCtLTG9pM2FreTM1SlZaS1lPM3o0M2wwOWxURDVLRjUzZVY2TWpINjhtUHpBPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MTczMDgzMjg1PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQwMToxMDowMTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjE0OjQ0OjQzPC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzI1PC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMjUsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMjU8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-325, ha sido aceptada', '', 1, 1, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(3, 1, 2, 1, 'B001', 326, '2023-10-24', '01:10:31', '2023-10-24', 'PEN', 'Contado', NULL, 5.48, 0, 0, 0.99, 6.47, '10467291240-03-B001-326.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5Pak5lMjZtUjAzV2R3cXF5U3A4WlV2d1ZUUEE9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPldFMEtuUjIxNWVWdjJZNHlyZE9LY3V4WTFkanJCaStFWkhLRUxXVzd6UHNKTGhTaGpyUC9VUThmK1VzcEhEMUxnOEcrQno3bzhRTTFqS0dEUzBweTJTdzE4ZTVVWVNwVGdLbG93NllhNjdZV1JzMDhNaWRHNzNTOUkycWkwS1E2NmJ4R0J6VWx4Slp3WG12b1o1UzV1MWs5bklSVTJCMktSSGl2Rm9TSGU2UmVaYUxiU2pnMGdia1pFYmMxWG9sL0FnUFk1cVJwcXJ6WlY5VjRjajZ3eS94S1hDbUJCQkpnVS9NVExWcnJvanJJNTRSZG9HTlRGRk9jamRLT2F3Vy9sUkg3Q1FtU1JNQ25TMXg2MFZMQ1pXZHROalQva2pLWmZ2dTM5QzNqVnRJWHNPUkpvOGdlMWxuL0lkd0pvYTF0bmFmTVR5dUFkRlB3YWVoSUpucjRtdz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMS0zMjY8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6SXNzdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVUaW1lPjAxOjEwOjMxPC9jYmM6SXNzdWVUaW1lPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RHVlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VUeXBlQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJUaXBvIGRlIERvY3VtZW50byIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wMSIgbGlzdElEPSIwMTAxIiBuYW1lPSJUaXBvIGRlIE9wZXJhY2lvbiI+MDM8L2NiYzpJbnZvaWNlVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEb2N1bWVudEN1cnJlbmN5Q29kZSBsaXN0SUQ9IklTTyA0MjE3IEFscGhhIiBsaXN0TmFtZT0iQ3VycmVuY3kiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlBFTjwvY2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUNvdW50TnVtZXJpYz4xPC9jYmM6TGluZUNvdW50TnVtZXJpYz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdHVyZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMyNjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjE1MDEwNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEJVRU5BVkVOVFVSQSBBR1VJUlJFIDMwMiBdXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSI+UEU8L2NiYzpJZGVudGlmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdTdXBwbGllclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IkRvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIwIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNpdHlOYW1lPjwhW0NEQVRBW11dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBWy1dXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5Gb3JtYVBhZ288L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnRNZWFuc0lEPkNvbnRhZG88L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjYuNDc8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC45OTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjUuNDg8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjk5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lQWdlbmN5SUQ9IjYiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgIDxjYWM6TGVnYWxNb25ldGFyeVRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj41LjQ4PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhJbmNsdXNpdmVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj42LjQ3PC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj42LjQ3PC9jYmM6UGF5YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpMZWdhbE1vbmV0YXJ5VG90YWw+PGNhYzpJbnZvaWNlTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlZFF1YW50aXR5IHVuaXRDb2RlPSJOSVUiIHVuaXRDb2RlTGlzdElEPSJVTi9FQ0UgcmVjIDIwIiB1bml0Q29kZUxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPjE8L2NiYzpJbnZvaWNlZFF1YW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NS40ODwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNpbmdSZWZlcmVuY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Ni40NzwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjk5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U3VidG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjUuNDg8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuOTk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbQTEgVHJvem9zXV0+PC9jYmM6RGVzY3JpcHRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjwhW0NEQVRBWzE5NV1dPjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlIGxpc3RJRD0iVU5TUFNDIiBsaXN0QWdlbmN5TmFtZT0iR1MxIFVTIiBsaXN0TmFtZT0iSXRlbSBDbGFzc2lmaWNhdGlvbiI+MTAxOTE1MDk8L2NiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQcmljZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjUuNDg8L2NiYzpQcmljZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJbnZvaWNlTGluZT48L0ludm9pY2U+Cg==', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPllBNkFnVkt2Zms2V21LTW82S0x0TWxoY3hTME5zblBXd2k4c01QaFRxdGZEaTUrNXlTTmRpT1JHT2FkTEhGU3FpS3ovbWdMMHJkME5SeXZJaFZMY3dRPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MTczMTExNDA5PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQwMToxMDozMTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjE0OjQ1OjExPC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzI2PC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMjYsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMjY8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-326, ha sido aceptada', '', 1, 1, 1),
(4, 1, 2, 1, 'B001', 327, '2023-10-24', '01:10:04', '2023-10-24', 'PEN', 'Contado', NULL, 3.06, 0, 0, 0.55, 3.61, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1),
(5, 1, 2, 1, 'B001', 328, '2023-10-24', '01:10:50', '2023-10-24', 'PEN', 'Contado', NULL, 3.06, 0, 0, 0.55, 3.61, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1),
(6, 1, 2, 1, 'B001', 329, '2023-10-24', '01:10:36', '2023-10-24', 'PEN', 'Contado', NULL, 3.06, 0, 0, 0.55, 3.61, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(7, 1, 2, 1, 'B001', 330, '2023-10-24', '02:10:07', '2023-10-24', 'PEN', 'Contado', NULL, 3.06, 0, 0, 0.55, 3.61, '10467291240-03-B001-330.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5BYmx6NDJobFFueEI5MkMxeXIvd1J6N0pER0k9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPm11bEtLeWNyVDQ3eEtkWm9md3VYRHlmdXlpUUliS1hmcmZpdGVqWGpPUHVZVE1MRXV4eW5MdWxuQlUzQlk1cm45dkVGaXZXRmVvdFZQSE5JU2FGRU1VcGFkNjIwcWRuQWlGZVJ0NkQvaTVPNGVzL29MQXZCbzdjRjZ0cVpxWnhoZ2NsaWIxTkpqRVcyTHJZMXltRFBCR0NjSWR1eStnMllmY3ZMTzMwK2ZNbWFCYWJqdGh5MFBndEY0OFVjeTEybVl0dGxzOUd3YXlKQ0hZMUl6VDhqY0JpNHh2Y3cyMERJQ2hicEtKZ202WW8yMHQ0MEtLMWh4aTJKaTRKeWpvMVZteW5GOUNPTTdUTTJtL0tiTFQzK1pmamV5ZThBYU9BeTFGazh1cnpMNkZ3RVVJbWJCVmVidFUzWVk2NjJNRXRjRE9hOW9WUWROYTVFNXIyT3dDVVh4dz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ii8+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMzMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTAtMjQ8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MDI6MTA6MDc8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTAtMjQ8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMzwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkIwMDEtMzMwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VVJJPiNTaWduYXR1cmVTUDwvY2JjOlVSST4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSI+MTUwMTA0PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBZGRyZXNzVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iRXN0YWJsZWNpbWllbnRvcyBhbmV4b3MiPjAwMDA8L2NiYzpBZGRyZXNzVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW0xJTUFdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbQkFSUkFOQ09dXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQ0FMTEUgQlVFTkFWRU5UVVJBIEFHVUlSUkUgMzAyIF1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij45OTk5OTk5OTwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My42MTwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjU1PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My4wNjwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNTU8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuMDY8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNjE8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNjE8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjA2PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjYxPC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNTU8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My4wNjwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC41NTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVtCYXR0aW1peF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjA2PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPmV5ekxnRzBRT1k1NWFrbTA1YVJFMjRya2pBTXQyVmxlWG0rVGxsdHk5cTc1Q2FaTFhTbHNyOUc4R21SYVVrZzFpRXZSZUNwMXVYaDJBZjZCbXFZVUNnPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MjAzMzQ1NDMwPC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQwMjoxMDowNzwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjIzOjA5OjA1PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzMwPC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMzAsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMzA8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-330, ha sido aceptada', 'Ablz42hlQnxB92C1yr/wRz7JDGI=', 1, 1, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(8, 1, 2, 1, 'B001', 331, '2023-10-24', '02:10:37', '2023-10-24', 'PEN', 'Contado', NULL, 3.06, 0, 0, 0.55, 3.61, '10467291240-03-B001-331.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT56L3VSRnpMeVI3V3FTa05pWkV1OUZuYVFGLzA9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPmE4VUcyUXk0cTF0MHdjcS9iY0k2ckdSUHVGZnJ3dUtkZW1mL2hvMDRhQ1hIV28rSE8wN1FOajFta1A0OHl0ak84SWE2c041SitTWUpNUmRBZEd6NEF3MTRzaWtjQXhSOWtidld6dDdib3ZlaUNjbEhKVytxYkRtVThOeVB5TlhFb0pDMjJDUEg5L1V5MlM3VkpsNHBtblNtVk50cThMUExaeTlQOWgvN0ttNVlHZWVRbzNBRVNzRmJXVWhFT0h5ZXFLTkF6WjNoV1FaakNLaTZEK3BXQ3dEazIyV2Y2TTBaNElyWldvM1VtSDZldHdlaXo3TzdGUG5hZnFRY2NOemttRUdjdnpLZEwySFJuZ09XZTVtczdmWEYvQXNqeDE3aW5uSllMdjBqd1F4SmR1T05scGIrV3hpcUxyM1N5bWUvUHVhZkNRM2VSRVQ2aU9QQ0ZSbGlGZz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMS0zMzE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6SXNzdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVUaW1lPjAyOjEwOjM3PC9jYmM6SXNzdWVUaW1lPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RHVlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VUeXBlQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJUaXBvIGRlIERvY3VtZW50byIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wMSIgbGlzdElEPSIwMTAxIiBuYW1lPSJUaXBvIGRlIE9wZXJhY2lvbiI+MDM8L2NiYzpJbnZvaWNlVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEb2N1bWVudEN1cnJlbmN5Q29kZSBsaXN0SUQ9IklTTyA0MjE3IEFscGhhIiBsaXN0TmFtZT0iQ3VycmVuY3kiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlBFTjwvY2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUNvdW50TnVtZXJpYz4xPC9jYmM6TGluZUNvdW50TnVtZXJpYz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdHVyZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMzMTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjE1MDEwNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEJVRU5BVkVOVFVSQSBBR1VJUlJFIDMwMiBdXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSI+UEU8L2NiYzpJZGVudGlmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdTdXBwbGllclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IkRvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIwIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNpdHlOYW1lPjwhW0NEQVRBW11dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBWy1dXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5Gb3JtYVBhZ288L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnRNZWFuc0lEPkNvbnRhZG88L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNjE8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC41NTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuMDY8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjU1PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lQWdlbmN5SUQ9IjYiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgIDxjYWM6TGVnYWxNb25ldGFyeVRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjA2PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhJbmNsdXNpdmVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjYxPC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjYxPC9jYmM6UGF5YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpMZWdhbE1vbmV0YXJ5VG90YWw+PGNhYzpJbnZvaWNlTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlZFF1YW50aXR5IHVuaXRDb2RlPSJOSVUiIHVuaXRDb2RlTGlzdElEPSJVTi9FQ0UgcmVjIDIwIiB1bml0Q29kZUxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPjE8L2NiYzpJbnZvaWNlZFF1YW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My4wNjwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNpbmdSZWZlcmVuY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My42MTwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjU1PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U3VidG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuMDY8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNTU8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbQmF0dGltaXhdXT48L2NiYzpEZXNjcmlwdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+PCFbQ0RBVEFbMTk1XV0+PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGUgbGlzdElEPSJVTlNQU0MiIGxpc3RBZ2VuY3lOYW1lPSJHUzEgVVMiIGxpc3ROYW1lPSJJdGVtIENsYXNzaWZpY2F0aW9uIj4xMDE5MTUwOTwvY2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My4wNjwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkludm9pY2VMaW5lPjwvSW52b2ljZT4K', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPkVucnZsRm1tSXVBUUU1SHU5dGhNVE5YQ2pKNlpSMXdwZ0pzRG4wQnZKb2NlaWVzd0RXUVUwTS9BdVlOTkprTlVBcWNFcUR2VE0wSFNyQ0pGK0lvMHVRPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MTczNTk3NTkyPC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQwMjoxMDozNzwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjE0OjUzOjE3PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzMxPC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMzEsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMzE8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-331, ha sido aceptada', 'z/uRFzLyR7WqSkNiZEu9FnaQF/0=', 1, 1, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(9, 1, 1, 2, 'F001', 124, '2023-10-24', '09:10:07', '2023-10-24', 'PEN', 'Credito', NULL, 41.28, 0, 0, 7.43, 48.71, '10467291240-01-F001-124.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5XOGYxSkMyWURoV2RFQ2JINDVuV0dTMHVOSkE9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPk9ybVJwYmFiZ29RbGZhQkUxWGhIdjREYjN0REEyeDRrMG83cDZPb2FBc0Y0Y1ZkYlNsS2VhK2dpUHdyLzFSL3lrZnphUElpdEE0djdVNGs0eXdCVEYwc3VuNTh3bUp0bmt2b1k5Z2RFY2JlMVRqVmZIVmxzZWFkb09UeG9KM2NtNTVrRkdOUmFPQldOVGhqVVVqdkU5WmJPUmtvMWNQU3JkYkg1NzFxY01lQUlPWTRVb3d3WnRhTnQwM1pTVk5JdFBxc1E3UzliQ09uanBieWVKWUp4M3ZoU1FOdTZKYlFiQVQ5WG8xWFcwcjh4Kzc5bm1iVWkvSFJ5aVFMaE5rSmErUDY1Qnh5ODkxam9KcHYxTHF0WlFQVmdMNjFlT25RbXBwMXpYVFJZdzZHOXIxSEdmajQwYndjZ2t0V0RCT1NZYndHMXFuTWFWVVI5bW5QZE13Y0IzZz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+RjAwMS0xMjQ8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6SXNzdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVUaW1lPjA5OjEwOjA3PC9jYmM6SXNzdWVUaW1lPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RHVlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VUeXBlQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJUaXBvIGRlIERvY3VtZW50byIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wMSIgbGlzdElEPSIwMTAxIiBuYW1lPSJUaXBvIGRlIE9wZXJhY2lvbiI+MDE8L2NiYzpJbnZvaWNlVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEb2N1bWVudEN1cnJlbmN5Q29kZSBsaXN0SUQ9IklTTyA0MjE3IEFscGhhIiBsaXN0TmFtZT0iQ3VycmVuY3kiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlBFTjwvY2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUNvdW50TnVtZXJpYz4xPC9jYmM6TGluZUNvdW50TnVtZXJpYz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdHVyZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5GMDAxLTEyNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjE1MDEwNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEJVRU5BVkVOVFVSQSBBR1VJUlJFIDMwMiBdXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSI+UEU8L2NiYzpJZGVudGlmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdTdXBwbGllclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IkRvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjIwMTA4ODA4NzQ5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW0lORk9STUFUSUNBIERFTCBOT1JURSBTLkEuXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0lORk9STUFUSUNBIERFTCBOT1JURSBTLkEuXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjIwMTA4ODA4NzQ5PC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4yMDEwODgwODc0OTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0lORk9STUFUSUNBIERFTCBOT1JURSBTLkEuXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNpdHlOYW1lPjwhW0NEQVRBW11dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0FWLiBMQSBMSUJFUlRBRCBOUk8gODE1IElOVC4gMSBVUkIuIFNBTlRBIFZJQ1RPUklBIF1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q3JlZGl0bzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NDguNzE8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPjxjYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnRNZWFuc0lEPkN1b3RhMDAxPC9jYmM6UGF5bWVudE1lYW5zSUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjA8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudER1ZURhdGU+MjAyMy0xMC0yNTwvY2JjOlBheW1lbnREdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDwvY2FjOlBheW1lbnRUZXJtcz48Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5Gb3JtYVBhZ288L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQYXltZW50TWVhbnNJRD5DdW90YTAwMjwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjI4LjcxPC9jYmM6QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnREdWVEYXRlPjIwMjMtMTEtMDM8L2NiYzpQYXltZW50RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj43LjQzPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NDEuMjg8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj43LjQzPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lQWdlbmN5SUQ9IjYiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgIDxjYWM6TGVnYWxNb25ldGFyeVRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj40MS4yODwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4SW5jbHVzaXZlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NDguNzE8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjQ4LjcxPC9jYmM6UGF5YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpMZWdhbE1vbmV0YXJ5VG90YWw+PGNhYzpJbnZvaWNlTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlZFF1YW50aXR5IHVuaXRDb2RlPSJOSVUiIHVuaXRDb2RlTGlzdElEPSJVTi9FQ0UgcmVjIDIwIiB1bml0Q29kZUxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPjEyPC9jYmM6SW52b2ljZWRRdWFudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjQxLjI4PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40LjA2PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjcuNDM8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NDEuMjg8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjcuNDM8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbQ2FuY2hpdGEgbmF0dXJhbF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ0PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPjRWZ3J4YktocE1DYUdZaGo3V0x2MEdwMTk2eDU3RkV4eUNCcHFXZUw4ZnZROG1KalNvazQ0QWtGcUUxdE1xVUN4YW92d2ZIUVB0VmJVUCsvbzhqaDFRPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MjAyMjQ3MTMxPC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQwOToxMDowNzwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjIyOjUwOjQ3PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkYwMDEtMTI0PC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEZhY3R1cmEgbnVtZXJvIEYwMDEtMTI0LCBoYSBzaWRvIGFjZXB0YWRhPC9jYmM6RGVzY3JpcHRpb24+PC9jYWM6UmVzcG9uc2U+PGNhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2JjOklEPkYwMDEtMTI0PC9jYmM6SUQ+PC9jYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNhYzpSZWNpcGllbnRQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD42LTIwMTA4ODA4NzQ5PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpSZWNpcGllbnRQYXJ0eT48L2NhYzpEb2N1bWVudFJlc3BvbnNlPjwvYXI6QXBwbGljYXRpb25SZXNwb25zZT4=', '', 'La Factura numero F001-124, ha sido aceptada', 'W8f1JC2YDhWdECbH45nWGS0uNJA=', 1, 1, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(10, 1, 2, 1, 'B001', 332, '2023-10-24', '11:10:05', '2023-10-24', 'PEN', 'Contado', NULL, 3.44, 0, 0, 0.62, 4.06, '10467291240-03-B001-332.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5qby9kMERSNUhVZTZXWEE2RktHTDQ0cmxkQWc9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPlhwTE81KzNtK2xaTG4xNjd6VVZzS21VekNlVUxUYkpWSllXbFU4SHJNY05VVU83eFBKTEhwbFZkZCtrTG5wdU9VeWVBb0FoUTNOWDY3ZmhNaFJhaFdMTUFoZGsvam41b2RpdUtLOS80NTliZTIyU3k5WWtiNWFRV2xSbG1PRThoZGZUenJNSTd5RlZPSyt0YzBiaXRQTVVwaXU4Y3g4SVFvVXdBLzBNNG1iR0p2MHFLeStNS21RaHQrbllrUmZ0RE9vSk1lQWdDd3E2bzJxRisxcDhYSGVFQ1ZYTEFVM3plajFKM3ZjSklKVFMyZkd1VzIwcGZUMXVVa0NDTjh0U3Jhbm9tNTFJVUhzVjJsTEZ3NVBkY0gySEN0TjdkaGxlWEpIYVR2T0JiTndJamNaK1kzNklXWGxabUY4RWpnWCtlRE5wQ2xlMDE4UEZER3dsK1dCOFZjdz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMS0zMzI8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6SXNzdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVUaW1lPjExOjEwOjA1PC9jYmM6SXNzdWVUaW1lPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RHVlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VUeXBlQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJUaXBvIGRlIERvY3VtZW50byIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wMSIgbGlzdElEPSIwMTAxIiBuYW1lPSJUaXBvIGRlIE9wZXJhY2lvbiI+MDM8L2NiYzpJbnZvaWNlVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEb2N1bWVudEN1cnJlbmN5Q29kZSBsaXN0SUQ9IklTTyA0MjE3IEFscGhhIiBsaXN0TmFtZT0iQ3VycmVuY3kiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlBFTjwvY2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUNvdW50TnVtZXJpYz4xPC9jYmM6TGluZUNvdW50TnVtZXJpYz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdHVyZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMzMjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjE1MDEwNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEJVRU5BVkVOVFVSQSBBR1VJUlJFIDMwMiBdXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSI+UEU8L2NiYzpJZGVudGlmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdTdXBwbGllclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IkRvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIwIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNpdHlOYW1lPjwhW0NEQVRBW11dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBWy1dXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5Gb3JtYVBhZ288L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnRNZWFuc0lEPkNvbnRhZG88L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjQuMDY8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC42MjwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNDQ8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjYyPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lQWdlbmN5SUQ9IjYiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgIDxjYWM6TGVnYWxNb25ldGFyeVRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ0PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhJbmNsdXNpdmVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40LjA2PC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40LjA2PC9jYmM6UGF5YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpMZWdhbE1vbmV0YXJ5VG90YWw+PGNhYzpJbnZvaWNlTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlZFF1YW50aXR5IHVuaXRDb2RlPSJOSVUiIHVuaXRDb2RlTGlzdElEPSJVTi9FQ0UgcmVjIDIwIiB1bml0Q29kZUxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPjE8L2NiYzpJbnZvaWNlZFF1YW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My40NDwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNpbmdSZWZlcmVuY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NC4wNjwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjYyPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U3VidG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNDQ8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNjI8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbQ2FuY2hpdGEgbmF0dXJhbF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ0PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPjUzTk5zOWtKNG02Und2YllJRVJHRWlEbjVudjdnc3hmRkZUMnU3S3czVlVwd3NmUDFEWUtXbzM1VWFtZGZSVm1LSDBEOEpzSnVsV0loYU5XelpnSjBnPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MjA4NzI2MDYyPC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQxMToxMDowNTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI1PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjAwOjM4OjQ2PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzMyPC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMzIsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMzI8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-332, ha sido aceptada', 'jo/d0DR5HUe6WXA6FKGL44rldAg=', 1, 1, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(11, 1, 2, 1, 'B001', 333, '2023-10-24', '11:10:43', '2023-10-24', 'PEN', 'Contado', NULL, 3.44, 0, 0, 0.62, 4.06, '10467291240-03-B001-333.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT51NWZzVDN6dmp6SlZXc2ZxbVN5NFFJRm5aN2M9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPmxBMUJBNExkRGxSK0tVd0lVRnRZcWdZOW1UcFpUaFh1d1UrQnpkOHhWdFhXSWN4M1NQcjM1a0hXMHZJSGU1WHJyaWwvcG9QSWUyVkRZSmQ0SXRqNHR6ZjVZNFM5Ri9QdWJ3R0EzSXNJMDJBcHUxL09FdXBKbjE3VHBnQVVaR01aRG1mQ0NOclFIVE5VZ0V0a0xLdUxTdGdBcUp2UVB4N2w5NHRrOVg1aUptSzh0S2VvanFYSzVTRXUrc3YvakRpcW1vV0Nia3NtNm5LL1hxdi90d3NqK0toSEhmUks4SkhUMG5BNEJId1RYY2J5YjB5UlNQeG9aWFdwZEI4ZEo2TU0wMk9pdEdsWGxxOWF1M24rY0J2TktFN3U3Uml6bGVsU1k4a1hFRk9JVnBYdkZGMzZDNUhqbTRIYUoxQS8zeU00c2NhZXY5R285RVZTQ2JLM1R3OFdhUT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMS0zMzM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6SXNzdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVUaW1lPjExOjEwOjQzPC9jYmM6SXNzdWVUaW1lPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RHVlRGF0ZT4yMDIzLTEwLTI0PC9jYmM6RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VUeXBlQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJUaXBvIGRlIERvY3VtZW50byIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wMSIgbGlzdElEPSIwMTAxIiBuYW1lPSJUaXBvIGRlIE9wZXJhY2lvbiI+MDM8L2NiYzpJbnZvaWNlVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEb2N1bWVudEN1cnJlbmN5Q29kZSBsaXN0SUQ9IklTTyA0MjE3IEFscGhhIiBsaXN0TmFtZT0iQ3VycmVuY3kiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlBFTjwvY2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUNvdW50TnVtZXJpYz4xPC9jYmM6TGluZUNvdW50TnVtZXJpYz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdHVyZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMzMzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjE1MDEwNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEJVRU5BVkVOVFVSQSBBR1VJUlJFIDMwMiBdXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSI+UEU8L2NiYzpJZGVudGlmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdTdXBwbGllclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IkRvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIwIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNpdHlOYW1lPjwhW0NEQVRBW11dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBWy1dXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5Gb3JtYVBhZ288L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnRNZWFuc0lEPkNvbnRhZG88L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjQuMDY8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC42MjwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNDQ8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjYyPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lQWdlbmN5SUQ9IjYiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgIDxjYWM6TGVnYWxNb25ldGFyeVRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ0PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhJbmNsdXNpdmVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40LjA2PC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj40LjA2PC9jYmM6UGF5YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpMZWdhbE1vbmV0YXJ5VG90YWw+PGNhYzpJbnZvaWNlTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlZFF1YW50aXR5IHVuaXRDb2RlPSJOSVUiIHVuaXRDb2RlTGlzdElEPSJVTi9FQ0UgcmVjIDIwIiB1bml0Q29kZUxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPjE8L2NiYzpJbnZvaWNlZFF1YW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My40NDwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNpbmdSZWZlcmVuY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NC4wNjwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjYyPC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U3VidG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNDQ8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNjI8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbQ2FuY2hpdGEgbmF0dXJhbF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ0PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPmxLL0l0VkQyRVpJQldFMm1BRmNmU0ROSXFqM1JKZHdwcVY0a0NLWUYwdHlMd0hJU2U0cEVKZnJpc3lobm5QYnFGandnM2d3VTRmWlNBTXRsVEtJMkV3PT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MjA4NzYzMzkyPC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNFQxMToxMDo0MzwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI1PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjAwOjM5OjIzPC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzMzPC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMzMsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMzM8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-333, ha sido aceptada', 'u5fsT3zvjzJVWsfqmSy4QIFnZ7c=', 1, 1, 1);
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`) VALUES
(12, 1, 2, 1, 'B001', 334, '2023-10-25', '12:10:22', '2023-10-25', 'PEN', 'Contado', NULL, 60.28, 0, 0, 10.85, 71.13, '10467291240-03-B001-334.XML', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5OQVRKd256a0ZVUVVkZlBpQUZpWnF4ekY2Zlk9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPkNLd0d5d0lUdG5EY0N1NmV6YzU3bEl1N2JyNFZINUZVQ05lYXVXNjVPWDNyK0p1eUx1SWpsSWwzelRNTWQyRTlBaTRyOURlTFZmZWJGWXlrRXpoL2syU3VvSk9RWFNyNlBjY0JCdnBnUWgyWXdleFZFOHJycnF6MWdRbEk4YWxxWWgvZm0wS2hlRkxPTlI0QnFWYWg1Ykw1eGMySTU1MjAzTEFoNFJvc0p5VWNDNHlLUG9SZHJFT1UrL0tmYXdWbVhRSnYvQ0R0YXBYUEttS0IvSXorVnFUVDBCWUFvQWwyVWl0SXRrVTF2UUFqRS9EeFhRU3ZSN0RlR2Z4WFI3RFJxWkwwOFBMdDJJUXFrNTdWWEYvSlFtc0RmUjRjdlhZOEhWYys1cFdmSXpEeUZBdjZ2NHkrQkJpUFlSMGwyZHJybW5ZWWc3cHBRQTRENmI2S2VlMjcvQT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMS0zMzQ8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlRGF0ZT4yMDIzLTEwLTI1PC9jYmM6SXNzdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVUaW1lPjEyOjEwOjIyPC9jYmM6SXNzdWVUaW1lPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RHVlRGF0ZT4yMDIzLTEwLTI1PC9jYmM6RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VUeXBlQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJUaXBvIGRlIERvY3VtZW50byIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wMSIgbGlzdElEPSIwMTAxIiBuYW1lPSJUaXBvIGRlIE9wZXJhY2lvbiI+MDM8L2NiYzpJbnZvaWNlVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEb2N1bWVudEN1cnJlbmN5Q29kZSBsaXN0SUQ9IklTTyA0MjE3IEFscGhhIiBsaXN0TmFtZT0iQ3VycmVuY3kiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlBFTjwvY2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUNvdW50TnVtZXJpYz4xPC9jYmM6TGluZUNvdW50TnVtZXJpYz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdHVyZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTMzNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbM0QgSU5WRVJTSU9ORVMgWSBTRVJWSUNJT1MgR0VORVJBTEVTIEUuSS5SLkwuCV1dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVszRCBJTlZFUlNJT05FUyBZIFNFUlZJQ0lPUyBHRU5FUkFMRVMgRS5JLlIuTC4JXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MDwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBWzNEIElOVkVSU0lPTkVTIFkgU0VSVklDSU9TIEdFTkVSQUxFUyBFLkkuUi5MLgldXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjE1MDEwNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEJVRU5BVkVOVFVSQSBBR1VJUlJFIDMwMiBdXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSI+UEU8L2NiYzpJZGVudGlmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkFjY291bnRpbmdTdXBwbGllclBhcnR5PgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IkRvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIwIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjk5OTk5OTk5PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNpdHlOYW1lPjwhW0NEQVRBW11dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBWy1dXT48L2NiYzpMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFkZHJlc3NMaW5lPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ0N1c3RvbWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5Gb3JtYVBhZ288L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnRNZWFuc0lEPkNvbnRhZG88L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjcxLjEzPC9jYmM6QW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEwLjg1PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NjAuMjg8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xMC44NTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUxNTMiIHNjaGVtZUFnZW5jeUlEPSI2Ij4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT5JR1Y8L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTdWJ0b3RhbD48L2NhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+NjAuMjg8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjcxLjEzPC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj43MS4xMzwvY2JjOlBheWFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6TGVnYWxNb25ldGFyeVRvdGFsPjxjYWM6SW52b2ljZUxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZWRRdWFudGl0eSB1bml0Q29kZT0iTklVIiB1bml0Q29kZUxpc3RJRD0iVU4vRUNFIHJlYyAyMCIgdW5pdENvZGVMaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj4xMTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj42MC4yODwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNpbmdSZWZlcmVuY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Ni40NzwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xMC44NTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheGFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj42MC4yODwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MTAuODU8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbQTEgVHJvem9zXV0+PC9jYmM6RGVzY3JpcHRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjwhW0NEQVRBWzE5NV1dPjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlIGxpc3RJRD0iVU5TUFNDIiBsaXN0QWdlbmN5TmFtZT0iR1MxIFVTIiBsaXN0TmFtZT0iSXRlbSBDbGFzc2lmaWNhdGlvbiI+MTAxOTE1MDk8L2NiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQcmljZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjUuNDg8L2NiYzpQcmljZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJbnZvaWNlTGluZT48L0ludm9pY2U+Cg==', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPlVWT1RCME1tYU5UOStNOTk2a21qU2x5dDltYWhrVXRQNWlzUzYvakxLb2ExbkdOVHcvUG1Zc1A4WVFpd0thL0JHSm5BeTNoUmswSEtrU05KRTNtNCtRPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNjk4MjU0MDQwNDAxPC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMC0yNVQxMjoxMDoyMjwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTEwLTI1PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjEzOjE0OjAwPC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYWM6U2VuZGVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MjAxMzEzMTI5NTU8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlNlbmRlclBhcnR5PjxjYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4xMDQ2NzI5MTI0MDwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjZWl2ZXJQYXJ0eT48Y2FjOkRvY3VtZW50UmVzcG9uc2U+PGNhYzpSZXNwb25zZT48Y2JjOlJlZmVyZW5jZUlEPkIwMDEtMzM0PC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMS0zMzQsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMS0zMzQ8L2NiYzpJRD48L2NhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2FjOlJlY2lwaWVudFBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjYtOTk5OTk5OTk8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2lwaWVudFBhcnR5PjwvY2FjOkRvY3VtZW50UmVzcG9uc2U+PC9hcjpBcHBsaWNhdGlvblJlc3BvbnNlPg==', '', 'La Boleta numero B001-334, ha sido aceptada', 'NATJwnzkFUQUdfPiAFiZqxzF6fY=', 1, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `arqueo_caja`
--
ALTER TABLE `arqueo_caja`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `codigo_unidad_medida`
--
ALTER TABLE `codigo_unidad_medida`
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cod_producto_idx` (`codigo_producto`),
  ADD KEY `fk_id_compra_idx` (`id_compra`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `forma_pago`
--
ALTER TABLE `forma_pago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `impuestos`
--
ALTER TABLE `impuestos`
  ADD PRIMARY KEY (`id_tipo_operacion`);

--
-- Indices de la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_producto_idx` (`codigo_producto`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `movimientos_arqueo_caja`
--
ALTER TABLE `movimientos_arqueo_caja`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  ADD PRIMARY KEY (`id_perfil`);

--
-- Indices de la tabla `perfil_modulo`
--
ALTER TABLE `perfil_modulo`
  ADD PRIMARY KEY (`idperfil_modulo`),
  ADD KEY `id_perfil` (`id_perfil`),
  ADD KEY `id_modulo` (`id_modulo`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`codigo_producto`),
  ADD UNIQUE KEY `codigo_producto_UNIQUE` (`codigo_producto`),
  ADD KEY `fk_id_categoria_idx` (`id_categoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `resumenes`
--
ALTER TABLE `resumenes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `resumenes_detalle`
--
ALTER TABLE `resumenes_detalle`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_id_envio` (`id_envio`) USING BTREE,
  ADD KEY `fk_idventa` (`id_comprobante`) USING BTREE;

--
-- Indices de la tabla `serie`
--
ALTER TABLE `serie`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_afectacion_igv`
--
ALTER TABLE `tipo_afectacion_igv`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  ADD PRIMARY KEY (`id`,`codigo`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_movimiento_caja`
--
ALTER TABLE `tipo_movimiento_caja`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_operacion`
--
ALTER TABLE `tipo_operacion`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `tipo_precio_venta_unitario`
--
ALTER TABLE `tipo_precio_venta_unitario`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_perfil_usuario` (`id_perfil_usuario`),
  ADD KEY `fk_id_caja_idx` (`id_caja`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `arqueo_caja`
--
ALTER TABLE `arqueo_caja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cajas`
--
ALTER TABLE `cajas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `forma_pago`
--
ALTER TABLE `forma_pago`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `kardex`
--
ALTER TABLE `kardex`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `movimientos_arqueo_caja`
--
ALTER TABLE `movimientos_arqueo_caja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `perfil_modulo`
--
ALTER TABLE `perfil_modulo`
  MODIFY `idperfil_modulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=858;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `resumenes`
--
ALTER TABLE `resumenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resumenes_detalle`
--
ALTER TABLE `resumenes_detalle`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `serie`
--
ALTER TABLE `serie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tipo_afectacion_igv`
--
ALTER TABLE `tipo_afectacion_igv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipo_movimiento_caja`
--
ALTER TABLE `tipo_movimiento_caja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `fk_cod_producto` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_id_compra` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD CONSTRAINT `fk_cod_producto_kardex` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `perfil_modulo`
--
ALTER TABLE `perfil_modulo`
  ADD CONSTRAINT `id_modulo` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `resumenes_detalle`
--
ALTER TABLE `resumenes_detalle`
  ADD CONSTRAINT `fk_id_envio` FOREIGN KEY (`id_envio`) REFERENCES `resumenes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_id_caja` FOREIGN KEY (`id_caja`) REFERENCES `cajas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_perfil_usuario`) REFERENCES `perfiles` (`id_perfil`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
