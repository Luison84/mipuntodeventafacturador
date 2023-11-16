-- MariaDB dump 10.19  Distrib 10.6.15-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tutoria3_mitiendaposfacturador
-- ------------------------------------------------------
-- Server version	10.6.15-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `arqueo_caja`
--

DROP TABLE IF EXISTS `arqueo_caja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arqueo_caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `estado` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arqueo_caja`
--

LOCK TABLES `arqueo_caja` WRITE;
/*!40000 ALTER TABLE `arqueo_caja` DISABLE KEYS */;
INSERT INTO `arqueo_caja` (`id`, `id_usuario`, `fecha_apertura`, `fecha_cierre`, `monto_apertura`, `ingresos`, `devoluciones`, `gastos`, `monto_final`, `monto_real`, `sobrante`, `faltante`, `estado`) VALUES (1,2,'2023-11-13 20:40:28','2023-11-13 20:48:13',100000,0,0,5000,95000,100000,5000,0,0),(2,2,'2023-11-13 21:18:15','2023-11-13 21:42:34',100,0,0,0,100,100,0,0,0),(3,2,'2023-11-13 21:42:43','2023-11-14 11:23:49',100000,0,0,0,0,1,0,99999,0),(4,2,'2023-11-14 11:23:56','2023-11-14 11:41:53',0,22.86,0,0,22.86,100,77.14,0,0),(5,2,'2023-11-14 14:47:10','2023-11-15 00:16:03',50,0,0,0,0,178.64,0,0,0),(6,2,'2023-11-15 00:16:11','2023-11-16 01:58:36',100,0,0,0,0,187.47,0,0,0),(7,2,'2023-11-16 01:59:11',NULL,400,32.7,NULL,NULL,432.7,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `arqueo_caja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cajas`
--

DROP TABLE IF EXISTS `cajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_caja` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajas`
--

LOCK TABLES `cajas` WRITE;
/*!40000 ALTER TABLE `cajas` DISABLE KEYS */;
INSERT INTO `cajas` (`id`, `nombre_caja`, `estado`) VALUES (1,'Sin Caja',1),(2,'Caja Barrancio Mod 1',1),(3,'Caja Barrancio Mod 2',1),(4,'Caja Barrancio Mod 3',1);
/*!40000 ALTER TABLE `cajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` (`id`, `descripcion`, `fecha_creacion`, `fecha_actualizacion`, `estado`) VALUES (1,'Frutas','2023-11-14 00:02:59',NULL,1),(2,'Verduras','2023-11-14 00:02:59',NULL,1),(3,'Snack','2023-11-14 00:02:59',NULL,1),(4,'Avenas','2023-11-15 14:27:57',NULL,1),(5,'Energizante','2023-11-15 14:29:04',NULL,1),(6,'Jugo','2023-11-14 00:02:59',NULL,1),(7,'Refresco','2023-11-14 00:02:59',NULL,1),(8,'Mantequilla','2023-11-14 00:02:59',NULL,1),(9,'Gaseosa','2023-11-14 00:02:59',NULL,1),(10,'Aceite','2023-11-15 21:03:00',NULL,1),(11,'Yogurt','2023-11-14 00:02:59',NULL,1),(12,'Arroz','2023-11-14 00:02:59',NULL,1),(13,'Leche','2023-11-14 00:02:59',NULL,1),(14,'Papel Higiénico','2023-11-14 00:02:59',NULL,1),(15,'Atún','2023-11-14 00:02:59',NULL,1),(16,'Chocolate','2023-11-14 00:02:59',NULL,1),(17,'Wafer','2023-11-14 00:02:59',NULL,1),(18,'Golosina','2023-11-14 00:02:59',NULL,1),(19,'Galletas','2023-11-14 00:02:59',NULL,1),(20,'yogurt','2023-11-15 21:03:07',NULL,1),(21,'medicamento de para alergias','2023-11-16 07:23:32',NULL,1);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_documento` int(11) DEFAULT NULL,
  `nro_documento` varchar(20) DEFAULT NULL,
  `nombres_apellidos_razon_social` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `id_tipo_documento`, `nro_documento`, `nombres_apellidos_razon_social`, `direccion`, `telefono`, `estado`) VALUES (1,12,'7864276132','PEDRO PINEDA','ESPAÑA EURO','131231212',1),(2,6,'1047582541','PEREZ','VICTORIA','99658584',1),(3,0,'99999999','CLIENTES VARIOS','-','-',1),(4,1,'46285220','ROEL GREGORIO PARIONA TAME','JR. CANGALLO ','9999999',1),(5,6,'10462852202','PARIONA TAME ROEL GREGORIO','-','',1),(6,1,'75822545','ANTHONY BARTOLOME HERRERA CHURA','tacna','',1),(7,1,'60873614','Ronaldo Solis','yhjgj','920244586',1),(8,1,'71988056','modesto','pacaycasa','928654891',1),(9,4,'18219711','Alejandro','calle nueva esperanza','12345678',1),(10,12,'98698597','juan camilo a','Cra 72b # 94 - 32','3003915509',1),(11,1,'44241109','SONIA ARAPA VIVEROS','jr','923981231',1),(12,1,'12345678','sergio','tiquipaya','789456897',1),(13,1,'6512168','SERGIO','TIQUIPAYA','134554545',1),(14,1,'76543245','lulu lala','aaaaaavvtttt','9876567',1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `codigo_unidad_medida`
--

DROP TABLE IF EXISTS `codigo_unidad_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codigo_unidad_medida` (
  `id` varchar(3) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `estado` int(11) DEFAULT 1,
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codigo_unidad_medida`
--

LOCK TABLES `codigo_unidad_medida` WRITE;
/*!40000 ALTER TABLE `codigo_unidad_medida` DISABLE KEYS */;
INSERT INTO `codigo_unidad_medida` (`id`, `descripcion`, `estado`) VALUES ('BO','BOTELLAS',1),('BX','CAJA',1),('DZN','DOCENA',1),('KGM','KILOGRAMO',1),('LTR','LITRO',1),('MIL','MILLARES',1),('NIU','UNIDAD',1),('PK','PAQUETE',1);
/*!40000 ALTER TABLE `codigo_unidad_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `estado` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` (`id`, `id_proveedor`, `fecha_compra`, `id_tipo_comprobante`, `serie`, `correlativo`, `id_moneda`, `ope_exonerada`, `ope_inafecta`, `ope_gravada`, `total_igv`, `descuento`, `total_compra`, `estado`) VALUES (1,1,'2023-11-14 00:00:00','01','F234','44564654','PEN',0,0,10.51,1.89,0,12.4,1),(2,1,'2023-11-14 00:00:00','08','HJHG','5665656','PEN',0,0,8.31,1.49,0,9.8,1);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuotas`
--

DROP TABLE IF EXISTS `cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_venta` int(11) DEFAULT NULL,
  `cuota` varchar(3) DEFAULT NULL,
  `importe` decimal(15,6) DEFAULT NULL,
  `importe_pagado` float NOT NULL,
  `saldo_pendiente` float NOT NULL,
  `cuota_pagada` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuotas`
--

LOCK TABLES `cuotas` WRITE;
/*!40000 ALTER TABLE `cuotas` DISABLE KEYS */;
INSERT INTO `cuotas` (`id`, `id_venta`, `cuota`, `importe`, `importe_pagado`, `saldo_pendiente`, `cuota_pagada`, `fecha_vencimiento`, `estado`) VALUES (1,15,'1',1.120000,1.12,-0,0,'2023-11-22','1');
/*!40000 ALTER TABLE `cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_compra` int(11) DEFAULT NULL,
  `codigo_producto` varchar(20) DEFAULT NULL,
  `cantidad` float DEFAULT NULL,
  `costo_unitario` float DEFAULT NULL,
  `descuento` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `impuesto` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cod_producto_idx` (`codigo_producto`),
  KEY `fk_id_compra_idx` (`id_compra`),
  CONSTRAINT `fk_cod_producto` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_compra` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compra`
--

LOCK TABLES `detalle_compra` WRITE;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` (`id`, `id_compra`, `codigo_producto`, `cantidad`, `costo_unitario`, `descuento`, `subtotal`, `impuesto`, `total`) VALUES (1,1,'7755139002904',1,12.4,0,10.51,1.89,12.4),(2,2,'7755139002902',1,9.8,0,8.31,1.49,9.8);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `importe_total` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` (`id`, `id_venta`, `item`, `codigo_producto`, `descripcion`, `porcentaje_igv`, `cantidad`, `costo_unitario`, `valor_unitario`, `precio_unitario`, `valor_total`, `igv`, `importe_total`) VALUES (1,1,1,'7755139002809','Paisana extra 5k',18,1,18.29,19.37,22.86,19.37,3.49,22.86),(2,2,1,'7755139002830','Big cola 400ml',18,12,1,1.06,1.25,12.72,2.29,15.01),(3,3,1,'7755139002871','Laive sin lactosa caja 480ml',18,2,3.17,3.36,3.96,6.72,1.21,7.93),(4,4,1,'7755139002813','vainilla field 37g',18,1,0.33,0.35,0.41,0.35,0.06,0.41),(5,5,1,'7755139002815','soda field 34g',18,1,0.37,0.39,0.46,0.39,0.07,0.46),(6,6,1,'7755139002837','Pepsi 355ml',18,1,1.5,1.59,1.88,1.59,0.29,1.88),(7,7,1,'7755139002837','Pepsi 355ml',18,1,1.5,1.59,1.88,1.59,0.29,1.88),(8,8,1,'7755139002869','Canchita mantequilla',18,1,3.25,3.44,4.06,3.44,0.62,4.06),(9,9,1,'7755139002830','Big cola 400ml',18,1,1,1.06,1.25,1.06,0.19,1.25),(10,10,1,'7755139002873','Battimix',18,12,2.89,3.06,3.61,36.72,6.61,43.33),(11,11,1,'7755139002873','Battimix',18,12,2.89,3.06,3.61,36.72,6.61,43.33),(12,12,1,'7755139002837','Pepsi 355ml',18,1,1.5,1.59,1.88,1.59,0.29,1.88),(13,12,2,'7755139002873','Battimix',18,2,2.89,3.06,3.61,6.12,1.1,7.22),(14,13,1,'7755139002874','Pringles papas',18,5,2.8,2.97,3.5,14.85,2.67,17.52),(15,14,1,'7755139002902','Deleite 1L',18,2,9.8,10.38,12.25,20.76,3.74,24.5),(16,15,1,'7755139002831','Zuko Piña',18,1,0.9,0.95,1.12,0.95,0.17,1.12),(17,16,1,'7755139002874','Pringles papas',18,2,2.8,2.97,3.5,5.94,1.07,7.01),(18,17,1,'7755139002882','Trozos de atún Campomar',18,2,4.66,4.94,5.83,9.88,1.78,11.66),(19,17,2,'7755139002874','Pringles papas',18,5,2.8,2.97,3.5,14.85,2.67,17.52),(20,18,1,'7755139002812','soda san jorge 40g',18,3,0.5,0.5,0.59,1.5,0.27,1.77),(21,18,2,'7755139002850','Fanta Kola Inglesa 500ml',18,1,1.39,1.41,1.66,1.41,0.25,1.66),(22,19,1,'7755139002876','Faraon amarillo 1k',18,1,3.39,3.59,4.24,3.59,0.65,4.24),(23,20,1,'7755139002830','Big cola 400ml',18,3,1,1.06,1.25,3.18,0.57,3.75),(24,20,2,'7755139002844','Gloria fresa 180ml',18,4,1.5,1.59,1.88,6.36,1.14,7.5),(25,21,1,'7755139002853','Suave pq 2 unid',18,1,1.99,2.11,2.49,2.11,0.38,2.49),(26,22,1,'7755139002811','Gloria evaporada ligth 400g',18,1,3.4,3.6,4.25,3.6,0.65,4.25),(27,23,1,'7755139002832','Zuko Durazno',18,5,0.9,0.95,1.12,4.75,0.86,5.61),(28,23,2,'7755139002872','Valle Norte 750g',18,7,3.1,3.28,3.87,22.96,4.13,27.09);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL AUTO_INCREMENT,
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
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` (`id_empresa`, `razon_social`, `nombre_comercial`, `id_tipo_documento`, `ruc`, `direccion`, `simbolo_moneda`, `email`, `telefono`, `provincia`, `departamento`, `distrito`, `ubigeo`, `certificado_digital`, `clave_certificado`, `usuario_sol`, `clave_sol`, `estado`) VALUES (1,'3D INVERSIONES Y SERVICIOS GENERALES E.I.R.L.','3D INVERSIONES Y SERVICIOS GENERALES E.I.R.L.	','6',10467291240,'CALLE BUENAVENTURA AGUIRRE 302 ','S/ ','cfredes@innred.cl','+56983851526 - +56999688639','LIMA','LIMA','BARRANCO','150104','llama-pe-certificado-demo-20480674414.pfx','123456','moddatos','moddatos',0),(2,'NEGOCIOS WAIMAKU \" E.I.R.L','NEGOCIOS WAIMAKU \" E.I.R.L','6',20480674414,'AV GRAU 123','S/','audio@gmail.com','987654321','LIMA','LIMA','BARRANCO','787878','llama-pe-certificado-demo-20494099153.pfx','123456','moddatos','moddatos',0),(3,'IMPORTACIONES FVC EIRL','IMPORTACIONES FVC EIRL','6',20494099153,'CALLE LIMA 123','S/','empresa@gmail.com','987654321','LIMA','LIMA','JESUS MARIA','124545','llama-pe-certificado-demo-20480674414.pfx','123456','moddatos','moddatos',0),(10,'TUTORIALESPHPERU SAC','TUTOTIALESPHPERU SOLUCIONES WEB','6',10467291241,'CALLE JUAN FANING 302',NULL,'tutorialesphperu@gmail.com','978451245','LIMA','LIMA','BARRANCO','121245','llama-pe-certificado-demo-20480674414.pfx','123456','moddatos','moddatos',1),(15,'LUIS LOZANO','LUIS LOZANO ARICA','6',10452578951,'CALLE FALSA 123',NULL,'','','LIMA','LIMA','LIMA','123456','llama-pe-certificado-demo-20480674414.pfx','123456','D','D',0),(17,'RAZÓN SOCIAL 123456','123456','6',123456,'123456',NULL,'aaaa@hotmail.com','123456','123456','123456','123456','123456',NULL,'123456','123456','123456',0),(18,'COMPU_TIENDA E.I.R.L','COMPU_TIENDA E.I.R.L','6',10123456789,'N/A',NULL,'prueba_de_email@gmail.com','123456789','N/A','N/A','N/A','123456','certificado_phperu.pfx','Emilia1109$','tienda','tienda',0);
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forma_pago`
--

DROP TABLE IF EXISTS `forma_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forma_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forma_pago`
--

LOCK TABLES `forma_pago` WRITE;
/*!40000 ALTER TABLE `forma_pago` DISABLE KEYS */;
INSERT INTO `forma_pago` (`id`, `descripcion`, `estado`) VALUES (1,'Contado',1),(2,'Crédito',1);
/*!40000 ALTER TABLE `forma_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impuestos`
--

DROP TABLE IF EXISTS `impuestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impuestos` (
  `id_tipo_operacion` int(11) NOT NULL,
  `impuesto` float DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id_tipo_operacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impuestos`
--

LOCK TABLES `impuestos` WRITE;
/*!40000 ALTER TABLE `impuestos` DISABLE KEYS */;
INSERT INTO `impuestos` (`id_tipo_operacion`, `impuesto`, `estado`) VALUES (10,18,1),(20,0,1),(30,0,1);
/*!40000 ALTER TABLE `impuestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kardex`
--

DROP TABLE IF EXISTS `kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kardex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `ex_costo_total` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_producto_idx` (`codigo_producto`),
  CONSTRAINT `fk_cod_producto_kardex` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kardex`
--

LOCK TABLES `kardex` WRITE;
/*!40000 ALTER TABLE `kardex` DISABLE KEYS */;
INSERT INTO `kardex` (`id`, `codigo_producto`, `fecha`, `concepto`, `comprobante`, `in_unidades`, `in_costo_unitario`, `in_costo_total`, `out_unidades`, `out_costo_unitario`, `out_costo_total`, `ex_unidades`, `ex_costo_unitario`, `ex_costo_total`) VALUES (1,'7755139002890','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,5.9,141.6,NULL,NULL,NULL,24,5.9,141.6),(2,'7755139002903','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,12.1,278.3,NULL,NULL,NULL,23,12.1,278.3),(3,'7755139002904','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,12.4,359.6,NULL,NULL,NULL,29,12.4,359.6),(4,'7755139002870','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,3.25,84.5,NULL,NULL,NULL,26,3.25,84.5),(5,'7755139002880','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,5.15,118.45,NULL,NULL,NULL,23,5.15,118.45),(6,'7755139002902','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,9.8,284.2,NULL,NULL,NULL,29,9.8,284.2),(7,'7755139002898','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,7.49,202.23,NULL,NULL,NULL,27,7.49,202.23),(8,'7755139002899','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,8,208,NULL,NULL,NULL,26,8,208),(9,'7755139002901','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,10,260,NULL,NULL,NULL,26,10,260),(10,'7755139002810','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,3.79,79.59,NULL,NULL,NULL,21,3.79,79.59),(11,'7755139002878','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,3.99,99.75,NULL,NULL,NULL,25,3.99,99.75),(12,'7755139002838','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,1.29,34.83,NULL,NULL,NULL,27,1.29,34.83),(13,'7755139002839','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,1,27,NULL,NULL,NULL,27,1,27),(14,'7755139002848','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,1.9,47.5,NULL,NULL,NULL,25,1.9,47.5),(15,'7755139002863','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,2.8,75.6,NULL,NULL,NULL,27,2.8,75.6),(16,'7755139002864','2023-11-13 00:00:00','INVENTARIO INICIAL','',20,4.4,88,NULL,NULL,NULL,20,4.4,88),(17,'7755139002865','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,3.79,87.17,NULL,NULL,NULL,23,3.79,87.17),(18,'7755139002866','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,3.79,98.54,NULL,NULL,NULL,26,3.79,98.54),(19,'7755139002867','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,3.65,87.6,NULL,NULL,NULL,24,3.65,87.6),(20,'7755139002868','2023-11-13 00:00:00','INVENTARIO INICIAL','',20,3.5,70,NULL,NULL,NULL,20,3.5,70),(21,'7755139002871','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,3.17,85.59,NULL,NULL,NULL,27,3.17,85.59),(22,'7755139002877','2023-11-13 00:00:00','INVENTARIO INICIAL','',30,5.17,155.1,NULL,NULL,NULL,30,5.17,155.1),(23,'7755139002879','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,4.58,128.24,NULL,NULL,NULL,28,4.58,128.24),(24,'7755139002881','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,5,110,NULL,NULL,NULL,22,5,110),(25,'7755139002882','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,4.66,125.82,NULL,NULL,NULL,27,4.66,125.82),(26,'7755139002883','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,4.65,106.95,NULL,NULL,NULL,23,4.65,106.95),(27,'7755139002884','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,4.63,97.23,NULL,NULL,NULL,21,4.63,97.23),(28,'7755139002885','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,5.7,153.9,NULL,NULL,NULL,27,5.7,153.9),(29,'7755139002887','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,6.08,164.16,NULL,NULL,NULL,27,6.08,164.16),(30,'7755139002888','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,5.9,129.8,NULL,NULL,NULL,22,5.9,129.8),(31,'7755139002889','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,5.9,165.2,NULL,NULL,NULL,28,5.9,165.2),(32,'7755139002891','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,5.9,171.1,NULL,NULL,NULL,29,5.9,171.1),(33,'7755139002892','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,5.08,106.68,NULL,NULL,NULL,21,5.08,106.68),(34,'7755139002893','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,5.63,163.27,NULL,NULL,NULL,29,5.63,163.27),(35,'7755139002895','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,5.9,171.1,NULL,NULL,NULL,29,5.9,171.1),(36,'7755139002896','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,5.9,159.3,NULL,NULL,NULL,27,5.9,159.3),(37,'7755139002897','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,5.33,117.26,NULL,NULL,NULL,22,5.33,117.26),(38,'7755139002900','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,8.9,186.9,NULL,NULL,NULL,21,8.9,186.9),(39,'7755139002886','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,5.7,119.7,NULL,NULL,NULL,21,5.7,119.7),(40,'7755139002809','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,18.29,384.09,NULL,NULL,NULL,21,18.29,384.09),(41,'7755139002874','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,2.8,78.4,NULL,NULL,NULL,28,2.8,78.4),(42,'7755139002830','2023-11-13 00:00:00','INVENTARIO INICIAL','',20,1,20,NULL,NULL,NULL,20,1,20),(43,'7755139002869','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,3.25,68.25,NULL,NULL,NULL,21,3.25,68.25),(44,'7755139002872','2023-11-13 00:00:00','INVENTARIO INICIAL','',30,3.1,93,NULL,NULL,NULL,30,3.1,93),(45,'7755139002876','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,3.39,71.19,NULL,NULL,NULL,21,3.39,71.19),(46,'7755139002852','2023-11-13 00:00:00','INVENTARIO INICIAL','',20,1.3,26,NULL,NULL,NULL,20,1.3,26),(47,'7755139002853','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,1.99,55.72,NULL,NULL,NULL,28,1.99,55.72),(48,'7755139002840','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,1,29,NULL,NULL,NULL,29,1,29),(49,'7755139002894','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,5.4,124.2,NULL,NULL,NULL,23,5.4,124.2),(50,'7755139002814','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,0.53,13.25,NULL,NULL,NULL,25,0.53,13.25),(51,'7755139002831','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,0.9,20.7,NULL,NULL,NULL,23,0.9,20.7),(52,'7755139002832','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,0.9,22.5,NULL,NULL,NULL,25,0.9,22.5),(53,'7755139002835','2023-11-13 00:00:00','INVENTARIO INICIAL','',30,0.67,20.1,NULL,NULL,NULL,30,0.67,20.1),(54,'7755139002846','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,1.39,30.58,NULL,NULL,NULL,22,1.39,30.58),(55,'7755139002847','2023-11-13 00:00:00','INVENTARIO INICIAL','',30,1.39,41.7,NULL,NULL,NULL,30,1.39,41.7),(56,'7755139002850','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,1.39,29.19,NULL,NULL,NULL,21,1.39,29.19),(57,'7755139002851','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,1.39,34.75,NULL,NULL,NULL,25,1.39,34.75),(58,'7755139002854','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,2.8,58.8,NULL,NULL,NULL,21,2.8,58.8),(59,'7755139002855','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,2.6,57.2,NULL,NULL,NULL,22,2.6,57.2),(60,'7755139002856','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,2.6,62.4,NULL,NULL,NULL,24,2.6,62.4),(61,'7755139002857','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,2.19,52.56,NULL,NULL,NULL,24,2.19,52.56),(62,'7755139002861','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,2.19,61.32,NULL,NULL,NULL,28,2.19,61.32),(63,'7755139002811','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,3.4,85,NULL,NULL,NULL,25,3.4,85),(64,'7755139002812','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,0.5,14,NULL,NULL,NULL,28,0.5,14),(65,'7755139002833','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,0.88,21.12,NULL,NULL,NULL,24,0.88,21.12),(66,'7755139002837','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,1.5,36,NULL,NULL,NULL,24,1.5,36),(67,'7755139002815','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,0.37,10.73,NULL,NULL,NULL,29,0.37,10.73),(68,'7755139002817','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,0.68,14.28,NULL,NULL,NULL,21,0.68,14.28),(69,'7755139002822','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,0.52,12.48,NULL,NULL,NULL,24,0.52,12.48),(70,'7755139002823','2023-11-13 00:00:00','INVENTARIO INICIAL','',20,0.52,10.4,NULL,NULL,NULL,20,0.52,10.4),(71,'7755139002824','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,0.52,11.96,NULL,NULL,NULL,23,0.52,11.96),(72,'7755139002826','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,0.47,12.69,NULL,NULL,NULL,27,0.47,12.69),(73,'7755139002827','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,0.47,11.28,NULL,NULL,NULL,24,0.47,11.28),(74,'7755139002828','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,0.47,13.63,NULL,NULL,NULL,29,0.47,13.63),(75,'7755139002842','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,0.9,26.1,NULL,NULL,NULL,29,0.9,26.1),(76,'7755139002818','2023-11-13 00:00:00','INVENTARIO INICIAL','',24,0.62,14.88,NULL,NULL,NULL,24,0.62,14.88),(77,'7755139002836','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,0.56,12.32,NULL,NULL,NULL,22,0.56,12.32),(78,'7755139002825','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,0.5,12.5,NULL,NULL,NULL,25,0.5,12.5),(79,'7755139002849','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,1.8,50.4,NULL,NULL,NULL,28,1.8,50.4),(80,'7755139002875','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,3.69,81.18,NULL,NULL,NULL,22,3.69,81.18),(81,'7755139002860','2023-11-13 00:00:00','INVENTARIO INICIAL','',27,2.8,75.6,NULL,NULL,NULL,27,2.8,75.6),(82,'7755139002813','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,0.33,7.26,NULL,NULL,NULL,22,0.33,7.26),(83,'7755139002816','2023-11-13 00:00:00','INVENTARIO INICIAL','',20,0.43,8.6,NULL,NULL,NULL,20,0.43,8.6),(84,'7755139002829','2023-11-13 00:00:00','INVENTARIO INICIAL','',29,0.75,21.75,NULL,NULL,NULL,29,0.75,21.75),(85,'7755139002819','2023-11-13 00:00:00','INVENTARIO INICIAL','',28,0.6,16.8,NULL,NULL,NULL,28,0.6,16.8),(86,'7755139002834','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,0.85,17.85,NULL,NULL,NULL,21,0.85,17.85),(87,'7755139002841','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,0.92,23.92,NULL,NULL,NULL,26,0.92,23.92),(88,'7755139002843','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,1.06,24.38,NULL,NULL,NULL,23,1.06,24.38),(89,'7755139002844','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,1.5,39,NULL,NULL,NULL,26,1.5,39),(90,'7755139002845','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,1.5,31.5,NULL,NULL,NULL,21,1.5,31.5),(91,'7755139002858','2023-11-13 00:00:00','INVENTARIO INICIAL','',23,2.6,59.8,NULL,NULL,NULL,23,2.6,59.8),(92,'7755139002859','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,3,63,NULL,NULL,NULL,21,3,63),(93,'7755139002862','2023-11-13 00:00:00','INVENTARIO INICIAL','',26,3.2,83.2,NULL,NULL,NULL,26,3.2,83.2),(94,'7755139002873','2023-11-13 00:00:00','INVENTARIO INICIAL','',25,2.89,72.25,NULL,NULL,NULL,25,2.89,72.25),(95,'7755139002820','2023-11-13 00:00:00','INVENTARIO INICIAL','',21,0.57,11.97,NULL,NULL,NULL,21,0.57,11.97),(96,'7755139002821','2023-11-13 00:00:00','INVENTARIO INICIAL','',22,0.53,11.66,NULL,NULL,NULL,22,0.53,11.66),(97,'7755139002809','2023-11-14 00:00:00','VENTA','B001-16',NULL,NULL,NULL,1,18.29,18.29,20,18.29,365.8),(98,'7755139002830','2023-11-14 00:00:00','VENTA','B002-3',NULL,NULL,NULL,12,1,12,8,1,8),(99,'7755139002871','2023-11-14 00:00:00','VENTA','B002-4',NULL,NULL,NULL,2,3.17,6.34,25,3.17,79.25),(100,'7755139002813','2023-11-14 00:00:00','VENTA','FA-35',NULL,NULL,NULL,1,0.33,0.33,21,0.33,6.93),(101,'7755139002815','2023-11-14 00:00:00','VENTA','FA-36',NULL,NULL,NULL,1,0.37,0.37,28,0.37,10.36),(102,'7755139002837','2023-11-14 00:00:00','VENTA','B002-5',NULL,NULL,NULL,1,1.5,1.5,23,1.5,34.5),(103,'7755139002837','2023-11-14 00:00:00','VENTA','B002-6',NULL,NULL,NULL,1,1.5,1.5,22,1.5,33),(104,'7755139002869','2023-11-14 00:00:00','VENTA','B002-7',NULL,NULL,NULL,1,3.25,3.25,20,3.25,65),(105,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,21,3.25,68.25),(106,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,22,3.25,71.5),(107,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,23,3.25,74.75),(108,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,24,3.25,78),(109,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,25,3.25,81.25),(110,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,26,3.25,84.5),(111,'7755139002869','2023-11-14 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,27,3.25,87.75),(112,'7755139002837','2023-11-14 00:00:00','DEVOLUCIÓN','B002-5',1,1.5,1.5,NULL,NULL,NULL,23,1.5,34.5),(113,'7755139002871','2023-11-14 00:00:00','DEVOLUCIÓN','B002-4',2,3.17,6.34,NULL,NULL,NULL,27,3.17,85.59),(114,'7755139002830','2023-11-14 00:00:00','DEVOLUCIÓN','B002-3',12,1,12,NULL,NULL,NULL,20,1,20),(115,'7755139002830','2023-11-14 00:00:00','VENTA','B002-8',NULL,NULL,NULL,1,1,1,19,1,19),(116,'7755139002873','2023-11-14 00:00:00','VENTA','B002-9',NULL,NULL,NULL,12,2.89,34.68,13,2.89,37.57),(117,'7755139002873','2023-11-14 00:00:00','DEVOLUCIÓN','B002-9',12,2.89,34.68,NULL,NULL,NULL,25,2.89,72.25),(118,'7755139002873','2023-11-14 00:00:00','VENTA','B002-10',NULL,NULL,NULL,12,2.89,34.68,13,2.89,37.57),(119,'7755139002873','2023-11-14 00:00:00','DEVOLUCIÓN','B002-10',12,2.89,34.68,NULL,NULL,NULL,25,2.89,72.25),(120,'7755139002873','2023-11-14 00:00:00','DEVOLUCIÓN','B002-10',12,2.89,34.68,NULL,NULL,NULL,37,2.89,106.93),(121,'7755139002837','2023-11-14 00:00:00','VENTA','B002-11',NULL,NULL,NULL,1,1.5,1.5,22,1.5,33),(122,'7755139002873','2023-11-14 00:00:00','VENTA','B002-11',NULL,NULL,NULL,2,2.89,5.78,35,2.89,101.15),(123,'7755139002837','2023-11-14 00:00:00','DEVOLUCIÓN','B002-11',1,1.5,1.5,NULL,NULL,NULL,23,1.5,34.5),(124,'7755139002873','2023-11-14 00:00:00','DEVOLUCIÓN','B002-11',2,2.89,5.78,NULL,NULL,NULL,37,2.89,106.93),(125,'7755139002874','2023-11-15 00:00:00','VENTA','B002-12',NULL,NULL,NULL,5,2.8,14,23,2.8,64.4),(126,'7755139002874','2023-11-15 00:00:00','DEVOLUCIÓN','B002-12',5,2.8,14,NULL,NULL,NULL,28,2.8,78.4),(127,'7755139002902','2023-11-15 00:00:00','VENTA','B002-13',NULL,NULL,NULL,2,9.8,19.6,27,9.8,264.6),(128,'7755139002831','2023-11-15 00:00:00','VENTA','F001-4',NULL,NULL,NULL,1,0.9,0.9,22,0.9,19.8),(129,'7755139002874','2023-11-15 00:00:00','VENTA','B002-14',NULL,NULL,NULL,2,2.8,5.6,26,2.8,72.8),(130,'7755139002874','2023-11-15 00:00:00','DEVOLUCIÓN','B002-14',2,2.8,5.6,NULL,NULL,NULL,28,2.8,78.4),(131,'7755139002882','2023-11-15 00:00:00','VENTA','B002-15',NULL,NULL,NULL,2,4.66,9.32,25,4.66,116.5),(132,'7755139002874','2023-11-15 00:00:00','VENTA','B002-15',NULL,NULL,NULL,5,2.8,14,23,2.8,64.4),(133,'7755139002812','2023-11-15 00:00:00','VENTA','B002-16',NULL,NULL,NULL,3,0.5,1.5,25,0.5,12.5),(134,'7755139002850','2023-11-15 00:00:00','VENTA','B002-16',NULL,NULL,NULL,1,1.39,1.39,20,1.39,27.8),(135,'7755139002869','2023-11-15 00:00:00','DEVOLUCIÓN','B002-7',1,3.25,3.25,NULL,NULL,NULL,28,3.25,91),(136,'7755139002876','2023-11-15 00:00:00','VENTA','B002-17',NULL,NULL,NULL,1,3.39,3.39,20,3.39,67.8),(137,'7755139002876','2023-11-15 00:00:00','DEVOLUCIÓN','B002-17',1,3.39,3.39,NULL,NULL,NULL,21,3.39,71.19),(138,'7755139002899','2023-11-15 00:00:00','AUMENTO DE STOCK POR MODULO DE INVENTARIO','',4,8,32,NULL,NULL,NULL,30,8,240),(139,'7755139002830','2023-11-15 00:00:00','VENTA','B002-18',NULL,NULL,NULL,3,1,3,16,1,16),(140,'7755139002844','2023-11-15 00:00:00','VENTA','B002-18',NULL,NULL,NULL,4,1.5,6,22,1.5,33),(141,'7755139002853','2023-11-15 00:00:00','VENTA','B002-19',NULL,NULL,NULL,1,1.99,1.99,27,1.99,53.73),(142,'7755139002811','2023-11-15 00:00:00','VENTA','B002-20',NULL,NULL,NULL,1,3.4,3.4,24,3.4,81.6),(143,'7755139002832','2023-11-16 00:00:00','VENTA','B002-21',NULL,NULL,NULL,5,0.9,4.5,20,0.9,18),(144,'7755139002872','2023-11-16 00:00:00','VENTA','B002-21',NULL,NULL,NULL,7,3.1,21.7,23,3.1,71.3);
/*!40000 ALTER TABLE `kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulos`
--

DROP TABLE IF EXISTS `modulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(45) DEFAULT NULL,
  `padre_id` int(11) DEFAULT NULL,
  `vista` varchar(45) DEFAULT NULL,
  `icon_menu` varchar(45) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulos`
--

LOCK TABLES `modulos` WRITE;
/*!40000 ALTER TABLE `modulos` DISABLE KEYS */;
INSERT INTO `modulos` (`id`, `modulo`, `padre_id`, `vista`, `icon_menu`, `orden`, `fecha_creacion`, `fecha_actualizacion`) VALUES (1,'Tablero Principal',0,'dashboard.php','fas fa-tachometer-alt',0,NULL,NULL),(2,'Punto de Venta',0,'','fas fa-file-invoice-dollar',1,NULL,NULL),(3,'Punto de Venta',0,'ventas.php','far fa-circle',7,NULL,NULL),(4,'Administrar Ventas',2,'administrar_ventas.php','far fa-circle',6,NULL,NULL),(5,'Productos',0,NULL,'fas fa-cart-plus',8,NULL,NULL),(6,'Inventario',5,'productos.php','far fa-circle',10,NULL,NULL),(7,'Carga Masiva',5,'carga_masiva_productos.php','far fa-circle',11,NULL,NULL),(8,'Categorías',5,'categorias.php','far fa-circle',9,NULL,NULL),(9,'Compras',0,'compras.php','fas fa-dolly',14,NULL,NULL),(10,'Reportes',0,'','fas fa-chart-pie',15,NULL,NULL),(11,'Administracion',0,NULL,'fas fa-cogs',20,NULL,NULL),(13,'Módulos / Perfiles',31,'seguridad_modulos_perfiles.php','far fa-circle',31,NULL,NULL),(15,'Caja',0,'caja.php','fas fa-cash-register',12,'2022-12-05 14:44:08',NULL),(22,'Tipo Afectación',11,'administrar_tipo_afectacion.php','far fa-circle',26,'2023-09-22 05:46:29',NULL),(23,'Tipo Comprobante',11,'administrar_tipo_comprobante.php','far fa-circle',25,'2023-09-22 05:50:12',NULL),(24,'Series',11,'administrar_series.php','far fa-circle',27,'2023-09-22 06:15:56',NULL),(25,'Clientes',11,'administrar_clientes.php','far fa-circle',22,'2023-09-22 06:19:20',NULL),(26,'Proveedores',11,'administrar_proveedores.php','far fa-circle',23,'2023-09-22 06:19:31',NULL),(27,'Empresa',11,'administrar_empresas.php','far fa-circle',21,'2023-09-22 06:20:56',NULL),(28,'Emitir Boleta',2,'venta_boleta.php','far fa-circle',2,'2023-09-26 15:46:51',NULL),(29,'Emitir Factura',2,'venta_factura.php','far fa-circle',4,'2023-09-26 15:47:09',NULL),(30,'Resumen de Boletas',2,'venta_resumen_boletas.php','far fa-circle',3,'2023-09-26 15:47:39',NULL),(31,'Seguridad',0,'','fas fa-user-shield',28,'2023-09-26 21:03:11',NULL),(33,'Perfiles',31,'seguridad_perfiles.php','far fa-circle',29,'2023-09-26 21:04:53',NULL),(34,'Usuarios',31,'seguridad_usuarios.php','far fa-circle',30,'2023-09-26 21:05:08',NULL),(37,'Tipo Documento',11,'administrar_tipo_documento.php','far fa-circle',24,'2023-09-30 04:07:02',NULL),(38,'Kardex Totalizado',10,'reporte_kardex_totalizado.php','far fa-circle',16,'2023-09-30 04:07:02',NULL),(39,'Ventas x Categoría',10,'reporte_ventas.php','far fa-circle',18,'2023-09-30 04:07:02',NULL),(40,'Ventas x Producto',10,'reporte_ventas_producto.php','far fa-circle',19,'2023-09-30 04:07:02',NULL),(41,'Nota de Crédito',2,'venta_nota_credito.php','far fa-circle',5,NULL,NULL),(42,'Kardex x Producto',10,'reporte_kardex_por_producto.php','far fa-circle',17,NULL,NULL),(43,'Cuentas x Cobrar',0,'cuentas_x_cobrar.php','far fa-credit-card',13,'2023-11-02 00:25:12','2023-11-01 20:25:12');
/*!40000 ALTER TABLE `modulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moneda`
--

DROP TABLE IF EXISTS `moneda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moneda` (
  `id` char(3) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `simbolo` char(5) DEFAULT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moneda`
--

LOCK TABLES `moneda` WRITE;
/*!40000 ALTER TABLE `moneda` DISABLE KEYS */;
INSERT INTO `moneda` (`id`, `descripcion`, `simbolo`, `estado`) VALUES ('PEN','SOLES','S/',1),('USD','DOLARES','$',1);
/*!40000 ALTER TABLE `moneda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motivos_notas`
--

DROP TABLE IF EXISTS `motivos_notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motivos_notas` (
  `id` int(11) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motivos_notas`
--

LOCK TABLES `motivos_notas` WRITE;
/*!40000 ALTER TABLE `motivos_notas` DISABLE KEYS */;
INSERT INTO `motivos_notas` (`id`, `tipo`, `codigo`, `descripcion`) VALUES (1,'C','01','Anulación de la operación'),(2,'C','02','Anulación por error en el RUC'),(3,'C','03','Corrección por error en la descripción'),(4,'C','04','Descuento global'),(5,'C','05','Descuento por ítem'),(6,'C','06','Devolución total'),(7,'C','07','Devolución por ítem'),(8,'C','08','Bonificación'),(9,'C','09','Disminución en el valor'),(10,'C','10','Otros Conceptos'),(11,'C','11','Ajustes de operaciones de exportación'),(12,'C','12','Ajustes afectos al IVAP'),(13,'C','13','Ajustes en las CUOTAS'),(14,'D','01','Intereses por mora'),(15,'D','02','Aumento en el valor'),(16,'D','03','Penalidades/ otros conceptos'),(17,'D','10','Ajustes de operaciones de exportación'),(18,'D','11','Ajustes afectos al IVAP');
/*!40000 ALTER TABLE `motivos_notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_arqueo_caja`
--

DROP TABLE IF EXISTS `movimientos_arqueo_caja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimientos_arqueo_caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_arqueo_caja` int(11) DEFAULT NULL,
  `id_tipo_movimiento` int(11) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `monto` float DEFAULT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_arqueo_caja`
--

LOCK TABLES `movimientos_arqueo_caja` WRITE;
/*!40000 ALTER TABLE `movimientos_arqueo_caja` DISABLE KEYS */;
INSERT INTO `movimientos_arqueo_caja` (`id`, `id_arqueo_caja`, `id_tipo_movimiento`, `descripcion`, `monto`, `estado`) VALUES (1,1,4,'APERTURA CAJA',100000,1),(2,1,2,'COCA COLA',5000,1),(3,2,4,'APERTURA CAJA',100,1),(4,3,4,'APERTURA CAJA',100000,1),(5,0,4,'APERTURA CAJA',200,1),(6,0,4,'APERTURA CAJA',0,1),(7,0,4,'APERTURA CAJA',0,1),(8,0,4,'APERTURA CAJA',10,1),(9,0,4,'APERTURA CAJA',0,1),(10,4,4,'APERTURA CAJA',0,1),(11,4,3,'INGRESO - Contado',22.86,1),(12,5,4,'APERTURA CAJA',50,1),(13,5,3,'INGRESO - Contado',15.01,1),(14,5,3,'INGRESO - Contado',7.93,1),(15,5,3,'INGRESO - Contado',0.41,1),(16,5,3,'INGRESO - Contado',0.46,1),(17,5,3,'INGRESO - Contado',1.88,1),(18,5,3,'INGRESO - Contado',1.88,1),(19,5,3,'INGRESO - Contado',4.06,1),(20,5,3,'INGRESO - Contado',1.25,1),(21,5,3,'INGRESO - Contado',43.33,1),(22,5,3,'INGRESO - Contado',43.33,1),(23,5,3,'INGRESO - Contado',1.88,1),(24,5,3,'INGRESO - Contado',7.22,1),(25,0,4,'APERTURA CAJA',100,1),(26,6,4,'APERTURA CAJA',100,1),(27,6,3,'INGRESO - Credito',17.52,1),(28,6,3,'INGRESO - Contado',24.5,1),(29,6,3,'INGRESO - Credito',1.12,1),(30,6,3,'INGRESO - Contado',7.01,1),(31,6,3,'INGRESO - Contado',11.66,1),(32,6,3,'INGRESO - Contado',17.52,1),(33,6,3,'PAGO CUOTA DE FACTURA',1.12,1),(34,6,3,'INGRESO - Contado',1.77,1),(35,6,3,'INGRESO - Contado',1.66,1),(36,0,4,'APERTURA CAJA',500,1),(37,6,3,'INGRESO - Contado',4.24,1),(38,6,3,'INGRESO - Contado',3.75,1),(39,6,3,'INGRESO - Contado',7.5,1),(40,6,3,'INGRESO - Contado',2.49,1),(41,6,3,'INGRESO - Contado',4.25,1),(42,7,4,'APERTURA CAJA',400,1),(43,7,3,'INGRESO - Contado',5.61,1),(44,7,3,'INGRESO - Contado',27.09,1);
/*!40000 ALTER TABLE `movimientos_arqueo_caja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil_modulo`
--

DROP TABLE IF EXISTS `perfil_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfil_modulo` (
  `idperfil_modulo` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) DEFAULT NULL,
  `id_modulo` int(11) DEFAULT NULL,
  `vista_inicio` tinyint(4) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idperfil_modulo`),
  KEY `id_perfil` (`id_perfil`),
  KEY `id_modulo` (`id_modulo`),
  CONSTRAINT `id_modulo` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1135 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_modulo`
--

LOCK TABLES `perfil_modulo` WRITE;
/*!40000 ALTER TABLE `perfil_modulo` DISABLE KEYS */;
INSERT INTO `perfil_modulo` (`idperfil_modulo`, `id_perfil`, `id_modulo`, `vista_inicio`, `estado`) VALUES (1051,8,28,0,1),(1052,8,2,0,1),(1053,8,30,0,1),(1054,8,29,0,1),(1055,8,41,0,1),(1056,8,4,0,1),(1057,8,3,0,1),(1058,8,8,0,1),(1059,8,5,0,1),(1060,8,6,0,1),(1061,8,7,0,1),(1062,8,15,0,1),(1063,8,43,0,1),(1064,8,9,0,1),(1065,8,38,0,1),(1066,8,10,0,1),(1067,8,42,0,1),(1068,8,39,0,1),(1069,8,40,0,1),(1070,8,27,0,1),(1071,8,11,0,1),(1072,8,25,0,1),(1073,8,26,0,1),(1074,8,37,0,1),(1075,8,23,0,1),(1076,8,22,0,1),(1077,8,24,0,1),(1078,8,33,0,1),(1079,8,31,0,1),(1080,8,34,0,1),(1081,8,13,0,1),(1082,8,1,1,1),(1083,1,1,0,1),(1084,1,28,0,1),(1085,1,2,0,1),(1086,1,30,0,1),(1087,1,29,0,1),(1088,1,41,1,1),(1089,1,4,0,1),(1090,1,3,0,1),(1091,1,8,0,1),(1092,1,5,0,1),(1093,1,6,0,1),(1094,1,7,0,1),(1095,1,15,0,1),(1096,1,9,0,1),(1097,1,38,0,1),(1098,1,10,0,1),(1099,1,42,0,1),(1100,1,39,0,1),(1101,1,40,0,1),(1102,1,27,0,1),(1103,1,11,0,1),(1104,1,25,0,1),(1105,1,26,0,1),(1106,1,37,0,1),(1107,1,23,0,1),(1108,1,22,0,1),(1109,1,24,0,1),(1110,2,1,0,1),(1111,2,28,0,1),(1112,2,2,0,1),(1113,2,30,0,1),(1114,2,29,0,1),(1115,2,41,1,1),(1116,2,8,0,1),(1117,2,5,0,1),(1118,2,6,0,1),(1119,2,15,0,1),(1120,2,43,0,1),(1121,2,9,0,1),(1122,2,38,0,1),(1123,2,10,0,1),(1124,2,42,0,1),(1125,2,39,0,1),(1126,2,40,0,1),(1127,2,27,0,1),(1128,2,11,0,1),(1129,2,25,0,1),(1130,2,26,0,1),(1131,2,37,0,1),(1132,2,23,0,1),(1133,2,22,0,1),(1134,2,24,0,1);
/*!40000 ALTER TABLE `perfil_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perfiles` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
INSERT INTO `perfiles` (`id_perfil`, `descripcion`, `estado`, `fecha_creacion`, `fecha_actualizacion`) VALUES (1,'ADMINISTRADOR',1,NULL,NULL),(2,'VENDEDOR',1,NULL,NULL),(3,'MESERO',1,NULL,NULL),(4,'DEMO POS',1,NULL,NULL),(5,'PERFIL DEMO PERFIL DEMO PERFIL DEMO PERFIL DE',1,NULL,NULL),(6,'PERFIL DEMO HOSTING IFASNET',1,NULL,NULL),(7,'ADMINISTRADOR',1,NULL,NULL),(8,'SUPERADMINISTRADOR',1,NULL,NULL);
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `codigo_producto` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
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
  `estado` int(1) DEFAULT 1,
  PRIMARY KEY (`codigo_producto`),
  UNIQUE KEY `codigo_producto_UNIQUE` (`codigo_producto`),
  KEY `fk_id_categoria_idx` (`id_categoria`),
  CONSTRAINT `fk_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`codigo_producto`, `id_categoria`, `descripcion`, `id_tipo_afectacion_igv`, `id_unidad_medida`, `costo_unitario`, `precio_unitario_con_igv`, `precio_unitario_sin_igv`, `precio_unitario_mayor_con_igv`, `precio_unitario_mayor_sin_igv`, `precio_unitario_oferta_con_igv`, `precio_unitario_oferta_sin_igv`, `stock`, `minimo_stock`, `ventas`, `costo_total`, `imagen`, `fecha_creacion`, `fecha_actualizacion`, `estado`) VALUES ('7755139002809',12,'Paisana extra 5k',10,'NIU',18.29,22.86,19.37,21.95,18.6,21.4,18.13,20,11,1,365.8,'no_image.jpg','2023-11-14 16:40:13',NULL,1),('7755139002810',11,'Gloria Fresa 500ml',10,'NIU',3.79,4.74,4.01,4.55,3.85,4.43,3.76,21,11,0,79.59,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002811',13,'Gloria evaporada ligth 400g',10,'NIU',3.4,4.25,3.6,4.08,3.46,3.98,3.37,24,15,1,81.6,'no_image.jpg','2023-11-16 02:28:52',NULL,1),('7755139002812',19,'soda san jorge 40g',10,'NIU',0.5,0.62,0.53,0.6,0.51,0.58,0.5,25,18,3,12.5,'no_image.jpg','2023-11-15 15:14:57',NULL,1),('7755139002813',19,'vainilla field 37g',10,'NIU',0.33,0.41,0.35,0.4,0.34,0.39,0.33,21,12,1,6.93,'no_image.jpg','2023-11-14 22:45:31',NULL,1),('7755139002814',19,'Margarita',10,'NIU',0.53,0.66,0.56,0.64,0.54,0.62,0.53,25,15,0,13.25,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002815',19,'soda field 34g',10,'NIU',0.37,0.46,0.39,0.44,0.38,0.43,0.37,28,19,1,10.36,'no_image.jpg','2023-11-14 22:46:58',NULL,1),('7755139002816',19,'ritz original',10,'NIU',0.43,0.54,0.46,0.52,0.44,0.5,0.43,20,10,0,8.6,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002817',19,'ritz queso 34g',10,'NIU',0.68,0.85,0.72,0.82,0.69,0.8,0.67,21,11,0,14.28,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002818',16,'Chocobum',10,'NIU',0.62,0.77,0.66,0.74,0.63,0.73,0.61,24,14,0,14.88,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002819',19,'Picaras',10,'NIU',0.6,0.75,0.64,0.72,0.61,0.7,0.59,28,18,0,16.8,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002820',19,'oreo original 36g',10,'NIU',0.57,0.71,0.6,0.68,0.58,0.67,0.57,21,11,0,11.97,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002821',19,'club social 26g',10,'NIU',0.53,0.66,0.56,0.64,0.54,0.62,0.53,22,12,0,11.66,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002822',19,'frac vanilla 45.5g',10,'NIU',0.52,0.65,0.55,0.62,0.53,0.61,0.52,24,14,0,12.48,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002823',19,'frac chocolate 45.5g',10,'NIU',0.52,0.65,0.55,0.62,0.53,0.61,0.52,20,10,0,10.4,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002824',19,'frac chasica 45.5g',10,'NIU',0.52,0.65,0.55,0.62,0.53,0.61,0.52,23,13,0,11.96,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002825',16,'tuyo 22g',10,'NIU',0.5,0.62,0.53,0.6,0.51,0.58,0.5,25,15,0,12.5,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002826',19,'gn rellenitas 36g chocolate',10,'NIU',0.47,0.59,0.5,0.56,0.48,0.55,0.47,27,17,0,12.69,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002827',19,'gn rellenitas 36g coco',10,'NIU',0.47,0.59,0.5,0.56,0.48,0.55,0.47,24,14,0,11.28,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002828',19,'gn rellenitas 36g coco',10,'NIU',0.47,0.59,0.5,0.56,0.48,0.55,0.47,29,19,0,13.63,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002829',16,'cancun',10,'NIU',0.75,0.94,0.79,0.9,0.76,0.88,0.74,29,19,0,21.75,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002830',9,'Big cola 400ml',10,'NIU',1,1.25,1.06,1.2,1.02,1.17,0.99,16,10,16,16,'no_image.jpg','2023-11-15 21:07:51',NULL,1),('7755139002831',7,'Zuko Piña',10,'NIU',0.9,1.12,0.95,1.08,0.92,1.05,0.89,22,13,1,19.8,'no_image.jpg','2023-11-15 12:45:51',NULL,1),('7755139002832',7,'Zuko Durazno',10,'NIU',0.9,1.12,0.95,1.08,0.92,1.05,0.89,20,15,5,18,'no_image.jpg','2023-11-16 07:05:10',NULL,1),('7755139002833',16,'chin chin 32g',10,'NIU',0.88,1.1,0.93,1.06,0.89,1.03,0.87,24,14,0,21.12,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002834',19,'Morocha 30g',10,'NIU',0.85,1.06,0.9,1.02,0.86,0.99,0.84,21,11,0,17.85,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002835',7,'Zuko Emoliente',10,'NIU',0.67,0.84,0.71,0.8,0.68,0.78,0.66,30,20,0,20.1,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002836',19,'Choco donuts',10,'NIU',0.56,0.7,0.59,0.67,0.57,0.66,0.56,22,12,0,12.32,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002837',9,'Pepsi 355ml',10,'NIU',1.5,1.88,1.59,1.8,1.53,1.75,1.49,23,14,3,34.5,'no_image.jpg','2023-11-15 00:21:23',NULL,1),('7755139002838',4,'Quaker 120gr',10,'NIU',1.29,1.61,1.37,1.55,1.31,1.51,1.28,27,17,0,34.83,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002839',6,'Pulp Durazno 315ml',10,'NIU',1,1.25,1.06,1.2,1.02,1.17,0.99,27,17,0,27,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002840',19,'morochas wafer 37g',10,'NIU',1,1.25,1.06,1.2,1.02,1.17,0.99,29,19,0,29,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002841',16,'Wafer sublime',10,'NIU',0.92,1.15,0.97,1.1,0.94,1.08,0.91,26,16,0,23.92,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002842',19,'hony bran 33g',10,'NIU',0.9,1.12,0.95,1.08,0.92,1.05,0.89,29,19,0,26.1,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002843',16,'Sublime clásico',10,'NIU',1.06,1.33,1.12,1.27,1.08,1.24,1.05,23,13,0,24.38,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002844',11,'Gloria fresa 180ml',10,'NIU',1.5,1.88,1.59,1.8,1.53,1.75,1.49,22,16,4,33,'no_image.jpg','2023-11-15 21:07:51',NULL,1),('7755139002845',11,'Gloria durazno 180ml',10,'NIU',1.5,1.88,1.59,1.8,1.53,1.75,1.49,21,11,0,31.5,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002846',11,'Frutado fresa vasito',10,'NIU',1.39,1.74,1.47,1.67,1.41,1.63,1.38,22,12,0,30.58,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002847',11,'Frutado durazno vasito',10,'NIU',1.39,1.74,1.47,1.67,1.41,1.63,1.38,30,20,0,41.7,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002848',4,'3 ositos quinua',10,'NIU',1.9,2.38,2.01,2.28,1.93,2.22,1.88,25,15,0,47.5,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002849',9,'Seven Up 500ml',10,'NIU',1.8,2.25,1.91,2.16,1.83,2.11,1.78,28,18,0,50.4,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002850',9,'Fanta Kola Inglesa 500ml',10,'NIU',1.39,1.74,1.47,1.67,1.41,1.63,1.38,20,11,1,27.8,'no_image.jpg','2023-11-15 15:14:57',NULL,1),('7755139002851',9,'Fanta Naranja 500ml',10,'NIU',1.39,1.74,1.47,1.67,1.41,1.63,1.38,25,15,0,34.75,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002852',14,'Noble pq 2 unid',10,'NIU',1.3,1.62,1.38,1.56,1.32,1.52,1.29,20,10,0,26,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002853',14,'Suave pq 2 unid',10,'NIU',1.99,2.49,2.11,2.39,2.02,2.33,1.97,27,18,1,53.73,'no_image.jpg','2023-11-15 23:28:57',NULL,1),('7755139002854',9,'Pepsi 750ml',10,'NIU',2.8,3.5,2.97,3.36,2.85,3.28,2.78,21,11,0,58.8,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002855',9,'Coca cola 600ml',10,'NIU',2.6,3.25,2.75,3.12,2.64,3.04,2.58,22,12,0,57.2,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002856',9,'Inca Kola 600ml',10,'NIU',2.6,3.25,2.75,3.12,2.64,3.04,2.58,24,14,0,62.4,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002857',14,'Elite Megarrollo',10,'NIU',2.19,2.74,2.32,2.63,2.23,2.56,2.17,24,14,0,52.56,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002858',13,'Pura vida 395g',10,'NIU',2.6,3.25,2.75,3.12,2.64,3.04,2.58,23,13,0,59.8,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002859',13,'Ideal cremosita 395g',10,'NIU',3,3.75,3.18,3.6,3.05,3.51,2.97,21,11,0,63,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002860',13,'Ideal Light 395g',10,'NIU',2.8,3.5,2.97,3.36,2.85,3.28,2.78,27,17,0,75.6,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002861',11,'Fresa 370ml Laive',10,'NIU',2.19,2.74,2.32,2.63,2.23,2.56,2.17,28,18,0,61.32,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002862',13,'Gloria evaporada entera',10,'NIU',3.2,4,3.39,3.84,3.25,3.74,3.17,26,16,0,83.2,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002863',13,'Laive Ligth caja 480ml',10,'NIU',2.8,3.5,2.97,3.36,2.85,3.28,2.78,27,17,0,75.6,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002864',9,'Pepsi 1.5L',10,'NIU',4.4,5.5,4.66,5.28,4.47,5.15,4.36,20,10,0,88,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002865',11,'Gloria durazno 500ml',10,'NIU',3.79,4.74,4.01,4.55,3.85,4.43,3.76,23,13,0,87.17,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002866',11,'Gloria Vainilla Francesa 500ml',10,'NIU',3.79,4.74,4.01,4.55,3.85,4.43,3.76,26,16,0,98.54,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002867',11,'Griego gloria',10,'NIU',3.65,4.56,3.87,4.38,3.71,4.27,3.62,24,14,0,87.6,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002868',9,'Sabor Oro 1.7L',10,'NIU',3.5,4.38,3.71,4.2,3.56,4.09,3.47,20,10,0,70,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002869',3,'Canchita mantequilla',10,'NIU',3.25,4.06,3.44,3.9,3.31,3.8,3.22,28,11,1,91,'no_image.jpg','2023-11-15 16:04:43',NULL,1),('7755139002870',3,'Canchita natural',10,'NIU',3.25,4.06,3.44,3.9,3.31,3.8,3.22,26,16,0,84.5,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002871',13,'Laive sin lactosa caja 480ml',10,'NIU',3.17,3.96,3.36,3.8,3.22,3.71,3.14,27,17,2,85.59,'no_image.jpg','2023-11-14 23:55:00',NULL,1),('7755139002872',12,'Valle Norte 750g',10,'NIU',3.1,3.88,3.28,3.72,3.15,3.63,3.07,23,20,7,71.3,'no_image.jpg','2023-11-16 07:05:10',NULL,1),('7755139002873',11,'Battimix',10,'NIU',2.89,3.61,3.06,3.47,2.94,3.38,2.87,37,15,26,106.93,'no_image.jpg','2023-11-15 00:21:23',NULL,1),('7755139002874',3,'Pringles papas',10,'NIU',2.8,3.5,2.97,3.36,2.85,3.28,2.78,23,18,12,64.4,'no_image.jpg','2023-11-15 12:51:53',NULL,1),('7755139002875',12,'Costeño 750g',10,'NIU',3.69,4.61,3.91,4.43,3.75,4.32,3.66,22,12,0,81.18,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002876',12,'Faraon amarillo 1k',10,'NIU',3.39,4.24,3.59,4.07,3.45,3.97,3.36,21,11,1,71.19,'no_image.jpg','2023-11-15 16:09:24',NULL,1),('7755139002877',15,'A1 Trozos',10,'NIU',5.17,6.46,5.48,6.2,5.26,6.05,5.13,30,20,0,155.1,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002878',14,'Nova pq 2 unid',10,'NIU',3.99,4.99,4.23,4.79,4.06,4.67,3.96,25,15,0,99.75,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002879',14,'Suave pq 4 unid',10,'NIU',4.58,5.72,4.85,5.5,4.66,5.36,4.54,28,18,0,128.24,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002880',15,'Florida Trozos',10,'NIU',5.15,6.44,5.46,6.18,5.24,6.03,5.11,23,13,0,118.45,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002881',14,'Paracas pq 4 unid',10,'NIU',5,6.25,5.3,6,5.08,5.85,4.96,22,12,0,110,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002882',15,'Trozos de atún Campomar',10,'NIU',4.66,5.82,4.94,5.59,4.74,5.45,4.62,25,17,2,116.5,'no_image.jpg','2023-11-15 12:51:53',NULL,1),('7755139002883',15,'A1 Filete',10,'NIU',4.65,5.81,4.93,5.58,4.73,5.44,4.61,23,13,0,106.95,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002884',15,'Real Trozos',10,'NIU',4.63,5.79,4.9,5.56,4.71,5.42,4.59,21,11,0,97.23,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002885',11,'Durazno 1L laive',10,'NIU',5.7,7.12,6.04,6.84,5.8,6.67,5.65,27,17,0,153.9,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002886',11,'Fresa 1L Laive',10,'NIU',5.7,7.12,6.04,6.84,5.8,6.67,5.65,21,11,0,119.7,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002887',15,'A1 Filete Ligth',10,'NIU',6.08,7.6,6.44,7.3,6.18,7.11,6.03,27,17,0,164.16,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002888',11,'Lúcuma 1L Gloria',10,'NIU',5.9,7.38,6.25,7.08,6,6.9,5.85,22,12,0,129.8,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002889',11,'Fresa 1L Gloria',10,'NIU',5.9,7.38,6.25,7.08,6,6.9,5.85,28,18,0,165.2,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002890',11,'Milkito fresa 1L',10,'NIU',5.9,7.38,6.25,7.08,6,6.9,5.85,24,14,0,141.6,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002891',11,'Gloria Durazno 1L',10,'NIU',5.9,7.38,6.25,7.08,6,6.9,5.85,29,19,0,171.1,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002892',15,'Filete de atún Campomar',10,'NIU',5.08,6.35,5.38,6.1,5.17,5.94,5.04,21,11,0,106.68,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002893',15,'Florida Filete Ligth',10,'NIU',5.63,7.04,5.96,6.76,5.73,6.59,5.58,29,19,0,163.27,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002894',15,'Filete de atún Florida',10,'NIU',5.4,6.75,5.72,6.48,5.49,6.32,5.35,23,13,0,124.2,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002895',9,'Inca Kola 1.5L',10,'NIU',5.9,7.38,6.25,7.08,6,6.9,5.85,29,19,0,171.1,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002896',9,'Coca Cola 1.5L',10,'NIU',5.9,7.38,6.25,7.08,6,6.9,5.85,27,17,0,159.3,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002897',5,'Red Bull 250ml',10,'NIU',5.33,6.66,5.65,6.4,5.42,6.24,5.28,22,12,0,117.26,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002898',9,'SPRITE 3L',10,'NIU',7.49,9.36,7.93,8.99,7.62,8.76,7.43,27,17,0,202.23,'no_image.jpg','2023-11-15 20:54:13','2023-11-15',1),('7755139002899',9,'Pepsi 3L',10,'NIU',8,10,8.47,9.6,8.14,9.36,7.93,30,16,0,240,'no_image.jpg','2023-11-15 21:03:36',NULL,1),('7755139002900',13,'Laive 200gr',10,'NIU',8.9,11.12,9.43,10.68,9.05,10.41,8.82,21,11,0,186.9,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002901',10,'GLORIA POTE CON SAL',10,'KGM',10,11.49,9.74,11.03,9.35,10.75,9.11,26,16,0,260,'no_image.jpg','2023-11-15 13:02:22','2023-11-15',1),('7755139002902',10,'DELEITE 1L',10,'NIU',9.8,12.25,10.38,11.76,9.97,11.47,9.72,27,19,2,264.6,'6554d5ecad439_298.png','2023-11-15 14:30:04','2023-11-15',1),('7755139002903',10,'Sao 1L',10,'NIU',12.1,15.12,12.82,14.52,12.31,14.16,12,23,13,0,278.3,'no_image.jpg','2023-11-14 00:02:59',NULL,1),('7755139002904',10,'Cocinero 1L',10,'NIU',12.4,15.5,13.14,14.88,12.61,14.51,12.29,29,19,0,359.6,'no_image.jpg','2023-11-15 05:31:22',NULL,0);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_documento` varchar(45) NOT NULL,
  `ruc` varchar(45) NOT NULL,
  `razon_social` varchar(150) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` (`id`, `id_tipo_documento`, `ruc`, `razon_social`, `direccion`, `telefono`, `estado`) VALUES (1,'1','78457125','JGJGJGJGKJ','hjkhkjhjkhkjh','46875123',1),(2,'6','JGJGJGJGKJ','HJKHKJHJKHKJH','46875123','ACTIVO',1);
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resumenes`
--

DROP TABLE IF EXISTS `resumenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resumenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_envio` date DEFAULT NULL,
  `fecha_referencia` date DEFAULT NULL,
  `correlativo` int(11) DEFAULT NULL,
  `resumen` smallint(6) DEFAULT NULL,
  `baja` smallint(6) DEFAULT NULL,
  `nombrexml` varchar(50) DEFAULT NULL,
  `mensaje_sunat` varchar(200) DEFAULT NULL,
  `codigo_sunat` varchar(20) DEFAULT NULL,
  `ticket` varchar(50) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resumenes`
--

LOCK TABLES `resumenes` WRITE;
/*!40000 ALTER TABLE `resumenes` DISABLE KEYS */;
INSERT INTO `resumenes` (`id`, `fecha_envio`, `fecha_referencia`, `correlativo`, `resumen`, `baja`, `nombrexml`, `mensaje_sunat`, `codigo_sunat`, `ticket`, `estado`) VALUES (1,'2023-11-14','2023-11-14',1,1,0,NULL,NULL,NULL,NULL,'0'),(2,'2023-11-14','2023-11-14',2,1,0,NULL,NULL,NULL,NULL,'0'),(3,'2023-11-14','2023-11-14',3,1,0,NULL,NULL,NULL,NULL,'0'),(4,'2023-11-14','2023-11-14',4,1,0,NULL,NULL,NULL,NULL,'0'),(5,'2023-11-14','2023-11-14',5,1,0,NULL,NULL,NULL,NULL,'0'),(6,'2023-11-14','2023-11-14',6,1,0,NULL,NULL,NULL,NULL,'0'),(7,'2023-11-14','2023-11-14',7,1,0,NULL,NULL,NULL,NULL,'0'),(8,'2023-11-14','2023-11-14',8,1,0,NULL,NULL,NULL,NULL,'0'),(9,'2023-11-14','2023-11-14',9,1,0,NULL,NULL,NULL,NULL,'0'),(10,'2023-11-14','2023-11-14',10,1,0,NULL,NULL,NULL,NULL,'0'),(11,'2023-11-14','2023-11-14',11,1,0,NULL,NULL,NULL,NULL,'0'),(12,'2023-11-14','2023-11-14',12,1,0,NULL,NULL,NULL,NULL,'0'),(13,'2023-11-14','2023-11-14',13,1,0,NULL,NULL,NULL,NULL,'0'),(14,'2023-11-14','2023-11-14',14,1,0,NULL,NULL,NULL,NULL,'0'),(15,'2023-11-15','2023-11-15',1,1,0,NULL,NULL,NULL,NULL,'0'),(16,'2023-11-15','2023-11-15',2,1,0,NULL,NULL,NULL,NULL,'0'),(17,'2023-11-15','2023-11-15',3,1,0,NULL,NULL,NULL,NULL,'0'),(18,'2023-11-15','2023-11-15',4,1,0,NULL,NULL,NULL,NULL,'0');
/*!40000 ALTER TABLE `resumenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resumenes_detalle`
--

DROP TABLE IF EXISTS `resumenes_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resumenes_detalle` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `id_envio` int(11) DEFAULT NULL,
  `id_comprobante` int(11) DEFAULT NULL,
  `condicion` smallint(6) DEFAULT NULL COMMENT '1->Creacion, 2->Actualizacion, 3->Baja',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_id_envio` (`id_envio`) USING BTREE,
  KEY `fk_idventa` (`id_comprobante`) USING BTREE,
  CONSTRAINT `fk_id_envio` FOREIGN KEY (`id_envio`) REFERENCES `resumenes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resumenes_detalle`
--

LOCK TABLES `resumenes_detalle` WRITE;
/*!40000 ALTER TABLE `resumenes_detalle` DISABLE KEYS */;
INSERT INTO `resumenes_detalle` (`id`, `id_envio`, `id_comprobante`, `condicion`) VALUES (1,1,8,1),(2,2,8,1),(3,3,8,1),(4,4,8,1),(5,5,8,1),(6,6,8,1),(7,7,8,1),(8,8,6,1),(9,9,3,1),(10,10,2,1),(11,11,10,1),(12,12,11,1),(13,13,11,3),(14,14,12,1),(15,15,13,3),(16,16,16,1),(17,17,8,3),(18,18,19,1);
/*!40000 ALTER TABLE `resumenes_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serie`
--

DROP TABLE IF EXISTS `serie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_comprobante` varchar(3) NOT NULL,
  `serie` varchar(4) NOT NULL,
  `correlativo` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serie`
--

LOCK TABLES `serie` WRITE;
/*!40000 ALTER TABLE `serie` DISABLE KEYS */;
INSERT INTO `serie` (`id`, `id_tipo_comprobante`, `serie`, `correlativo`, `estado`) VALUES (1,'01 ','B001',16,1),(2,'01 ','F001',4,1),(3,'03','B002',21,1),(4,'03 ','B003',15,1),(6,'01 ','FL01',15,1),(8,'03','B004',4,1),(9,'RC','RC',0,1),(10,'XX ','RA',12,1),(11,'03','B006',888,1),(12,'01','FA',36,1),(13,'07 ','FN01',0,1),(14,'07 ','BN01',0,1);
/*!40000 ALTER TABLE `serie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_afectacion_igv`
--

DROP TABLE IF EXISTS `tipo_afectacion_igv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_afectacion_igv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` char(3) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `letra_tributo` varchar(45) DEFAULT NULL,
  `codigo_tributo` varchar(45) DEFAULT NULL,
  `nombre_tributo` varchar(45) DEFAULT NULL,
  `tipo_tributo` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_afectacion_igv`
--

LOCK TABLES `tipo_afectacion_igv` WRITE;
/*!40000 ALTER TABLE `tipo_afectacion_igv` DISABLE KEYS */;
INSERT INTO `tipo_afectacion_igv` (`id`, `codigo`, `descripcion`, `letra_tributo`, `codigo_tributo`, `nombre_tributo`, `tipo_tributo`, `estado`) VALUES (1,'10','GRAVADO - OPERACIÓN ONEROSA','S','1000','IGV','VAT',1),(2,'20','EXONERADO - OPERACIÓN ONEROSA','E','9997','EXO','VAT',1),(3,'30','INAFECTO - OPERACIÓN ONEROSA','O','9998','INA','FRE',1);
/*!40000 ALTER TABLE `tipo_afectacion_igv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_comprobante`
--

DROP TABLE IF EXISTS `tipo_comprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_comprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(3) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`,`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_comprobante`
--

LOCK TABLES `tipo_comprobante` WRITE;
/*!40000 ALTER TABLE `tipo_comprobante` DISABLE KEYS */;
INSERT INTO `tipo_comprobante` (`id`, `codigo`, `descripcion`, `estado`) VALUES (1,'01','FACTURA',1),(2,'03','BOLETA',1),(3,'07','NOTA DE CRÉDITO',1),(4,'08','NOTA DE DÉBITO',1),(5,'09','GUIA DE REMISIÓN',1),(6,'RA','RESUMEN ANULACIONES',1),(7,'RC','RESUMEN COMPROBANTES',1),(8,'XX','PRUEBA',1),(9,'9','PRUEBA J',1);
/*!40000 ALTER TABLE `tipo_comprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_documento`
--

DROP TABLE IF EXISTS `tipo_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_documento`
--

LOCK TABLES `tipo_documento` WRITE;
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
INSERT INTO `tipo_documento` (`id`, `descripcion`, `estado`) VALUES (0,'DOC.TRIB.NO.DOM.SIN.RUC',1),(1,'DNI',1),(4,'CARNET DE EXTRANJERIA',1),(6,'RUC',1),(7,'PASAPORTE',1),(10,'PRUEBA 2',1),(11,'PRUEBA 3',1),(12,'CC',1),(13,'CARLITOS',1),(90,'PRUEBA 90',1),(91,'PRUEBA 91',1),(92,'PRUEBA 92',1);
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_movimiento_caja`
--

DROP TABLE IF EXISTS `tipo_movimiento_caja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_movimiento_caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_movimiento_caja`
--

LOCK TABLES `tipo_movimiento_caja` WRITE;
/*!40000 ALTER TABLE `tipo_movimiento_caja` DISABLE KEYS */;
INSERT INTO `tipo_movimiento_caja` (`id`, `descripcion`, `estado`) VALUES (1,'DEVOLUCIÓN',1),(2,'GASTO',1),(3,'INGRESO',1),(4,'APERTURA',1);
/*!40000 ALTER TABLE `tipo_movimiento_caja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_operacion`
--

DROP TABLE IF EXISTS `tipo_operacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_operacion` (
  `codigo` varchar(4) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_operacion`
--

LOCK TABLES `tipo_operacion` WRITE;
/*!40000 ALTER TABLE `tipo_operacion` DISABLE KEYS */;
INSERT INTO `tipo_operacion` (`codigo`, `descripcion`, `estado`) VALUES ('0101','Venta interna',1),('0102','Venta Interna – Anticipos',1),('0103','Venta interna - Itinerante',1),('0110','Venta Interna - Sustenta Traslado de Mercadería - Remitente',1),('0111','Venta Interna - Sustenta Traslado de Mercadería - Transportista',1),('0112','Venta Interna - Sustenta Gastos Deducibles Persona Natural',1),('0120','Venta Interna - Sujeta al IVAP',1),('0200','Exportación de Bienes ',1);
/*!40000 ALTER TABLE `tipo_operacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_precio_venta_unitario`
--

DROP TABLE IF EXISTS `tipo_precio_venta_unitario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_precio_venta_unitario` (
  `codigo` varchar(2) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_precio_venta_unitario`
--

LOCK TABLES `tipo_precio_venta_unitario` WRITE;
/*!40000 ALTER TABLE `tipo_precio_venta_unitario` DISABLE KEYS */;
INSERT INTO `tipo_precio_venta_unitario` (`codigo`, `descripcion`, `estado`) VALUES ('01','Precio unitario (incluye el IGV)',1),('02','Valor referencial unitario en operaciones no onerosas',1);
/*!40000 ALTER TABLE `tipo_precio_venta_unitario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) DEFAULT NULL,
  `apellido_usuario` varchar(100) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `clave` text DEFAULT NULL,
  `id_perfil_usuario` int(11) DEFAULT NULL,
  `id_caja` int(11) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_perfil_usuario` (`id_perfil_usuario`),
  KEY `fk_id_caja_idx` (`id_caja`),
  CONSTRAINT `fk_id_caja` FOREIGN KEY (`id_caja`) REFERENCES `cajas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_perfil_usuario`) REFERENCES `perfiles` (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido_usuario`, `usuario`, `clave`, `id_perfil_usuario`, `id_caja`, `estado`) VALUES (1,'TUTORIALES','PHPERU','tperu','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',4,2,0),(2,'PAOLO','GUERRERO','pguerrero','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',2,1,1),(3,'FIORELLA JESSICA','OSORES VALLEJO','fosoresv29','123456',2,2,1),(4,'RAFAEL','LOZANO','rlozano','123456',2,1,1),(5,'ANDY','POLO','apolo','asdsad',2,2,1),(6,'ALEX','VALERA','avalera123','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',1,2,1),(7,'ALDO','CORZO','acorzo123','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',1,2,1),(8,'RENATO','TAPIA','prueba4','$2a$07$azybxcags23425sdg23sdeV5s.14AcWhL0szWBmqFbPuIRMEC.9eu',2,2,1),(9,'EMILIA','LOZANO OSORES','elozano','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',1,2,1),(10,'USUARIO ','DEMO','demo','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',4,1,1),(11,'EDISON','FLORES','edisonFlores','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',2,1,1),(12,'EDWIN','RUEDA','erueda','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',2,2,1),(13,'D','D','d','$2a$07$azybxcags23425sdg23sdeanQZqjaf6Birm2NvcYTNtJw24CsO5uq',2,4,1),(14,'LUIS ANGEL','LOZANO ARICA','llozano','$2a$07$azybxcags23425sdg23sdeV5s.14AcWhL0szWBmqFbPuIRMEC.9eu',8,2,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `id_usuario` int(11) DEFAULT NULL,
  `pagado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` (`id`, `id_empresa_emisora`, `id_cliente`, `id_serie`, `serie`, `correlativo`, `fecha_emision`, `hora_emision`, `fecha_vencimiento`, `id_moneda`, `forma_pago`, `tipo_operacion`, `total_operaciones_gravadas`, `total_operaciones_exoneradas`, `total_operaciones_inafectas`, `total_igv`, `importe_total`, `nombre_xml`, `xml_base64`, `xml_cdr_sunat_base64`, `codigo_error_sunat`, `mensaje_respuesta_sunat`, `hash_signature`, `estado_respuesta_sunat`, `estado_comprobante`, `id_usuario`, `pagado`) VALUES (1,10,2,1,'B001',16,'2023-11-14','11:11:13','2023-11-14','PEN','Contado',NULL,19.37,0,0,3.49,22.86,'10467291241-01 -B001-16.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5jUDdXWCtOdUhCeTF4RlJ5dE9DbGRwaFpya3c9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPm5rTEZ3aUdseCtlM1VScHVZbUhyMHFDZDA3RVU0TTB0WkgvdUJ5UWFCTHRsWENHMTZTQjRSYXFnWmFxdGFpNGYyS2MycXdBakU3dW03TkFuc3JQQ213ekNxbkZ5WmdxWEIvdG55NVV4NXVQaDUwQk15S0t0MVVSQ05GWUs4enRXeGNZNFlyY1RoQkNhV003MWxOMlU3eWdIRGFBdFdaUUlaQU8zczFQWGxBWC85dFRnZ1J4b3FqMmJhd1BhcDZHZzQ1Qjdyc1Z6NjRIZWxGakExMm9JdGdaUDdidjBPeHlSQ3Vhckp3NXV4QjhjR3llakxIWGh2eUV6NnpUaWtxbG1CL0RNV3QvMGQvSFB3U0tBaTRTT2JWKzFjUTc5RHVvR2I4VVBaeDJoUW8wcnBYU3BVeFFxQnhaQzVVVjBCV1piMHVVMklrQkd5TnJiNXhpdXB5WUswZz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ii8+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5CMDAxLTE2PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNDwvY2JjOklzc3VlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlVGltZT4xMToxMToxMzwvY2JjOklzc3VlVGltZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkR1ZURhdGU+MjAyMy0xMS0xNDwvY2JjOkR1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iVGlwbyBkZSBEb2N1bWVudG8iIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDEiIGxpc3RJRD0iMDEwMSIgbmFtZT0iVGlwbyBkZSBPcGVyYWNpb24iPjAxIDwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkIwMDEtMTY8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTaWduYXRvcnlQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjEwNDY3MjkxMjQxPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW1RVVE9SSUFMRVNQSFBFUlUgU0FDXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VVJJPiNTaWduYXR1cmVTUDwvY2JjOlVSST4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSI+MTIxMjQ1PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBZGRyZXNzVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iRXN0YWJsZWNpbWllbnRvcyBhbmV4b3MiPjAwMDA8L2NiYzpBZGRyZXNzVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW0xJTUFdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbQkFSUkFOQ09dXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQ0FMTEUgSlVBTiBGQU5JTkcgMzAyXV0+PC9jYmM6TGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiPlBFPC9jYmM6SWRlbnRpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkFjY291bnRpbmdDdXN0b21lclBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ3NTgyNTQxPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW1BFUkVaXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW1BFUkVaXV0+PC9jYmM6UmVnaXN0cmF0aW9uTmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDc1ODI1NDE8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDc1ODI1NDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtQRVJFWl1dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVOYW1lPSJVYmlnZW9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpJTkVJIi8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtdXT48L2NiYzpDaXR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvdW50cnlTdWJlbnRpdHk+PCFbQ0RBVEFbXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW11dPjwvY2JjOkRpc3RyaWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZT48IVtDREFUQVtWSUNUT1JJQV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjIuODY8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My40OTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjE5LjM3PC9jYmM6VGF4YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+My40OTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUxNTMiIHNjaGVtZUFnZW5jeUlEPSI2Ij4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT5JR1Y8L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTdWJ0b3RhbD48L2NhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MTkuMzc8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjIyLjg2PC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4yMi44NjwvY2JjOlBheWFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6TGVnYWxNb25ldGFyeVRvdGFsPjxjYWM6SW52b2ljZUxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZWRRdWFudGl0eSB1bml0Q29kZT0iTklVIiB1bml0Q29kZUxpc3RJRD0iVU4vRUNFIHJlYyAyMCIgdW5pdENvZGVMaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj4xPC9jYmM6SW52b2ljZWRRdWFudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjE5LjM3PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4yMi44NjwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlVHlwZUNvZGUgbGlzdE5hbWU9IlRpcG8gZGUgUHJlY2lvIiBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMTYiPjAxPC9jYmM6UHJpY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBbHRlcm5hdGl2ZUNvbmRpdGlvblByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U3VidG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjE5LjM3PC9jYmM6VGF4YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjQ5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBlcmNlbnQ+MTg8L2NiYzpQZXJjZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEV4ZW1wdGlvblJlYXNvbkNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iQWZlY3RhY2lvbiBkZWwgSUdWIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA3Ij4xMDwvY2JjOlRheEV4ZW1wdGlvblJlYXNvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUxNTMiIHNjaGVtZU5hbWU9IkNvZGlnbyBkZSB0cmlidXRvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT5JR1Y8L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTdWJ0b3RhbD48L2NhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6SXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRlc2NyaXB0aW9uPjwhW0NEQVRBW1BhaXNhbmEgZXh0cmEgNWtdXT48L2NiYzpEZXNjcmlwdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+PCFbQ0RBVEFbMTk1XV0+PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGUgbGlzdElEPSJVTlNQU0MiIGxpc3RBZ2VuY3lOYW1lPSJHUzEgVVMiIGxpc3ROYW1lPSJJdGVtIENsYXNzaWZpY2F0aW9uIj4xMDE5MTUwOTwvY2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MTkuMzc8L2NiYzpQcmljZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJbnZvaWNlTGluZT48L0ludm9pY2U+Cg==','','soap-env:Client.0151','El nombre del archivo ZIP es incorrecto - Detalle: xxx.xxx.xxx value=\'ticket:  error: Error de nombre archivo \"10467291241-01 -B001-16.ZIP codigo cpe: 01 no es un cpe valido\'','cP7WX+NuHBy1xFRytOCldphZrkw=',2,1,2,1),(2,10,3,3,'B002',3,'2023-11-14','03:11:52','2023-11-14','PEN','Contado',NULL,12.72,0,0,2.29,15.01,NULL,NULL,NULL,'','El Resumen diario RC-20231114-10, ha sido aceptado',NULL,1,1,2,1),(3,10,4,3,'B002',4,'2023-11-14','04:11:39','2023-11-14','PEN','Contado',NULL,6.72,0,0,1.21,7.93,NULL,NULL,NULL,'','El Resumen diario RC-20231114-9, ha sido aceptado',NULL,1,1,2,1),(4,10,5,12,'FA',35,'2023-11-14','05:11:31','2023-11-14','PEN','Contado',NULL,0.35,0,0,0.06,0.41,'10467291241-01-FA-35.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5FNk9CbDBYWTJvWGFLSyt6Y0JBRkNIdHhzNVk9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPkZsQWx5SmZxdCsvUFNSc1ozZ3ZBeDZIQUpCYWhEUnRNV2p2NjVnQ1g4a0hZcnFZUTlvNGlWYU1ISWxKUmNpQWwwRTJOR0JVOCtFb0Z4TjRjYzYvT0VvY3ZnUmFaN2x3bXFraWZyOTBmWERCWUpHWGRFdkIvNTlwMEZFSWF4QU5FS0VHamh6NHRyc1padDZ5cWErcE9HMHFtMTI2YUYrNmIrMkdXSDh6dUVTMkhWb2Z3ak9xNC9iSUJjRkRYdGN6T2U0R29sNW95bTJDdGxHWXowV0MrenhUdEpJTHpObGxxRitKUUNyckpHekRkc1UrdEJFcjlWcTdYRjZ6VVc4UE9KeGIzS2l5V1BBdDZ3dHF2d2czd2lNaENNcnc0M1crTVVTSC9nSGNLOEswUmVJRlBVY3QzU2JJMCtBbHR0ZjRlUU9VQy83R3R3SlhqVFhsdHBRTDJHdz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ii8+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5GQS0zNTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTEtMTQ8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MDU6MTE6MzE8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTEtMTQ8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMTwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZBLTM1PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQxPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjEyMTI0NTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEpVQU4gRkFOSU5HIDMwMl1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjI4NTIyMDI8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjI4NTIyMDI8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDYyODUyMjAyPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC40MTwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjA2PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4zNTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMDY8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMzU8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNDE8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNDE8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjM1PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjQxPC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMDY8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4zNTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4wNjwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVt2YWluaWxsYSBmaWVsZCAzN2ddXT48L2NiYzpEZXNjcmlwdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+PCFbQ0RBVEFbMTk1XV0+PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGUgbGlzdElEPSJVTlNQU0MiIGxpc3RBZ2VuY3lOYW1lPSJHUzEgVVMiIGxpc3ROYW1lPSJJdGVtIENsYXNzaWZpY2F0aW9uIj4xMDE5MTUwOTwvY2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4zNTwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkludm9pY2VMaW5lPjwvSW52b2ljZT4K','','soap-env:Client.0151','El nombre del archivo ZIP es incorrecto - Detalle: xxx.xxx.xxx value=\'ticket: 1700052642418 error: Validation ZIP Filename error: 10467291241-01-FA-35.ZIP\'','E6OBl0XY2oXaKK+zcBAFCHtxs5Y=',2,1,2,1),(5,10,5,12,'FA',36,'2023-11-14','05:11:58','2023-11-14','PEN','Contado',NULL,0.39,0,0,0.07,0.46,'10467291241-01-FA-36.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5oOXQ0T0VtVzBuREQ3L2FUck1qQTRUZGZFVFE9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPnBzRDMvTUlRQVVqQUduSHU1bHppQVQvWTJ4cFp1OHBKdUczeUZUS1cxT0ZLSU1BNXFENHZxWktwZ2o2Q21BRytnVjNoWXJGTXh1alRja09RajBUbllEaGl2YW1jeTN5V2VGcDVTeENRSW84bklFQU5PWmFSeTF5MEV0WkRkaVM4WEREZUhvVGx2RmhPRTJMZTJSYzltRWwxRWRxMGNwdWNuTnR3Y2E4MmlmUmVFamF3TFdpRVEyY2FxN1kwOXdQSEFScUtPRUVZdXRHZTRWUUFlTXNXbmg3czdaOWRGaHI2MC9lZWFIY1BxR3dhK3M1NDdUVE05ODhvUUNEblRzYXZEcytSZXp1STRyQ3RHMy9pbXJFZ3dXSWZEVjhWdW8xQlZ2cmRxY0d0NXNiQUZaVUg0WStPQWdSS0JsRzJmVDhtMmVtWHhtQU8rYVBXMFBqMlUwMFpnUT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ii8+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD5GQS0zNjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTEtMTQ8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MDU6MTE6NTg8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTEtMTQ8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMTwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZBLTM2PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQxPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjEyMTI0NTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEpVQU4gRkFOSU5HIDMwMl1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjI4NTIyMDI8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjI4NTIyMDI8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDYyODUyMjAyPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC40NjwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjA3PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4zOTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMDc8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMzk8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNDY8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuNDY8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjM5PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjQ2PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMDc8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4zOTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4wNzwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVtzb2RhIGZpZWxkIDM0Z11dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjM5PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=','','soap-env:Client.0151','El nombre del archivo ZIP es incorrecto - Detalle: xxx.xxx.xxx value=\'ticket: 1700052630804 error: Validation ZIP Filename error: 10467291241-01-FA-36.ZIP\'','h9t4OEmW0nDD7/aTrMjA4TdfETQ=',2,1,2,1),(6,10,3,3,'B002',5,'2023-11-14','06:11:31','2023-11-14','PEN','Contado',NULL,1.59,0,0,0.29,1.88,NULL,NULL,NULL,'','El Resumen diario RC-20231114-8, ha sido aceptado',NULL,1,1,2,1),(7,10,3,3,'B002',6,'2023-11-14','06:11:09','2023-11-14','PEN','Contado',NULL,1.59,0,0,0.29,1.88,'10467291241-03-B002-6.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT43dTBwK1lkRG5ySmxUd29VZ1o2Y1NVVWY3dGc9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPjNZcjFiRGxkRFBrM29IYXY2UW1oQTRIc3lXdHFwTitFaVhvUEFQSUI0ZFN6dmhPQ05oNW1NVzc0SmJ0Yjh3V2FkMjN1QVc1SHI3UWFCZTZEdjNDSkpKWWUySDdMTXV2VTY0aEIrK2FDNEFKbGg0a3psOGlCcXNaamczSFV6MzZPZmNsSkdhRHlmaVNmRzB0RmJ6NEh1dnVCN1UvcDBBeE5HVGFDMi9adE1tRHZ5TitPUTJpSnhNTTYvVlJZWjZzQjVaSGkyUHYxZ05mWHFocll3NXVvY003ZU9vOEFjZURvMHBDMFg5Q3JBM2QzUUtlcm50NzJEbnFyNFRVamtzOE0rS2V5TzJlNXhJWCsxcVZKNUJYZGFKc1NIVUdkek1aYXp6cmJERS9yTmg4a3Z5ZkZDT1BqU0hxUk9SSGFGN1RKQk05M2c5RUh5bW54bk4wTmthOU9MUT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMi02PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNDwvY2JjOklzc3VlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlVGltZT4wNjoxMTowOTwvY2JjOklzc3VlVGltZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkR1ZURhdGU+MjAyMy0xMS0xNDwvY2JjOkR1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iVGlwbyBkZSBEb2N1bWVudG8iIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDEiIGxpc3RJRD0iMDEwMSIgbmFtZT0iVGlwbyBkZSBPcGVyYWNpb24iPjAzPC9jYmM6SW52b2ljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGUgbGlzdElEPSJJU08gNDIxNyBBbHBoYSIgbGlzdE5hbWU9IkN1cnJlbmN5IiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5QRU48L2NiYzpEb2N1bWVudEN1cnJlbmN5Q29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVDb3VudE51bWVyaWM+MTwvY2JjOkxpbmVDb3VudE51bWVyaWM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMi02PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQxPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjEyMTI0NTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEpVQU4gRkFOSU5HIDMwMl1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij45OTk5OTk5OTwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS44ODwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjI5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS41OTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMjk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuNTk8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuODg8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuODg8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjU5PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjg4PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMjk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS41OTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4yOTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVtQZXBzaSAzNTVtbF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjU5PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPjAyZy9OcjVGK0ZHUDk0L0lmV2J5TGZMNEc0eG5MaHlVb3lPV0tMR01nZjFLZTZpeGI2cE9mdCtWelk5bGhqZENIeWhYVlFjN3dxUlRuUmRMRXBxdEFRPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNzAwMDA0MjU5OTI3PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNFQwNjoxMTowOTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTExLTE0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjE4OjI0OjE5PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYmM6Tm90ZT40MDkzIC0gRWwgY29kaWdvIGRlIHViaWdlbyBkZWwgZG9taWNpbGlvIGZpc2NhbCBkZWwgZW1pc29yIG5vIGVzIHYmIzIyNTtsaWRvIC0gOiA0MDkzOiBWYWxvciBubyBzZSBlbmN1ZW50cmEgZW4gZWwgY2F0YWxvZ286IDEzIChub2RvOiAiY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3MvY2JjOklEIiB2YWxvcjogIjEyMTI0NSIpPC9jYmM6Tm90ZT48Y2FjOlNlbmRlclBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjIwMTMxMzEyOTU1PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpTZW5kZXJQYXJ0eT48Y2FjOlJlY2VpdmVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MTA0NjcyOTEyNDE8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2VpdmVyUGFydHk+PGNhYzpEb2N1bWVudFJlc3BvbnNlPjxjYWM6UmVzcG9uc2U+PGNiYzpSZWZlcmVuY2VJRD5CMDAyLTY8L2NiYzpSZWZlcmVuY2VJRD48Y2JjOlJlc3BvbnNlQ29kZT4wPC9jYmM6UmVzcG9uc2VDb2RlPjxjYmM6RGVzY3JpcHRpb24+TGEgQm9sZXRhIG51bWVybyBCMDAyLTYsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMi02PC9jYmM6SUQ+PC9jYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNhYzpSZWNpcGllbnRQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD42LTk5OTk5OTk5PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpSZWNpcGllbnRQYXJ0eT48L2NhYzpEb2N1bWVudFJlc3BvbnNlPjwvYXI6QXBwbGljYXRpb25SZXNwb25zZT4=','','La Boleta numero B002-6, ha sido aceptada','7u0p+YdDnrJlTwoUgZ6cSUUf7tg=',1,1,2,1),(8,10,3,3,'B002',7,'2023-11-14','06:11:31','2023-11-14','PEN','Contado',NULL,3.44,0,0,0.62,4.06,NULL,NULL,NULL,'','El Resumen diario RC-20231114-7, ha sido aceptado',NULL,1,1,2,1),(9,10,3,3,'B002',8,'2023-11-14','06:11:50','2023-11-14','PEN','Contado',NULL,1.06,0,0,0.19,1.25,'10467291241-03-B002-8.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5qNzNKZHYrd0d5VVd3bEFoU0lSUTRzRUxrek09PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPlVyV090dkdTVThJNWczdVdML01qZjJsUERaMU9Ob3h2M3NiS0gxbndHYXpIWU1lMEtHMjR1YlArNkZpQnhLemFyWStnenVGd0ZSNGI4WnpqZVovS1VBZGVFVFpTamdsRUdXazY5RjJDUFh3aCtIaHhvaG8rNnlLMW5TQU8yRXU1ZzdHMjAzUjlzN0dkcVZXSXAzS0JVMWt1MVRUaGZPajhUQnFSQ0s1Z2VIRzNoQ3E0cng0ckE3eE5oK0xWTTZkTkZTWVA0eW10Ulo2SWlzaVk5aWpzUTBvazNScGtyM0JEK1ZKREtJb0puMWQwTXpvWVpIeEwvbFVFQitTcTdXMHNmWnhvaXhnMU1vNXNyVmN3S2hBM3RTYmhaR0VYalRDZTVoTG10SmxjYnRyRUJzZHpRTDV1cWRnT3FXbzd3M3FlcG5OcDN4Y21INjlrRk1lNExxY1QwUT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMi04PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNDwvY2JjOklzc3VlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlVGltZT4wNjoxMTo1MDwvY2JjOklzc3VlVGltZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkR1ZURhdGU+MjAyMy0xMS0xNDwvY2JjOkR1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iVGlwbyBkZSBEb2N1bWVudG8iIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDEiIGxpc3RJRD0iMDEwMSIgbmFtZT0iVGlwbyBkZSBPcGVyYWNpb24iPjAzPC9jYmM6SW52b2ljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGUgbGlzdElEPSJJU08gNDIxNyBBbHBoYSIgbGlzdE5hbWU9IkN1cnJlbmN5IiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5QRU48L2NiYzpEb2N1bWVudEN1cnJlbmN5Q29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVDb3VudE51bWVyaWM+MTwvY2JjOkxpbmVDb3VudE51bWVyaWM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMi04PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQxPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjEyMTI0NTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEpVQU4gRkFOSU5HIDMwMl1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbQ0xJRU5URVMgVkFSSU9TXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0NMSUVOVEVTIFZBUklPU11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvbXBhbnlJRCBzY2hlbWVJRD0iMCIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij45OTk5OTk5OTwvY2JjOkNvbXBhbnlJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjAiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+OTk5OTk5OTk8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtDTElFTlRFUyBWQVJJT1NdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4yNTwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjE5PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4wNjwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMTk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMDY8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMjU8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMjU8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjA2PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjI1PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMTk8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4wNjwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4xOTwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVtCaWcgY29sYSA0MDBtbF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjA2PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SW52b2ljZUxpbmU+PC9JbnZvaWNlPgo=','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPjJqckhOZUlBd1cyb1ZyeFJPSFNzZXNHazVFTnJyNE9xZ2orK2V0dk5wY1lOQWFJU3E4b2NtUmM2NGZldXR4VEJ0WHFVN2lua0ZqdjRJS1hhcDhKRy93PT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNzAwMDA1ODYxMTI3PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNFQwNjoxMTo1MDwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTExLTE0PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjE4OjUxOjAxPC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYmM6Tm90ZT40MDkzIC0gRWwgY29kaWdvIGRlIHViaWdlbyBkZWwgZG9taWNpbGlvIGZpc2NhbCBkZWwgZW1pc29yIG5vIGVzIHYmIzIyNTtsaWRvIC0gOiA0MDkzOiBWYWxvciBubyBzZSBlbmN1ZW50cmEgZW4gZWwgY2F0YWxvZ286IDEzIChub2RvOiAiY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3MvY2JjOklEIiB2YWxvcjogIjEyMTI0NSIpPC9jYmM6Tm90ZT48Y2FjOlNlbmRlclBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjIwMTMxMzEyOTU1PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpTZW5kZXJQYXJ0eT48Y2FjOlJlY2VpdmVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MTA0NjcyOTEyNDE8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2VpdmVyUGFydHk+PGNhYzpEb2N1bWVudFJlc3BvbnNlPjxjYWM6UmVzcG9uc2U+PGNiYzpSZWZlcmVuY2VJRD5CMDAyLTg8L2NiYzpSZWZlcmVuY2VJRD48Y2JjOlJlc3BvbnNlQ29kZT4wPC9jYmM6UmVzcG9uc2VDb2RlPjxjYmM6RGVzY3JpcHRpb24+TGEgQm9sZXRhIG51bWVybyBCMDAyLTgsIGhhIHNpZG8gYWNlcHRhZGE8L2NiYzpEZXNjcmlwdGlvbj48L2NhYzpSZXNwb25zZT48Y2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYmM6SUQ+QjAwMi04PC9jYmM6SUQ+PC9jYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNhYzpSZWNpcGllbnRQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD42LTk5OTk5OTk5PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpSZWNpcGllbnRQYXJ0eT48L2NhYzpEb2N1bWVudFJlc3BvbnNlPjwvYXI6QXBwbGljYXRpb25SZXNwb25zZT4=','','La Boleta numero B002-8, ha sido aceptada','j73Jdv+wGyUWwlAhSIRQ4sELkzM=',1,1,2,1),(10,10,3,3,'B002',9,'2023-11-14','06:11:08','2023-11-14','PEN','Contado',NULL,36.72,0,0,6.61,43.33,NULL,NULL,NULL,'','El Resumen diario RC-20231114-11, ha sido aceptado',NULL,1,1,2,1),(11,10,3,3,'B002',10,'2023-11-14','07:11:38','2023-11-14','PEN','Contado',NULL,36.72,0,0,6.61,43.33,NULL,NULL,NULL,'','El Resumen diario RC-20231114-13, ha sido aceptado',NULL,1,2,2,1),(12,10,3,3,'B002',11,'2023-11-14','07:11:05','2023-11-14','PEN','Contado',NULL,7.71,0,0,1.39,9.1,NULL,NULL,NULL,'','El Resumen diario RC-20231114-14, ha sido aceptado',NULL,1,2,2,1),(13,10,6,3,'B002',12,'2023-11-15','12:11:35','2023-11-15','PEN','Credito',NULL,14.85,0,0,2.67,17.52,'10467291241-03-B002-12.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT45cUpnZ2NZUks3SG84dXNBMXhvR0hySGREU2s9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPlFDUlp4cnBCV1JiQ2tjYmRqUnFxS0hlczBOVEpVQVlHWnlJTnNyVEcwTnBpelVERHZuZFNjYmxsZ2NSMTRPZU5xZkpvM2w2NGxHRGhUL1pGYTlsZmZRbDFvSnJRQUtKdHgzTVRqdWx5ZjJMUEdqOUhTQktsZkdqdS84N1l0M09LTDF2UWl6ak5DQ3ZzcEI5STJyNGNUbGozZ1k4THVHN1dEcGdaOVdxMHB1WSs5di95ZmZlZWdMcnVCUjBFTHlBU1JLdHZIYzhaM1A1UVhyUjB3a055cHdFL08wQzlIc3ZodWFIeWw3TnFjY2tneGRFMUN3S2orcVVUOEEzU0N6bFcxV3RLL3F5Y3FZa2EremZrNlJPZWYyam1JcmpGekZCMXRpQmhXM0hQb25kRmZqV3RGY0p5a2FURUwrbjF5Mm8xalh4V3pvWGloQmNTaXNnK2tDWTlCdz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMi0xMjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTEtMTU8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MTI6MTE6MzU8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTEtMTU8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMzwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkIwMDItMTI8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTaWduYXRvcnlQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjEwNDY3MjkxMjQxPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW1RVVE9SSUFMRVNQSFBFUlUgU0FDXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VVJJPiNTaWduYXR1cmVTUDwvY2JjOlVSST4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSI+MTIxMjQ1PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBZGRyZXNzVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iRXN0YWJsZWNpbWllbnRvcyBhbmV4b3MiPjAwMDA8L2NiYzpBZGRyZXNzVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW0xJTUFdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbQkFSUkFOQ09dXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQ0FMTEUgSlVBTiBGQU5JTkcgMzAyXV0+PC9jYmM6TGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiPlBFPC9jYmM6SWRlbnRpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkFjY291bnRpbmdDdXN0b21lclBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIxIiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij43NTgyMjU0NTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtBTlRIT05ZIEJBUlRPTE9NRSBIRVJSRVJBIENIVVJBXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW0FOVEhPTlkgQkFSVE9MT01FIEhFUlJFUkEgQ0hVUkFdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjEiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+NzU4MjI1NDU8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIxIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjc1ODIyNTQ1PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbQU5USE9OWSBCQVJUT0xPTUUgSEVSUkVSQSBDSFVSQV1dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVOYW1lPSJVYmlnZW9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpJTkVJIi8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtdXT48L2NiYzpDaXR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvdW50cnlTdWJlbnRpdHk+PCFbQ0RBVEFbXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW11dPjwvY2JjOkRpc3RyaWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZT48IVtDREFUQVt0YWNuYV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q3JlZGl0bzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MTcuNTI8L2NiYzpBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGF5bWVudFRlcm1zPgogICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Mi42NzwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjE0Ljg1PC9jYmM6VGF4YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Mi42NzwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUxNTMiIHNjaGVtZUFnZW5jeUlEPSI2Ij4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT5JR1Y8L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTdWJ0b3RhbD48L2NhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MTQuODU8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjE3LjUyPC9jYmM6VGF4SW5jbHVzaXZlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheWFibGVBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xNy41MjwvY2JjOlBheWFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6TGVnYWxNb25ldGFyeVRvdGFsPjxjYWM6SW52b2ljZUxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZWRRdWFudGl0eSB1bml0Q29kZT0iTklVIiB1bml0Q29kZUxpc3RJRD0iVU4vRUNFIHJlYyAyMCIgdW5pdENvZGVMaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj41PC9jYmM6SW52b2ljZWRRdWFudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjE0Ljg1PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjUwPC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjIuNjc8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MTQuODU8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjIuNjc8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbUHJpbmdsZXMgcGFwYXNdXT48L2NiYzpEZXNjcmlwdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+PCFbQ0RBVEFbMTk1XV0+PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGUgbGlzdElEPSJVTlNQU0MiIGxpc3RBZ2VuY3lOYW1lPSJHUzEgVVMiIGxpc3ROYW1lPSJJdGVtIENsYXNzaWZpY2F0aW9uIj4xMDE5MTUwOTwvY2JjOkl0ZW1DbGFzc2lmaWNhdGlvbkNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlByaWNlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+Mi45NzwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkludm9pY2VMaW5lPjwvSW52b2ljZT4K','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPmxPQmZrOEV4UU1LcTZLdU4rRXFCY1I2UmZUTXBVdERQN1ZYcmk2WGRnNVIrNlNpcDg5Zk1wWG1RZlNxWXNVZTVmREYzTkRlNHJWTFlKL1ErV1R2T0pBPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNzAwMDI1MTA1NzE2PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNVQxMjoxMTozNTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTExLTE1PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjAwOjExOjQ1PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYmM6Tm90ZT40MDkzIC0gRWwgY29kaWdvIGRlIHViaWdlbyBkZWwgZG9taWNpbGlvIGZpc2NhbCBkZWwgZW1pc29yIG5vIGVzIHYmIzIyNTtsaWRvIC0gOiA0MDkzOiBWYWxvciBubyBzZSBlbmN1ZW50cmEgZW4gZWwgY2F0YWxvZ286IDEzIChub2RvOiAiY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3MvY2JjOklEIiB2YWxvcjogIjEyMTI0NSIpPC9jYmM6Tm90ZT48Y2FjOlNlbmRlclBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjIwMTMxMzEyOTU1PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpTZW5kZXJQYXJ0eT48Y2FjOlJlY2VpdmVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MTA0NjcyOTEyNDE8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2VpdmVyUGFydHk+PGNhYzpEb2N1bWVudFJlc3BvbnNlPjxjYWM6UmVzcG9uc2U+PGNiYzpSZWZlcmVuY2VJRD5CMDAyLTEyPC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMi0xMiwgaGEgc2lkbyBhY2VwdGFkYTwvY2JjOkRlc2NyaXB0aW9uPjwvY2FjOlJlc3BvbnNlPjxjYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNiYzpJRD5CMDAyLTEyPC9jYmM6SUQ+PC9jYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNhYzpSZWNpcGllbnRQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD42LTc1ODIyNTQ1PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpSZWNpcGllbnRQYXJ0eT48L2NhYzpEb2N1bWVudFJlc3BvbnNlPjwvYXI6QXBwbGljYXRpb25SZXNwb25zZT4=','','El Resumen diario RC-20231115-1, ha sido aceptado','9qJggcYRK7Ho8usA1xoGHrHdDSk=',1,2,2,0),(14,10,7,3,'B002',13,'2023-11-15','02:11:25','2023-11-15','PEN','Contado',NULL,20.76,0,0,3.74,24.5,'10467291241-03-B002-13.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5PT0F4d2YyT1BocDhjcDNLc0NtWmcyZm1wY289PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPmV2WUVZOUFqZUdGUlVlWU04T3NjSHlQYnNvaTMzOWxBY1V2c0tTSHNiRm96K1NHSDIwSUREU0NURHpwT3p2dXZoRWNIN2JvTEFQVVdJV1M4NnR0UXA0bCtsMW5hVzR0T24xRitqa0hCRGVERndiWGZ2SnJmc1dOVi9rU3RtcXV4aDdNY0duSjJCdDhNbEZWaUI5QlBsVzEwTW9HdEhEVndNWXdSQ2xTSit5a0xFZEc3UWxhOWZFVWdOaXB4WTdjeFlTdkh3Zjh2dWtkbXkxNUg0djJ1clNWK2pGTUI4b2FiVTNXazRzbFA4aTJzL3cyMzAxTDlHU1Y5S2wzNk9zem5PcUkzaThWTzBTSGZPOFJjeUlMTlVtaS9NaDBmL3ZOcnpwTzNONlNtbkxOa2RLV1h5M2RXVEZEYjd2SnpadW04b1V5VGl0K0RUQzUrNUFCNkY4SzNuUT09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+QjAwMi0xMzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SXNzdWVEYXRlPjIwMjMtMTEtMTU8L2NiYzpJc3N1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZVRpbWU+MDI6MTE6MjU8L2NiYzpJc3N1ZVRpbWU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpEdWVEYXRlPjIwMjMtMTEtMTU8L2NiYzpEdWVEYXRlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SW52b2ljZVR5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IlRpcG8gZGUgRG9jdW1lbnRvIiBsaXN0VVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzAxIiBsaXN0SUQ9IjAxMDEiIG5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIj4wMzwvY2JjOkludm9pY2VUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkRvY3VtZW50Q3VycmVuY3lDb2RlIGxpc3RJRD0iSVNPIDQyMTcgQWxwaGEiIGxpc3ROYW1lPSJDdXJyZW5jeSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UEVOPC9jYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lQ291bnROdW1lcmljPjE8L2NiYzpMaW5lQ291bnROdW1lcmljPgogICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkIwMDItMTM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTaWduYXRvcnlQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjEwNDY3MjkxMjQxPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW1RVVE9SSUFMRVNQSFBFUlUgU0FDXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VVJJPiNTaWduYXR1cmVTUDwvY2JjOlVSST4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkV4dGVybmFsUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iU1VOQVQ6SWRlbnRpZmljYWRvciBkZSBEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UmVnaXN0cmF0aW9uTmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSI+MTIxMjQ1PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBZGRyZXNzVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iRXN0YWJsZWNpbWllbnRvcyBhbmV4b3MiPjAwMDA8L2NiYzpBZGRyZXNzVHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW0xJTUFdXT48L2NiYzpDb3VudHJ5U3ViZW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGlzdHJpY3Q+PCFbQ0RBVEFbQkFSUkFOQ09dXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbQ0FMTEUgSlVBTiBGQU5JTkcgMzAyXV0+PC9jYmM6TGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SWRlbnRpZmljYXRpb25Db2RlIGxpc3RJRD0iSVNPIDMxNjYtMSIgbGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSIgbGlzdE5hbWU9IkNvdW50cnkiPlBFPC9jYmM6SWRlbnRpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkNvbnRhY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPjwhW0NEQVRBW11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nU3VwcGxpZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOkFjY291bnRpbmdDdXN0b21lclBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIxIiBzY2hlbWVOYW1lPSJEb2N1bWVudG8gZGUgSWRlbnRpZGFkIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzA2Ij42MDg3MzYxNDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtSb25hbGRvIFNvbGlzXV0+PC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpSZWdpc3RyYXRpb25OYW1lPjwhW0NEQVRBW1JvbmFsZG8gU29saXNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjEiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+NjA4NzM2MTQ8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSIxIiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjYwODczNjE0PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUm9uYWxkbyBTb2xpc11dPjwvY2JjOlJlZ2lzdHJhdGlvbk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVOYW1lPSJVYmlnZW9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpJTkVJIi8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDaXR5TmFtZT48IVtDREFUQVtdXT48L2NiYzpDaXR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkNvdW50cnlTdWJlbnRpdHk+PCFbQ0RBVEFbXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW11dPjwvY2JjOkRpc3RyaWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZT48IVtDREFUQVt5aGpnal1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q29udGFkbzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjQuNTwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjc0PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjAuNzY8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4zLjc0PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTMwNSIgc2NoZW1lTmFtZT0iVGF4IENhdGVnb3J5IElkZW50aWZpZXIiIHNjaGVtZUFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+UzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lQWdlbmN5SUQ9IjYiPjEwMDA8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgIDxjYWM6TGVnYWxNb25ldGFyeVRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4yMC43NjwvY2JjOkxpbmVFeHRlbnNpb25BbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4SW5jbHVzaXZlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjQuNTA8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjI0LjUwPC9jYmM6UGF5YWJsZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpMZWdhbE1vbmV0YXJ5VG90YWw+PGNhYzpJbnZvaWNlTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlZFF1YW50aXR5IHVuaXRDb2RlPSJOSVUiIHVuaXRDb2RlTGlzdElEPSJVTi9FQ0UgcmVjIDIwIiB1bml0Q29kZUxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPjI8L2NiYzpJbnZvaWNlZFF1YW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lRXh0ZW5zaW9uQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjAuNzY8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6QWx0ZXJuYXRpdmVDb25kaXRpb25QcmljZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQcmljZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEyLjI1PC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNzQ8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MjAuNzY8L2NiYzpUYXhhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjMuNzQ8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGVyY2VudD4xODwvY2JjOlBlcmNlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZSBsaXN0QWdlbmN5TmFtZT0iUEU6U1VOQVQiIGxpc3ROYW1lPSJBZmVjdGFjaW9uIGRlbCBJR1YiIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDciPjEwPC9jYmM6VGF4RXhlbXB0aW9uUmVhc29uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSJVTi9FQ0UgNTE1MyIgc2NoZW1lTmFtZT0iQ29kaWdvIGRlIHRyaWJ1dG9zIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpOYW1lPklHVjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheFR5cGVDb2RlPlZBVDwvY2JjOlRheFR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFN1YnRvdGFsPjwvY2FjOlRheFRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpJdGVtPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6RGVzY3JpcHRpb24+PCFbQ0RBVEFbRGVsZWl0ZSAxTF1dPjwvY2JjOkRlc2NyaXB0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2VsbGVyc0l0ZW1JZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD48IVtDREFUQVsxOTVdXT48L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q29tbW9kaXR5Q2xhc3NpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZSBsaXN0SUQ9IlVOU1BTQyIgbGlzdEFnZW5jeU5hbWU9IkdTMSBVUyIgbGlzdE5hbWU9Ikl0ZW0gQ2xhc3NpZmljYXRpb24iPjEwMTkxNTA5PC9jYmM6SXRlbUNsYXNzaWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xMC4zODwvY2JjOlByaWNlQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkludm9pY2VMaW5lPjwvSW52b2ljZT4K','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPk8veE8zdHpLdzZHSzRBWEZYZytYdzFuOVVJK1JZNk81Y0Q4ZEhqTWhUQ0RkV1IzWEtzcXJ6UkUzNWk3cjVkNW1aODlrN3ZJdHA3bDVhdzIxRTRvcHl3PT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNzAwMDMxMzM1Nzk2PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNVQwMjoxMToyNTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTExLTE1PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjAxOjU1OjM1PC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYmM6Tm90ZT40MDkzIC0gRWwgY29kaWdvIGRlIHViaWdlbyBkZWwgZG9taWNpbGlvIGZpc2NhbCBkZWwgZW1pc29yIG5vIGVzIHYmIzIyNTtsaWRvIC0gOiA0MDkzOiBWYWxvciBubyBzZSBlbmN1ZW50cmEgZW4gZWwgY2F0YWxvZ286IDEzIChub2RvOiAiY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3MvY2JjOklEIiB2YWxvcjogIjEyMTI0NSIpPC9jYmM6Tm90ZT48Y2FjOlNlbmRlclBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjIwMTMxMzEyOTU1PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpTZW5kZXJQYXJ0eT48Y2FjOlJlY2VpdmVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MTA0NjcyOTEyNDE8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2VpdmVyUGFydHk+PGNhYzpEb2N1bWVudFJlc3BvbnNlPjxjYWM6UmVzcG9uc2U+PGNiYzpSZWZlcmVuY2VJRD5CMDAyLTEzPC9jYmM6UmVmZXJlbmNlSUQ+PGNiYzpSZXNwb25zZUNvZGU+MDwvY2JjOlJlc3BvbnNlQ29kZT48Y2JjOkRlc2NyaXB0aW9uPkxhIEJvbGV0YSBudW1lcm8gQjAwMi0xMywgaGEgc2lkbyBhY2VwdGFkYTwvY2JjOkRlc2NyaXB0aW9uPjwvY2FjOlJlc3BvbnNlPjxjYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNiYzpJRD5CMDAyLTEzPC9jYmM6SUQ+PC9jYWM6RG9jdW1lbnRSZWZlcmVuY2U+PGNhYzpSZWNpcGllbnRQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD42LTYwODczNjE0PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpSZWNpcGllbnRQYXJ0eT48L2NhYzpEb2N1bWVudFJlc3BvbnNlPjwvYXI6QXBwbGljYXRpb25SZXNwb25zZT4=','','La Boleta numero B002-13, ha sido aceptada','OOAxwf2OPhp8cp3KsCmZg2fmpco=',1,1,2,1),(15,10,5,2,'F001',4,'2023-11-15','07:11:51','2023-11-15','PEN','Credito',NULL,0.95,0,0,0.17,1.12,'10467291241-01-F001-4.XML','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPEludm9pY2UgeG1sbnM6eHNpPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYS1pbnN0YW5jZSIgeG1sbnM6eHNkPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6Y2FjPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25BZ2dyZWdhdGVDb21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNjdHM9InVybjp1bjp1bmVjZTp1bmNlZmFjdDpkb2N1bWVudGF0aW9uOjIiIHhtbG5zOmRzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczpleHQ9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkNvbW1vbkV4dGVuc2lvbkNvbXBvbmVudHMtMiIgeG1sbnM6cWR0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpRdWFsaWZpZWREYXRhdHlwZXMtMiIgeG1sbnM6dWR0PSJ1cm46dW46dW5lY2U6dW5jZWZhY3Q6ZGF0YTpzcGVjaWZpY2F0aW9uOlVucXVhbGlmaWVkRGF0YVR5cGVzU2NoZW1hTW9kdWxlOjIiIHhtbG5zPSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpJbnZvaWNlLTIiPgogICAgICAgICAgICAgICAgICAgIDxleHQ6VUJMRXh0ZW5zaW9ucz4KICAgICAgICAgICAgICAgICAgICAgICAgPGV4dDpVQkxFeHRlbnNpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PGRzOlNpZ25hdHVyZSBJZD0iU2lnbmF0dXJlU1AiPjxkczpTaWduZWRJbmZvPjxkczpDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48ZHM6U2lnbmF0dXJlTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3JzYS1zaGExIi8+PGRzOlJlZmVyZW5jZSBVUkk9IiI+PGRzOlRyYW5zZm9ybXM+PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIi8+PC9kczpUcmFuc2Zvcm1zPjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSIvPjxkczpEaWdlc3RWYWx1ZT5LNzduY211WHhOdE92Sys5dlo3dlRSMkNMb1k9PC9kczpEaWdlc3RWYWx1ZT48L2RzOlJlZmVyZW5jZT48L2RzOlNpZ25lZEluZm8+PGRzOlNpZ25hdHVyZVZhbHVlPkR6R2g3M3VVTXV0R3lnRGdJbkdkYkRlcVRpRE5saW8zVGFORUJXSVgyMEhXWmxRUkFubGRlNHVoMENVMEZYRW5KTXdDNWltWWpIWS9nVWZiYi9haUZSZ2VWZDRRT0tRaE0rbXlDelVpb1ZhdlAybjFWVGYvU1YrK1RqMGFqOHVnaUNYSFFmUC9OK05CWHQrWjkzdzd6UEFyeUR4ektFTTIyQkljQjNoMXUwWncrZks5RFVVOENRUHRWUDZ4TEZCUVREZUtMUEQ4c0wvcExVQTRPbVRFbUZWTnBVYW5JekVOeVhOcDZIWG03N08rcmVmNXJPcVpJVWloYi80bVpONm93eXBZdTU2Q2dtN2ladHl0Z1FhaHA3cHYrSGtsTCs4RmtmdGxGZVZJMUxQSUZuVjN1Nld0OXVESXpXdVBKd1lBUGZqYnVKTHhMWnJDTGh1WGE3TXlQZz09PC9kczpTaWduYXR1cmVWYWx1ZT48ZHM6S2V5SW5mbz48ZHM6WDUwOURhdGE+PGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGQ0RDQ0EvQ2dBd0lCQWdJSkFJSCtMeDBORnRVU01BMEdDU3FHU0liM0RRRUJDd1VBTUlJQkRURWJNQmtHQ2dtU0pvbVQ4aXhrQVJrV0MweE1RVTFCTGxCRklGTkJNUXN3Q1FZRFZRUUdFd0pRUlRFTk1Bc0dBMVVFQ0F3RVRFbE5RVEVOTUFzR0ExVUVCd3dFVEVsTlFURVlNQllHQTFVRUNnd1BWRlVnUlUxUVVrVlRRU0JUTGtFdU1VVXdRd1lEVlFRTEREeEVUa2tnT1RrNU9UazVPU0JTVlVNZ01qQTBPREEyTnpRME1UUWdMU0JEUlZKVVNVWkpRMEZFVHlCUVFWSkJJRVJGVFU5VFZGSkJRMG5EazA0eFJEQkNCZ05WQkFNTU8wNVBUVUpTUlNCU1JWQlNSVk5GVGxSQlRsUkZJRXhGUjBGTUlDMGdRMFZTVkVsR1NVTkJSRThnVUVGU1FTQkVSVTFQVTFSU1FVTkp3NU5PTVJ3d0dnWUpLb1pJaHZjTkFRa0JGZzFrWlcxdlFHeHNZVzFoTG5CbE1CNFhEVEl6TVRBeU1ESXhNelV3TlZvWERUSTFNVEF4T1RJeE16VXdOVm93Z2dFTk1Sc3dHUVlLQ1pJbWlaUHlMR1FCR1JZTFRFeEJUVUV1VUVVZ1UwRXhDekFKQmdOVkJBWVRBbEJGTVEwd0N3WURWUVFJREFSTVNVMUJNUTB3Q3dZRFZRUUhEQVJNU1UxQk1SZ3dGZ1lEVlFRS0RBOVVWU0JGVFZCU1JWTkJJRk11UVM0eFJUQkRCZ05WQkFzTVBFUk9TU0E1T1RrNU9UazVJRkpWUXlBeU1EUTRNRFkzTkRReE5DQXRJRU5GVWxSSlJrbERRVVJQSUZCQlVrRWdSRVZOVDFOVVVrRkRTY09UVGpGRU1FSUdBMVVFQXd3N1RrOU5RbEpGSUZKRlVGSkZVMFZPVkVGT1ZFVWdURVZIUVV3Z0xTQkRSVkpVU1VaSlEwRkVUeUJRUVZKQklFUkZUVTlUVkZKQlEwbkRrMDR4SERBYUJna3Foa2lHOXcwQkNRRVdEV1JsYlc5QWJHeGhiV0V1Y0dVd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURkb2RndUlnaWtYZFBrSk5ScUtXWVRBZkRmZmdxU3VKOE42VGNqZFZMaGNzWnBNaHVIdjdOWmVpSE45ZTg4QU1EMTNrVGNlblFOMFc2ckx4Y3VRTHpPUll0TjZOZlY4ZmlCb3VpdXA0cnUzb3AvcnlIQXd5ZEVTU2pXQnhjRWM0M1dkMWVraWYvWVAvU2hNS2RQOUNGcDJ1aEJTRVZsQ25hMTM4dysyUEVsTjJqSlQwNVBmU284QWFranZvUjNHbzhtMmpnOGNZMHRWWDBJWkZxUE9zMkkrVkxqMFZia3hleGpjNE5CdVYxMVhnZGx2bmJnMHFrSi9aOXFqblJPVlg2NmptajNldGkxWDg1TUpQWi9qejl6TUkrby81SFZSTkJRRW5kbGtCblJ4UlY5UXVKSFVHWVpjSzRrWGZXUHZqUDBrUTdpWk56c0REaG5uRXgwcnFYZEFnTUJBQUdqWnpCbE1CMEdBMVVkRGdRV0JCU3U2VXZaKy9zOU1maFhwQzB2UXpwOExRQ3orVEFmQmdOVkhTTUVHREFXZ0JTdTZVdlorL3M5TWZoWHBDMHZRenA4TFFDeitUQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBVEFPQmdOVkhROEJBZjhFQkFNQ0I0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSWhYN3pCbENKS2NVT2R4UHJ5RVJ5VGl3Y3Iyb3E0TWdpVVdmc2gxaDJYWm5uVHJUMHFtM3k5b0FMSThtMnZvc25IZUs5Q3ZuWjlZcW5LSnBlNitSMlFKcHUyOUxnWGNBQnl1YzQ3dkl2aUVHU2wzUi9EWFpNb1M0QWVPSE80aFFMMm9hcm5LVFUweGNQdzg1dDlBblR0bGVPSmwyV1RlYmNIRnlDVmhKQXlGdDZmd3pQN05heDlLYU11Nmk1eHBOOVpRK1NlNG1Ec2E4R2hWWHBzc0gwMXU1Z1o3UTNXY3NXN1pmb0N0dFlGTWVRYXp2Vk8xTkp5bnROcW1tQUZqSXN0bzgrWUwyLzJvVHg0Y3VjT1BvcUNvdXVFMjl6M0szMGVYRUpBOWhaSVpna0RwWlptSTBSNGpVc2h4bTFxeEl3dUJITEdQdnQvSFEyZlFlYVhEQUFRPTwvZHM6WDUwOUNlcnRpZmljYXRlPjwvZHM6WDUwOURhdGE+PC9kczpLZXlJbmZvPjwvZHM6U2lnbmF0dXJlPjwvZXh0OkV4dGVuc2lvbkNvbnRlbnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZXh0OlVCTEV4dGVuc2lvbj4KICAgICAgICAgICAgICAgICAgICA8L2V4dDpVQkxFeHRlbnNpb25zPgogICAgICAgICAgICAgICAgICAgIDxjYmM6VUJMVmVyc2lvbklEPjIuMTwvY2JjOlVCTFZlcnNpb25JRD4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkN1c3RvbWl6YXRpb25JRCBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCI+Mi4wPC9jYmM6Q3VzdG9taXphdGlvbklEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6UHJvZmlsZUlEIHNjaGVtZU5hbWU9IlRpcG8gZGUgT3BlcmFjaW9uIiBzY2hlbWVBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgc2NoZW1lVVJJPSJ1cm46cGU6Z29iOnN1bmF0OmNwZTpzZWU6Z2VtOmNhdGFsb2dvczpjYXRhbG9nbzE3Ij4wMTAxPC9jYmM6UHJvZmlsZUlEPgogICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+RjAwMS00PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNTwvY2JjOklzc3VlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOklzc3VlVGltZT4wNzoxMTo1MTwvY2JjOklzc3VlVGltZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkR1ZURhdGU+MjAyMy0xMS0xNTwvY2JjOkR1ZURhdGU+CiAgICAgICAgICAgICAgICAgICAgPGNiYzpJbnZvaWNlVHlwZUNvZGUgbGlzdEFnZW5jeU5hbWU9IlBFOlNVTkFUIiBsaXN0TmFtZT0iVGlwbyBkZSBEb2N1bWVudG8iIGxpc3RVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDEiIGxpc3RJRD0iMDEwMSIgbmFtZT0iVGlwbyBkZSBPcGVyYWNpb24iPjAxPC9jYmM6SW52b2ljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgIDxjYmM6RG9jdW1lbnRDdXJyZW5jeUNvZGUgbGlzdElEPSJJU08gNDIxNyBBbHBoYSIgbGlzdE5hbWU9IkN1cnJlbmN5IiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5QRU48L2NiYzpEb2N1bWVudEN1cnJlbmN5Q29kZT4KICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVDb3VudE51bWVyaWM+MTwvY2JjOkxpbmVDb3VudE51bWVyaWM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpTaWduYXR1cmU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+RjAwMS00PC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6U2lnbmF0b3J5UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xMDQ2NzI5MTI0MTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtUVVRPUklBTEVTUEhQRVJVIFNBQ11dPjwvY2JjOk5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNpZ25hdG9yeVBhcnR5PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkRpZ2l0YWxTaWduYXR1cmVBdHRhY2htZW50PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlVSST4jU2lnbmF0dXJlU1A8L2NiYzpVUkk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpFeHRlcm5hbFJlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6U2lnbmF0dXJlPgogICAgICAgICAgICAgICAgICAgIDxjYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q29tcGFueUlEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDY3MjkxMjQxPC9jYmM6Q29tcGFueUlEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjcyOTEyNDE8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eVRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlMZWdhbEVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbVFVUT1JJQUxFU1BIUEVSVSBTQUNdXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UmVnaXN0cmF0aW9uQWRkcmVzcz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZU5hbWU9IlViaWdlb3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOklORUkiPjEyMTI0NTwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QWRkcmVzc1R5cGVDb2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkVzdGFibGVjaW1pZW50b3MgYW5leG9zIj4wMDAwPC9jYmM6QWRkcmVzc1R5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbTElNQV1dPjwvY2JjOkNpdHlOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q291bnRyeVN1YmVudGl0eT48IVtDREFUQVtMSU1BXV0+PC9jYmM6Q291bnRyeVN1YmVudGl0eT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkRpc3RyaWN0PjwhW0NEQVRBW0JBUlJBTkNPXV0+PC9jYmM6RGlzdHJpY3Q+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpBZGRyZXNzTGluZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpMaW5lPjwhW0NEQVRBW0NBTExFIEpVQU4gRkFOSU5HIDMwMl1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklkZW50aWZpY2F0aW9uQ29kZSBsaXN0SUQ9IklTTyAzMTY2LTEiIGxpc3RBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiIGxpc3ROYW1lPSJDb3VudHJ5Ij5QRTwvY2JjOklkZW50aWZpY2F0aW9uQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpDb3VudHJ5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3M+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb250YWN0PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TmFtZT48IVtDREFUQVtdXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6Q29udGFjdD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHk+CiAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWNjb3VudGluZ1N1cHBsaWVyUGFydHk+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iNiIgc2NoZW1lTmFtZT0iRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjI4NTIyMDI8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpOYW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UGFydHlUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb21wYW55SUQgc2NoZW1lSUQ9IjYiIHNjaGVtZU5hbWU9IlNVTkFUOklkZW50aWZpY2Fkb3IgZGUgRG9jdW1lbnRvIGRlIElkZW50aWRhZCIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6U1VOQVQiIHNjaGVtZVVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNiI+MTA0NjI4NTIyMDI8L2NiYzpDb21wYW55SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEIHNjaGVtZUlEPSI2IiBzY2hlbWVOYW1lPSJTVU5BVDpJZGVudGlmaWNhZG9yIGRlIERvY3VtZW50byBkZSBJZGVudGlkYWQiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIiBzY2hlbWVVUkk9InVybjpwZTpnb2I6c3VuYXQ6Y3BlOnNlZTpnZW06Y2F0YWxvZ29zOmNhdGFsb2dvMDYiPjEwNDYyODUyMjAyPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlBhcnR5VGF4U2NoZW1lPgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlBhcnR5TGVnYWxFbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlJlZ2lzdHJhdGlvbk5hbWU+PCFbQ0RBVEFbUEFSSU9OQSBUQU1FIFJPRUwgR1JFR09SSU9dXT48L2NiYzpSZWdpc3RyYXRpb25OYW1lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lTmFtZT0iVWJpZ2VvcyIgc2NoZW1lQWdlbmN5TmFtZT0iUEU6SU5FSSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6Q2l0eU5hbWU+PCFbQ0RBVEFbXV0+PC9jYmM6Q2l0eU5hbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpDb3VudHJ5U3ViZW50aXR5PjwhW0NEQVRBW11dPjwvY2JjOkNvdW50cnlTdWJlbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEaXN0cmljdD48IVtDREFUQVtdXT48L2NiYzpEaXN0cmljdD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFkZHJlc3NMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmU+PCFbQ0RBVEFbLV1dPjwvY2JjOkxpbmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6QWRkcmVzc0xpbmU+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6Q291bnRyeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJZGVudGlmaWNhdGlvbkNvZGUgbGlzdElEPSJJU08gMzE2Ni0xIiBsaXN0QWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIiBsaXN0TmFtZT0iQ291bnRyeSIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvdW50cnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpSZWdpc3RyYXRpb25BZGRyZXNzPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eUxlZ2FsRW50aXR5PgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpBY2NvdW50aW5nQ3VzdG9tZXJQYXJ0eT4KICAgICAgICAgICAgICAgICAgICA8Y2FjOlBheW1lbnRUZXJtcz4KICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPkZvcm1hUGFnbzwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q3JlZGl0bzwvY2JjOlBheW1lbnRNZWFuc0lEPgogICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MS4xMjwvY2JjOkFtb3VudD4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+PGNhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQ+Rm9ybWFQYWdvPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5bWVudE1lYW5zSUQ+Q3VvdGEwMDE8L2NiYzpQYXltZW50TWVhbnNJRD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjEyPC9jYmM6QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlBheW1lbnREdWVEYXRlPjIwMjMtMTEtMjI8L2NiYzpQYXltZW50RHVlRGF0ZT4KICAgICAgICAgICAgICAgICAgICA8L2NhYzpQYXltZW50VGVybXM+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjE3PC9jYmM6VGF4QW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFN1YnRvdGFsPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC45NTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMTc8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheENhdGVnb3J5PgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MzA1IiBzY2hlbWVOYW1lPSJUYXggQ2F0ZWdvcnkgSWRlbnRpZmllciIgc2NoZW1lQWdlbmN5TmFtZT0iVW5pdGVkIE5hdGlvbnMgRWNvbm9taWMgQ29tbWlzc2lvbiBmb3IgRXVyb3BlIj5TPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVBZ2VuY3lJRD0iNiI+MTAwMDwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhUeXBlQ29kZT5WQVQ8L2NiYzpUYXhUeXBlQ29kZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhTY2hlbWU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgPGNhYzpMZWdhbE1vbmV0YXJ5VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6TGluZUV4dGVuc2lvbkFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuOTU8L2NiYzpMaW5lRXh0ZW5zaW9uQW1vdW50PgogICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEluY2x1c2l2ZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMTI8L2NiYzpUYXhJbmNsdXNpdmVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UGF5YWJsZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjEuMTI8L2NiYzpQYXlhYmxlQW1vdW50PgogICAgICAgICAgICAgICAgICAgIDwvY2FjOkxlZ2FsTW9uZXRhcnlUb3RhbD48Y2FjOkludm9pY2VMaW5lPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRD4xPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkludm9pY2VkUXVhbnRpdHkgdW5pdENvZGU9Ik5JVSIgdW5pdENvZGVMaXN0SUQ9IlVOL0VDRSByZWMgMjAiIHVuaXRDb2RlTGlzdEFnZW5jeU5hbWU9IlVuaXRlZCBOYXRpb25zIEVjb25vbWljIENvbW1pc3Npb24gZm9yIEV1cm9wZSI+MTwvY2JjOkludm9pY2VkUXVhbnRpdHk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOkxpbmVFeHRlbnNpb25BbW91bnQgY3VycmVuY3lJRD0iUEVOIj4wLjk1PC9jYmM6TGluZUV4dGVuc2lvbkFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2luZ1JlZmVyZW5jZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VBbW91bnQgY3VycmVuY3lJRD0iUEVOIj4xLjEyPC9jYmM6UHJpY2VBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6UHJpY2VUeXBlQ29kZSBsaXN0TmFtZT0iVGlwbyBkZSBQcmVjaW8iIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28xNiI+MDE8L2NiYzpQcmljZVR5cGVDb2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkFsdGVybmF0aXZlQ29uZGl0aW9uUHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpQcmljaW5nUmVmZXJlbmNlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhUb3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOlRheEFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuMTc8L2NiYzpUYXhBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhTdWJ0b3RhbD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhhYmxlQW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC45NTwvY2JjOlRheGFibGVBbW91bnQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4QW1vdW50IGN1cnJlbmN5SUQ9IlBFTiI+MC4xNzwvY2JjOlRheEFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpUYXhDYXRlZ29yeT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJRCBzY2hlbWVJRD0iVU4vRUNFIDUzMDUiIHNjaGVtZU5hbWU9IlRheCBDYXRlZ29yeSBJZGVudGlmaWVyIiBzY2hlbWVBZ2VuY3lOYW1lPSJVbml0ZWQgTmF0aW9ucyBFY29ub21pYyBDb21taXNzaW9uIGZvciBFdXJvcGUiPlM8L2NiYzpJRD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQZXJjZW50PjE4PC9jYmM6UGVyY2VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlIGxpc3RBZ2VuY3lOYW1lPSJQRTpTVU5BVCIgbGlzdE5hbWU9IkFmZWN0YWNpb24gZGVsIElHViIgbGlzdFVSST0idXJuOnBlOmdvYjpzdW5hdDpjcGU6c2VlOmdlbTpjYXRhbG9nb3M6Y2F0YWxvZ28wNyI+MTA8L2NiYzpUYXhFeGVtcHRpb25SZWFzb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6SUQgc2NoZW1lSUQ9IlVOL0VDRSA1MTUzIiBzY2hlbWVOYW1lPSJDb2RpZ28gZGUgdHJpYnV0b3MiIHNjaGVtZUFnZW5jeU5hbWU9IlBFOlNVTkFUIj4xMDAwPC9jYmM6SUQ+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOk5hbWU+SUdWPC9jYmM6TmFtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYmM6VGF4VHlwZUNvZGU+VkFUPC9jYmM6VGF4VHlwZUNvZGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlRheFNjaGVtZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4Q2F0ZWdvcnk+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6VGF4U3VidG90YWw+PC9jYWM6VGF4VG90YWw+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2FjOkl0ZW0+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpEZXNjcmlwdGlvbj48IVtDREFUQVtadWtvIFBpw7FhXV0+PC9jYmM6RGVzY3JpcHRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpTZWxsZXJzSXRlbUlkZW50aWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Y2JjOklEPjwhW0NEQVRBWzE5NV1dPjwvY2JjOklEPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlNlbGxlcnNJdGVtSWRlbnRpZmljYXRpb24+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNhYzpDb21tb2RpdHlDbGFzc2lmaWNhdGlvbj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlIGxpc3RJRD0iVU5TUFNDIiBsaXN0QWdlbmN5TmFtZT0iR1MxIFVTIiBsaXN0TmFtZT0iSXRlbSBDbGFzc2lmaWNhdGlvbiI+MTAxOTE1MDk8L2NiYzpJdGVtQ2xhc3NpZmljYXRpb25Db2RlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOkNvbW1vZGl0eUNsYXNzaWZpY2F0aW9uPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9jYWM6SXRlbT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxjYWM6UHJpY2U+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGNiYzpQcmljZUFtb3VudCBjdXJyZW5jeUlEPSJQRU4iPjAuOTU8L2NiYzpQcmljZUFtb3VudD4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvY2FjOlByaWNlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2NhYzpJbnZvaWNlTGluZT48L0ludm9pY2U+Cg==','PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGFyOkFwcGxpY2F0aW9uUmVzcG9uc2UgeG1sbnM9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkludm9pY2UtMiIgeG1sbnM6YXI9InVybjpvYXNpczpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpzY2hlbWE6eHNkOkFwcGxpY2F0aW9uUmVzcG9uc2UtMiIgeG1sbnM6ZXh0PSJ1cm46b2FzaXM6bmFtZXM6c3BlY2lmaWNhdGlvbjp1Ymw6c2NoZW1hOnhzZDpDb21tb25FeHRlbnNpb25Db21wb25lbnRzLTIiIHhtbG5zOmNiYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQmFzaWNDb21wb25lbnRzLTIiIHhtbG5zOmNhYz0idXJuOm9hc2lzOm5hbWVzOnNwZWNpZmljYXRpb246dWJsOnNjaGVtYTp4c2Q6Q29tbW9uQWdncmVnYXRlQ29tcG9uZW50cy0yIiB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6c29hcD0iaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvc29hcC9lbnZlbG9wZS8iIHhtbG5zOmRhdGU9Imh0dHA6Ly9leHNsdC5vcmcvZGF0ZXMtYW5kLXRpbWVzIiB4bWxuczpzYWM9InVybjpzdW5hdDpuYW1lczpzcGVjaWZpY2F0aW9uOnVibDpwZXJ1OnNjaGVtYTp4c2Q6U3VuYXRBZ2dyZWdhdGVDb21wb25lbnRzLTEiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6cmVnZXhwPSJodHRwOi8vZXhzbHQub3JnL3JlZ3VsYXItZXhwcmVzc2lvbnMiPjxleHQ6VUJMRXh0ZW5zaW9ucyB4bWxucz0iIj48ZXh0OlVCTEV4dGVuc2lvbj48ZXh0OkV4dGVuc2lvbkNvbnRlbnQ+PFNpZ25hdHVyZSB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyI+CjxTaWduZWRJbmZvPgogIDxDYW5vbmljYWxpemF0aW9uTWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8xMC94bWwtZXhjLWMxNG4jV2l0aENvbW1lbnRzIi8+CiAgPFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGE1MTIiLz4KICA8UmVmZXJlbmNlIFVSST0iIj4KICAgIDxUcmFuc2Zvcm1zPgogICAgICA8VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz4KICAgICAgPFRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIvPgogICAgPC9UcmFuc2Zvcm1zPgogICAgPERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTUxMiIvPgogICAgPERpZ2VzdFZhbHVlPmdacUtseEtYUlVNeEJmZ3RhNUVrTjRXUWxvbllMTGtWQW1sUVRhZlVCY1JSK2RwU1dSanhabXd2MG51R2tBVHUyZmdrUmk4ZHQ0ckhxOTlqY2dBK09nPT08L0RpZ2VzdFZhbHVlPgogIDwvUmVmZXJlbmNlPgo8L1NpZ25lZEluZm8+CiAgICA8U2lnbmF0dXJlVmFsdWU+KlByaXZhdGUga2V5ICdCZXRhUHVibGljQ2VydCcgbm90IHVwKjwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+Kk5hbWVkIGNlcnRpZmljYXRlICdCZXRhUHJpdmF0ZUtleScgbm90IHVwKjwvWDUwOUNlcnRpZmljYXRlPjxYNTA5SXNzdWVyU2VyaWFsPjxYNTA5SXNzdWVyTmFtZT4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5SXNzdWVyTmFtZT48WDUwOVNlcmlhbE51bWJlcj4qTmFtZWQgY2VydGlmaWNhdGUgJ0JldGFQcml2YXRlS2V5JyBub3QgdXAqPC9YNTA5U2VyaWFsTnVtYmVyPjwvWDUwOUlzc3VlclNlcmlhbD48L1g1MDlEYXRhPjwvS2V5SW5mbz48L1NpZ25hdHVyZT48L2V4dDpFeHRlbnNpb25Db250ZW50PjwvZXh0OlVCTEV4dGVuc2lvbj48L2V4dDpVQkxFeHRlbnNpb25zPjxjYmM6VUJMVmVyc2lvbklEPjIuMDwvY2JjOlVCTFZlcnNpb25JRD48Y2JjOkN1c3RvbWl6YXRpb25JRD4xLjA8L2NiYzpDdXN0b21pemF0aW9uSUQ+PGNiYzpJRD4xNzAwMDUxODgxNzQ0PC9jYmM6SUQ+PGNiYzpJc3N1ZURhdGU+MjAyMy0xMS0xNVQwNzoxMTo1MTwvY2JjOklzc3VlRGF0ZT48Y2JjOklzc3VlVGltZT4wMDowMDowMDwvY2JjOklzc3VlVGltZT48Y2JjOlJlc3BvbnNlRGF0ZT4yMDIzLTExLTE1PC9jYmM6UmVzcG9uc2VEYXRlPjxjYmM6UmVzcG9uc2VUaW1lPjA3OjM4OjAxPC9jYmM6UmVzcG9uc2VUaW1lPjxjYWM6U2lnbmF0dXJlPjxjYmM6SUQ+U2lnblNVTkFUPC9jYmM6SUQ+PGNhYzpTaWduYXRvcnlQYXJ0eT48Y2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNiYzpJRD4yMDEzMTMxMjk1NTwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PGNhYzpQYXJ0eU5hbWU+PGNiYzpOYW1lPlNVTkFUPC9jYmM6TmFtZT48L2NhYzpQYXJ0eU5hbWU+PC9jYWM6U2lnbmF0b3J5UGFydHk+PGNhYzpEaWdpdGFsU2lnbmF0dXJlQXR0YWNobWVudD48Y2FjOkV4dGVybmFsUmVmZXJlbmNlPjxjYmM6VVJJPiNTaWduU1VOQVQ8L2NiYzpVUkk+PC9jYWM6RXh0ZXJuYWxSZWZlcmVuY2U+PC9jYWM6RGlnaXRhbFNpZ25hdHVyZUF0dGFjaG1lbnQ+PC9jYWM6U2lnbmF0dXJlPjxjYmM6Tm90ZT40MDkzIC0gRWwgY29kaWdvIGRlIHViaWdlbyBkZWwgZG9taWNpbGlvIGZpc2NhbCBkZWwgZW1pc29yIG5vIGVzIHYmIzIyNTtsaWRvIC0gOiA0MDkzOiBWYWxvciBubyBzZSBlbmN1ZW50cmEgZW4gZWwgY2F0YWxvZ286IDEzIChub2RvOiAiY2FjOlJlZ2lzdHJhdGlvbkFkZHJlc3MvY2JjOklEIiB2YWxvcjogIjEyMTI0NSIpPC9jYmM6Tm90ZT48Y2FjOlNlbmRlclBhcnR5PjxjYWM6UGFydHlJZGVudGlmaWNhdGlvbj48Y2JjOklEPjIwMTMxMzEyOTU1PC9jYmM6SUQ+PC9jYWM6UGFydHlJZGVudGlmaWNhdGlvbj48L2NhYzpTZW5kZXJQYXJ0eT48Y2FjOlJlY2VpdmVyUGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+MTA0NjcyOTEyNDE8L2NiYzpJRD48L2NhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjwvY2FjOlJlY2VpdmVyUGFydHk+PGNhYzpEb2N1bWVudFJlc3BvbnNlPjxjYWM6UmVzcG9uc2U+PGNiYzpSZWZlcmVuY2VJRD5GMDAxLTQ8L2NiYzpSZWZlcmVuY2VJRD48Y2JjOlJlc3BvbnNlQ29kZT4wPC9jYmM6UmVzcG9uc2VDb2RlPjxjYmM6RGVzY3JpcHRpb24+TGEgRmFjdHVyYSBudW1lcm8gRjAwMS00LCBoYSBzaWRvIGFjZXB0YWRhPC9jYmM6RGVzY3JpcHRpb24+PC9jYWM6UmVzcG9uc2U+PGNhYzpEb2N1bWVudFJlZmVyZW5jZT48Y2JjOklEPkYwMDEtNDwvY2JjOklEPjwvY2FjOkRvY3VtZW50UmVmZXJlbmNlPjxjYWM6UmVjaXBpZW50UGFydHk+PGNhYzpQYXJ0eUlkZW50aWZpY2F0aW9uPjxjYmM6SUQ+Ni0xMDQ2Mjg1MjIwMjwvY2JjOklEPjwvY2FjOlBhcnR5SWRlbnRpZmljYXRpb24+PC9jYWM6UmVjaXBpZW50UGFydHk+PC9jYWM6RG9jdW1lbnRSZXNwb25zZT48L2FyOkFwcGxpY2F0aW9uUmVzcG9uc2U+','','La Factura numero F001-4, ha sido aceptada','K77ncmuXxNtOvK+9vZ7vTR2CLoY=',1,1,2,1),(16,10,8,3,'B002',14,'2023-11-15','07:11:24','2023-11-15','PEN','Contado',NULL,5.94,0,0,1.07,7.01,NULL,NULL,NULL,'','El Resumen diario RC-20231115-2, ha sido aceptado',NULL,1,2,2,1),(17,10,9,3,'B002',15,'2023-11-15','07:11:53','2023-11-15','USD','Contado',NULL,24.73,0,0,4.45,29.18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1),(18,10,10,3,'B002',16,'2023-11-15','10:11:57','2023-11-15','USD','Contado',NULL,2.91,0,0,0.52,3.43,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1),(19,10,8,3,'B002',17,'2023-11-15','11:11:19','2023-11-15','PEN','Contado',NULL,3.59,0,0,0.65,4.24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1),(20,10,8,3,'B002',18,'2023-11-15','04:11:51','2023-11-15','PEN','Contado',NULL,9.54,0,0,1.72,11.26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1),(21,10,11,3,'B002',19,'2023-11-15','06:11:57','2023-11-15','PEN','Contado',NULL,2.11,0,0,0.38,2.49,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1),(22,10,12,3,'B002',20,'2023-11-15','09:11:52','2023-11-15','USD','Contado',NULL,3.6,0,0,0.65,4.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1),(23,10,14,3,'B002',21,'2023-11-16','02:11:10','2023-11-16','PEN','Contado',NULL,27.71,0,0,4.99,32.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,1);
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tutoria3_mitiendaposfacturador'
--

--
-- Dumping routines for database 'tutoria3_mitiendaposfacturador'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ActualizarDetalleVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ActualizarDetalleVenta`(IN `p_codigo_producto` VARCHAR(20), IN `p_cantidad` FLOAT, IN `p_id` INT)
BEGIN

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ListarCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarCategorias`()
BEGIN
select * from categorias;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ListarProductos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarProductos`()
SELECT  '' as acciones,
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
	order by p.codigo_producto desc ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ListarProductosMasVendidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarProductosMasVendidos`()
    NO SQL
BEGIN

select  p.codigo_producto,
		p.descripcion,
        sum(vd.cantidad) as cantidad,
        sum(Round(vd.importe_total,2)) as total_venta
from detalle_venta vd inner join productos p on vd.codigo_producto = p.codigo_producto
group by p.codigo_producto,
		p.descripcion
order by  sum(Round(vd.importe_total,2)) DESC
limit 10;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ListarProductosPocoStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ListarProductosPocoStock`()
    NO SQL
BEGIN
select p.codigo_producto,
		p.descripcion,
        p.stock,
        p.minimo_stock
from productos p
where p.stock <= p.minimo_stock
order by p.stock asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_movimentos_arqueo_caja_por_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_movimentos_arqueo_caja_por_usuario`(`p_id_usuario` INT, `p_id_caja` INT)
BEGIN

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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ObtenerDatosDashboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ObtenerDatosDashboard`()
    NO SQL
BEGIN
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



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_obtenerNroBoleta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_obtenerNroBoleta`()
    NO SQL
select serie_boleta,
		IFNULL(LPAD(max(c.nro_correlativo_venta)+1,8,'0'),'00000001') nro_venta 
from empresa c ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ObtenerVentasMesActual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ObtenerVentasMesActual`()
    NO SQL
BEGIN
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


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_ObtenerVentasMesAnterior` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_ObtenerVentasMesAnterior`()
    NO SQL
BEGIN
SELECT date(vc.fecha_venta) as fecha_venta,
		sum(round(vc.total_venta,2)) as total_venta,
        sum(round(vc.total_venta,2)) as total_venta_ant
FROM venta_cabecera vc
where date(vc.fecha_venta) >= date(last_day(now() - INTERVAL 2 month) + INTERVAL 1 day)
and date(vc.fecha_venta) <= last_day(last_day(now() - INTERVAL 2 month) + INTERVAL 1 day)
group by date(vc.fecha_venta);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_pagar_cuotas_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_pagar_cuotas_factura`(IN `p_id_venta` INT, IN `p_monto_a_pagar` FLOAT, IN `p_id_usuario` INT)
BEGIN

	DECLARE v_id INT;
	DECLARE v_id_venta INT;
	DECLARE v_cuota varchar(3);
	DECLARE v_importe FLOAT;
    DECLARE v_importe_pagado FLOAT;
    DECLARE v_saldo_pendiente FLOAT;
	DECLARE v_cuota_pagada BOOLEAN;
    DECLARE v_fecha_vencimiento DATE;
    
    DECLARE p_monto_a_pagar_original decimal(18,2);
    
    DECLARE v_id_arqueo_caja INT;
    
    DECLARE var_final INTEGER DEFAULT 0;
    
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_mensaje varchar(500) DEFAULT '';
    
	DECLARE cursor1 CURSOR FOR 
    select id, 
			id_venta, 
            cuota, 
            importe, 
            importe_pagado, 
            saldo_pendiente, 
            cuota_pagada, 
            fecha_vencimiento
    from cuotas c
    where c.id_venta = p_id_venta
    and c.cuota_pagada = 0
    order by c.id;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
    set p_monto_a_pagar_original = p_monto_a_pagar;
    OPEN cursor1;

	  bucle: LOOP

		FETCH cursor1 
		INTO v_id,
			 v_id_venta, 
             v_cuota, 
             v_importe, 
             v_importe_pagado, 
             v_saldo_pendiente,
             v_cuota_pagada, 
             v_fecha_vencimiento;

		IF var_final = 1 THEN
		  LEAVE bucle;
		END IF;

		if(p_monto_a_pagar > 0 && (p_monto_a_pagar <= v_saldo_pendiente) ) then
			set v_mensaje = 'Monto a pagar menor al saldo pendiente de la cuota';
            update cuotas c
			  set c.importe_pagado = round(ifnull(c.importe_pagado,0) + p_monto_a_pagar,2),
					c.saldo_pendiente = round(c.importe - ifnull(c.importe_pagado,0),2),
                    c.cuota_pagada = case when c.importe = ifnull(c.importe_pagado,0) then 1 else 0 end                    
            where c.id = v_id;
            
            set p_monto_a_pagar = p_monto_a_pagar - v_saldo_pendiente;
            
            LEAVE bucle;
        end if;
        
        if(p_monto_a_pagar > 0 && (p_monto_a_pagar > v_saldo_pendiente)) then
        
			set v_mensaje = 'Monto a pagar mayor al saldo pendiente de la cuota';
        
			 update cuotas c
			  set c.importe_pagado = round(c.importe,2),
					c.saldo_pendiente = 0,
                    c.cuota_pagada = case when round(c.importe,2) = round(ifnull(c.importe_pagado,0),2) then 1 else 0 end                    
            where c.id = v_id;
            
            set p_monto_a_pagar = p_monto_a_pagar - v_saldo_pendiente;
        end if;
		 
	  END LOOP bucle;
	  CLOSE cursor1; 
      
      SET v_saldo_pendiente = 0;
      
      select sum(ifnull(saldo_pendiente,0))
      into v_saldo_pendiente
      from cuotas where id_venta = p_id_venta;
      
      if(v_saldo_pendiente = 0) then
		update venta
			set pagado = 1
        where id = p_id_venta;
      end if;
    
     -- SELECT p_monto_a_pagar as vuelto;
     
     select id
     into v_id_arqueo_caja
     from arqueo_caja
	where id_usuario = p_id_usuario
    and estado = 1;
     
     insert into movimientos_arqueo_caja(id_arqueo_caja, id_tipo_movimiento, descripcion, monto, estado)
     values(v_id_arqueo_caja, 3, 'PAGO CUOTA DE FACTURA', p_monto_a_pagar_original, 1);
     
     update arqueo_caja 
      set ingresos = ifnull(ingresos,0) + p_monto_a_pagar_original,
      	 monto_final = ifnull(monto_final,0) + p_monto_a_pagar_original
    where id_usuario = p_id_usuario
    and estado = 1;
     
     
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_kardex_anulacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_anulacion`(IN `p_id_venta` INT, IN `p_codigo_producto` VARCHAR(20))
BEGIN

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
    FROM kardex k
    WHERE k.codigo_producto = p_codigo_producto
    ORDER BY id DESC
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
                        v_concepto_devolucion,
                        v_comprobante_devolucion,
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_kardex_bono` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_bono`(IN `p_codigo_producto` VARCHAR(20), IN `p_concepto` VARCHAR(100), IN `p_nuevo_stock` FLOAT)
BEGIN

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
                        '',
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_kardex_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_compra`(IN `p_id_compra` INT, IN `p_comprobante` VARCHAR(20), IN `p_codigo_producto` VARCHAR(20), IN `p_concepto` VARCHAR(100), IN `p_cantidad_compra` FLOAT, IN `p_costo_compra` FLOAT)
BEGIN

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
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_kardex_existencias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_existencias`(IN `p_codigo_producto` VARCHAR(25), IN `p_concepto` VARCHAR(100), IN `p_comprobante` VARCHAR(100), IN `p_unidades` FLOAT, IN `p_costo_unitario` FLOAT, IN `p_costo_total` FLOAT)
BEGIN
  INSERT INTO kardex (codigo_producto, fecha, concepto, comprobante, in_unidades, in_costo_unitario, in_costo_total,ex_unidades, ex_costo_unitario, ex_costo_total)
    VALUES (p_codigo_producto, CURDATE(), p_concepto, p_comprobante, p_unidades, p_costo_unitario, p_costo_total, p_unidades, p_costo_unitario, p_costo_total);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_kardex_vencido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_vencido`(IN `p_codigo_producto` VARCHAR(20), IN `p_concepto` VARCHAR(100), IN `p_nuevo_stock` FLOAT)
BEGIN

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
	UPDATE productos 
	SET stock = v_unidades_ex, 
         costo_unitario = v_costo_unitario_ex,
        costo_total = v_costo_total_ex
	WHERE codigo_producto = p_codigo_producto ;                      

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_kardex_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_kardex_venta`(IN `p_codigo_producto` VARCHAR(20), IN `p_fecha` DATE, IN `p_concepto` VARCHAR(100), IN `p_comprobante` VARCHAR(100), IN `p_unidades` FLOAT)
BEGIN

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_registrar_venta_detalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_registrar_venta_detalle`(IN `p_nro_boleta` VARCHAR(8), IN `p_codigo_producto` VARCHAR(20), IN `p_cantidad` FLOAT, IN `p_total_venta` FLOAT)
BEGIN
declare v_precio_compra float;
declare v_precio_venta float;

SELECT p.precio_compra_producto,p.precio_venta_producto
into v_precio_compra, v_precio_venta
FROM productos p
WHERE p.codigo_producto  = p_codigo_producto;
    
INSERT INTO venta_detalle(nro_boleta,codigo_producto, cantidad, costo_unitario_venta,precio_unitario_venta,total_venta, fecha_venta) 
VALUES(p_nro_boleta,p_codigo_producto,p_cantidad, v_precio_compra, v_precio_venta,p_total_venta,curdate());
                                                        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_top_ventas_categorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_top_ventas_categorias`()
BEGIN

select cast(sum(vd.importe_total)  AS DECIMAL(8,2)) as y, c.descripcion as label
    from detalle_venta vd inner join productos p on vd.codigo_producto = p.codigo_producto
                        inner join categorias c on c.id = p.id_categoria
    group by c.descripcion
    LIMIT 10;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_total_facturas_boletas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_total_facturas_boletas`()
BEGIN

select cast(sum(v.importe_total)  AS DECIMAL(8,2)) as y, tc.descripcion as label
    from venta v inner join serie s on v.id_serie = s.id
				 inner join tipo_comprobante tc on tc.codigo = s.id_tipo_comprobante
    group by s.id_tipo_comprobante
    LIMIT 10;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_truncate_all_tables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_truncate_all_tables`()
BEGIN

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16 10:13:55
