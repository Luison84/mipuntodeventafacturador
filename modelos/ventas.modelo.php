<?php

require_once "conexion.php";
session_start();

class VentasModelo
{

    public $resultado;


    static public function mdlObtenerNroBoleta()
    {

        $stmt = Conexion::conectar()->prepare("call prc_obtenerNroBoleta()");

        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    /* =========================================================================================
    R E G I S T R A R   V E N T A
    ========================================================================================= */
    static public function mdlRegistrarVenta($venta, $detalle_venta, $id_caja)
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $date = date('Y-m-d');

        $dbh = Conexion::conectar();

        //ELIMINAR TABLAS DEL SISTEMA
        try {

            $stmt = $dbh->prepare("INSERT INTO venta(id_empresa_emisora, 
                                                    id_cliente, 
                                                    id_serie, 
                                                    serie, 
                                                    correlativo, 
                                                    fecha_emision, 
                                                    hora_emision, 
                                                    fecha_vencimiento, 
                                                    id_moneda, 
                                                    forma_pago, 
                                                    total_operaciones_gravadas, 
                                                    total_operaciones_exoneradas, 
                                                    total_operaciones_inafectas, 
                                                    total_igv, 
                                                    importe_total,
                                                    id_usuario)
            VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $venta['id_empresa_emisora'],
                $venta['id_cliente'],
                $venta['id_serie'],
                $venta['serie'],
                $venta['correlativo'],
                $venta['fecha_emision'],
                $venta['hora_emision'],
                $venta['fecha_vencimiento'],
                $venta['moneda'],
                $venta['forma_pago'],
                $venta['total_operaciones_gravadas'],
                $venta['total_operaciones_exoneradas'],
                $venta['total_operaciones_inafectas'],
                $venta['total_igv'],
                $venta['total_a_pagar'],
                $id_usuario
            ));
            $id_venta = $dbh->lastInsertId();
            $dbh->commit();

            $stmt = $dbh->prepare("UPDATE serie
                                     SET correlativo = correlativo + 1 
                                    WHERE id = ?");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $venta['id_serie']
            ));
            $dbh->commit();

            //GUARDAR EL DETALLE DE LA VENTA:
            foreach ($detalle_venta as $producto) {

                $stmt = $dbh->prepare("INSERT INTO detalle_venta(id_venta, 
                                                                item, 
                                                                codigo_producto, 
                                                                descripcion, 
                                                                porcentaje_igv, 
                                                                cantidad, 
                                                                costo_unitario,
                                                                valor_unitario, 
                                                                precio_unitario, 
                                                                valor_total, 
                                                                igv, 
                                                                importe_total)
                            VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
                $dbh->beginTransaction();
                $stmt->execute(array(
                    $id_venta,
                    $producto['item'],
                    $producto['codigo'],
                    $producto['descripcion'],
                    $producto['porcentaje_igv'],
                    $producto['cantidad'],
                    $producto['costo_unitario'],
                    $producto['valor_unitario'],
                    $producto['precio_unitario'],
                    $producto['valor_total'],
                    $producto['igv'],
                    $producto['importe_total']
                ));
                $dbh->commit();


                //*************************************************************************** */
                // R E G I S T R A M O S   E L   I N G R E S O   E N   M O V I M I E N T O S
                //*************************************************************************** */
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
                    ':id_arqueo_caja' => $id_caja,
                    ':id_tipo_movimiento' => 3,
                    ':descripcion' => 'INGRESO - ' . $venta['forma_pago'],
                    ':monto' =>  $producto['importe_total'],
                    ':estado' => 1
                ));
                $dbh->commit();

                //*************************************************************************** */
                // A C T U A L I Z A M O S   E L   I N G R E S O   A   C A J A
                //*************************************************************************** */
                if ($venta['forma_pago'] == "Contado") {

                    $stmt = $dbh->prepare("UPDATE arqueo_caja
                                            SET ingresos = format(ifnull(ingresos,0) + :importe_venta,2),
                                                monto_final = ifnull(monto_apertura,0) + ifnull(ingresos,0) - ifnull(devoluciones,0) - ifnull(gastos,0)
                                        WHERE id = :id_caja");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        ':importe_venta' => $producto['importe_total'],
                        ':id_caja' => $id_caja
                    ));
                    $dbh->commit();
                }


                //*************************************************************************** */
                //R E G I S T R A M O S   E L   K A R D E X   D E   S A L I D A S
                //*************************************************************************** */
                $concepto = 'VENTA';

                $stmt = Conexion::conectar()->prepare("call prc_registrar_kardex_venta (?,?,?,?,?)");

                $dbh->beginTransaction();
                $stmt->execute(array(
                    $producto['codigo'],
                    $date,
                    $concepto,
                    $venta['serie'] . '-' . $venta['correlativo'],
                    $producto['cantidad']

                ));
                $dbh->commit();
            }
        } catch (Exception $e) {
            $dbh->rollBack();
            return 0;
        }

        return $id_venta;
    }
    static public function mdlListarVentas($fechaDesde, $fechaHasta)
    {

        try {

            $stmt = Conexion::conectar()->prepare("SELECT Concat('Boleta Nro: ',v.nro_boleta,' - Total Venta: S./ ',Round(vc.total_venta,2)) as nro_boleta,
                                                            v.codigo_producto,
                                                            c.nombre_categoria,
                                                            p.descripcion_producto,
                                                            case when c.aplica_peso = 1 then concat(v.cantidad,' Kg(s)')
                                                            else concat(v.cantidad,' Und(s)') end as cantidad,                            
                                                            concat('S./ ',round(v.total_venta,2)) as total_venta,
                                                            v.fecha_venta
                                                            FROM venta_detalle v inner join productos p on v.codigo_producto = p.codigo_producto
                                                                                inner join venta_cabecera vc on cast(vc.nro_boleta as integer) = cast(v.nro_boleta as integer)
                                                                                inner join categorias c on c.id_categoria = p.id_categoria_producto
                                                    where DATE(v.fecha_venta) >= date(:fechaDesde) and DATE(v.fecha_venta) <= date(:fechaHasta)
                                                    order by v.nro_boleta asc");

            $stmt->bindParam(":fechaDesde", $fechaDesde, PDO::PARAM_STR);
            $stmt->bindParam(":fechaHasta", $fechaHasta, PDO::PARAM_STR);

            $stmt->execute();

            return $stmt->fetchAll();
        } catch (Exception $e) {
            return 'Excepción capturada: ' .  $e->getMessage() . "\n";
        }


        $stmt = null;
    }

    static public function mdlObtenerDetalleVenta($nro_boleta)
    {

        try {

            $stmt = Conexion::conectar()->prepare("select concat('B001-',vc.nro_boleta) as nro_boleta,
                                                        vc.total_venta,
                                                        vc.fecha_venta,
                                                        vd.codigo_producto,
                                                        upper(p.descripcion_producto) as descripcion_producto,
                                                        vd.cantidad,
                                                        vd.precio_unitario_venta,
                                                        vd.total_venta
                                                from venta_cabecera vc inner join venta_detalle vd on vc.nro_boleta = vd.nro_boleta
                                                                        inner join productos p on p.codigo_producto = vd.codigo_producto
                                                where vc.nro_boleta =  :nro_boleta");

            $stmt->bindParam(":nro_boleta", $nro_boleta, PDO::PARAM_STR);

            $stmt->execute();

            return $stmt->fetchAll();
        } catch (Exception $e) {
            return 'Excepción capturada: ' .  $e->getMessage() . "\n";
        }
    }

    /* =========================================================================================
    R E G I S T R A R   V E N T A
    ========================================================================================= */
    static public function mdlObtenerTipoComprobante()
    {
        $stmt = Conexion::conectar()->prepare("select id,concat(codigo,'-',descripcion) as descripcion  from tipo_comprobante where estado = 1;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerMoneda()
    {
        $stmt = Conexion::conectar()->prepare("select id,concat(id, ' - ', descripcion) as descripcion  from moneda where estado = 1;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerTipoDocumento()
    {
        $stmt = Conexion::conectar()->prepare("select id,concat(id, ' - ', descripcion) as descripcion  from tipo_documento where estado = 1;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerTipoOperacion()
    {
        $stmt = Conexion::conectar()->prepare("select codigo,concat(codigo, ' - ', descripcion) as descripcion  from tipo_operacion where estado = 1;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerSerieComprobante($id_filtro)
    {
        $stmt = Conexion::conectar()->prepare("select id,serie as descripcion  
                                            from serie where estado = 1 and id_tipo_comprobante = :id_filtro");
        $stmt->bindParam(":id_filtro", $id_filtro, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerCorrelativoSerie($id_serie)
    {
        $stmt = Conexion::conectar()->prepare("SELECT (correlativo  + 1) as correlativo
                                                FROM serie 
                                                WHERE estado = 1 
                                                AND id = :id_serie");
        $stmt->bindParam(":id_serie", $id_serie, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_OBJ);
    }

    static public function mdlObtenerFormaPago()
    {
        $stmt = Conexion::conectar()->prepare("select id, descripcion  
                                            from forma_pago where estado = 1 ");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlRegistrarComprobante($datos_emisor, $array_datos_comprobante)
    {

        //obtener datos del emisor
        $doc = new DOMDocument();
        $doc->formatOutput = FALSE;
        $doc->preserveWhiteSpace = TRUE;
        $doc->encoding = 'utf-8';

        $items = array(
            'item'                 => 1
        );

        $xml = '<?xml version="1.0" encoding="utf-8"?>
                    <Invoice xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:un:unece:uncefact:documentation:2" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2">
                        <ext:UBLExtensions>
                            <ext:UBLExtension>
                                <ext:ExtensionContent/>
                            </ext:UBLExtension>
                        </ext:UBLExtensions>
                        <cbc:UBLVersionID>2.1</cbc:UBLVersionID>
                        <cbc:CustomizationID schemeAgencyName="PE:SUNAT">2.0</cbc:CustomizationID>
                        <cbc:ProfileID schemeName="Tipo de Operacion" schemeAgencyName="PE:SUNAT" schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo17">' . $array_datos_comprobante['tipo_operacion'] . '</cbc:ProfileID>
                        <cbc:ID>' . $array_datos_comprobante['serie'] . '-' . $array_datos_comprobante['correlativo'] . '</cbc:ID>
                        <cbc:IssueDate>' . $array_datos_comprobante['fecha_emision'] . '</cbc:IssueDate>
                        <cbc:IssueTime>' . $array_datos_comprobante['hora_emision'] . '</cbc:IssueTime>
                        <cbc:DueDate>' . $array_datos_comprobante['fecha_vencimiento'] . '</cbc:DueDate>
                        <cbc:InvoiceTypeCode listAgencyName="PE:SUNAT" listName="Tipo de Documento" listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01" listID="0101" name="Tipo de Operacion">' . $array_datos_comprobante['tipo_comprobante'] . '</cbc:InvoiceTypeCode>
                        <cbc:DocumentCurrencyCode listID="ISO 4217 Alpha" listName="Currency" listAgencyName="United Nations Economic Commission for Europe">' . $array_datos_comprobante['moneda'] . '</cbc:DocumentCurrencyCode>
                        <cbc:LineCountNumeric>' . count($items) . '</cbc:LineCountNumeric>
                        <cac:Signature>
                            <cbc:ID>' . $array_datos_comprobante['serie'] . '-' . $array_datos_comprobante['correlativo'] . '</cbc:ID>
                            <cac:SignatoryParty>
                                <cac:PartyIdentification>
                                    <cbc:ID>' . $datos_emisor['ruc'] . '</cbc:ID>
                                </cac:PartyIdentification>
                                <cac:PartyName>
                                    <cbc:Name><![CDATA[' . $datos_emisor['razon_social'] . ']]></cbc:Name>
                                </cac:PartyName>
                            </cac:SignatoryParty>
                            <cac:DigitalSignatureAttachment>
                                <cac:ExternalReference>
                                    <cbc:URI>#SignatureSP</cbc:URI>
                                </cac:ExternalReference>
                            </cac:DigitalSignatureAttachment>
                        </cac:Signature>
                    </Invoice>';
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
                                                        clave_sol,
                                                        certificado_digital,
                                                        clave_certificado
                                                FROM empresas
                                                where id_empresa = :id_empresa");
        $stmt->bindParam(":id_empresa", $id_empresa, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerDatosCliente($tipo_documento, $nro_documento, $nombre_razon_social, $direccion, $telefono)
    {

        $stmt = Conexion::conectar()->prepare("SELECT id, 
                                                    id_tipo_documento as tipo_documento, 
                                                    nro_documento, 
                                                    nombres_apellidos_razon_social, 
                                                    direccion, 
                                                    telefono
                                                FROM clientes 
                                                where id_tipo_documento = :id_tipo_documento
                                                AND nro_documento = :nro_documento");

        $stmt->bindParam(":id_tipo_documento", $tipo_documento, PDO::PARAM_STR);
        $stmt->bindParam(":nro_documento", $nro_documento, PDO::PARAM_STR);
        $stmt->execute();

        $datos_cliente = $stmt->fetch(PDO::FETCH_NAMED);

        if ($datos_cliente) {
            return $datos_cliente;
        } else {

            $stmt = Conexion::conectar()->prepare("INSERT INTO clientes(id_tipo_documento, 
                                                                        nro_documento, 
                                                                        nombres_apellidos_razon_social, 
                                                                        direccion, 
                                                                        telefono)
                                                VALUES(:id_tipo_documento, 
                                                        :nro_documento, 
                                                        :nombres_apellidos_razon_social, 
                                                        :direccion, 
                                                        :telefono)");

            $stmt->bindParam(":id_tipo_documento", $tipo_documento, PDO::PARAM_STR);
            $stmt->bindParam(":nro_documento", $nro_documento, PDO::PARAM_STR);
            $stmt->bindParam(":nombres_apellidos_razon_social", $nombre_razon_social, PDO::PARAM_STR);
            $stmt->bindParam(":direccion", $direccion, PDO::PARAM_STR);
            $stmt->bindParam(":telefono", $telefono, PDO::PARAM_STR);

            $stmt->execute();

            $stmt = Conexion::conectar()->prepare("SELECT id, 
                                                            id_tipo_documento as tipo_documento, 
                                                            nro_documento, 
                                                            nombres_apellidos_razon_social, 
                                                            direccion, 
                                                            telefono
                                                        FROM clientes 
                                                        where id_tipo_documento = :id_tipo_documento
                                                        AND nro_documento = :nro_documento");

            $stmt->bindParam(":id_tipo_documento", $tipo_documento, PDO::PARAM_STR);
            $stmt->bindParam(":nro_documento", $nro_documento, PDO::PARAM_STR);
            $stmt->execute();

            return $stmt->fetch(PDO::FETCH_NAMED);
        }
    }

    static public function mdlObtenerDatosClienteXml($id_cliente)
    {

        $stmt = Conexion::conectar()->prepare("SELECT id, 
                                                    id_tipo_documento as tipo_documento, 
                                                    nro_documento, 
                                                    nombres_apellidos_razon_social, 
                                                    direccion, 
                                                    telefono
                                                FROM clientes 
                                                where id = :id_cliente");

        $stmt->bindParam(":id_cliente", $id_cliente, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerSerie($id_serie)
    {
        $stmt = Conexion::conectar()->prepare("SELECT *
                                                FROM serie 
                                                where id = :id_serie");
        $stmt->bindParam(":id_serie", $id_serie, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function ObtenerTipoAfectacionIGV($id_tipo_afectacion)
    {
        $stmt = Conexion::conectar()->prepare("SELECT *
                                                FROM tipo_afectacion_igv 
                                                where estado = 1
                                                and codigo = :id_tipo_afectacion");
        $stmt->bindParam(":id_tipo_afectacion", $id_tipo_afectacion, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function ObtenerCostoUnitarioUnidadMedida($codigo_producto)
    {
        $stmt = Conexion::conectar()->prepare("SELECT costo_unitario, id_unidad_medida
                                                FROM productos 
                                                where codigo_producto = :codigo_producto");
        $stmt->bindParam(":codigo_producto", $codigo_producto, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlActualizarRespuestaComprobante($id_venta, $nombre_xml, $hash_signature, $codigo_error_sunat, $mensaje_respuesta_sunat, $estado_respuesta_sunat, $xml_base64, $xml_cdr_sunat_base64)
    {

        $dbh = Conexion::conectar();

        try {

            if ($hash_signature == "") {
                $stmt = $dbh->prepare("UPDATE venta
                                                SET nombre_xml = ?,
                                                codigo_error_sunat  = ?,
                                                mensaje_respuesta_sunat = ?,
                                                estado_respuesta_sunat = ?,
                                                xml_base64 = ?,
                                                xml_cdr_sunat_base64 = ?,
                                                estado_comprobante = 1
                                            WHERE id = ?");
                $dbh->beginTransaction();
                $stmt->execute(array(
                    $nombre_xml,
                    $codigo_error_sunat,
                    $mensaje_respuesta_sunat,
                    $estado_respuesta_sunat,
                    $xml_base64,
                    $xml_cdr_sunat_base64,
                    $id_venta
                ));
                $dbh->commit();
            } else {
                $stmt = $dbh->prepare("UPDATE venta
                                        SET nombre_xml = ?,
                                        codigo_error_sunat  = ?,
                                        mensaje_respuesta_sunat = ?,
                                        hash_signature = ?,
                                        estado_respuesta_sunat = ?,
                                        xml_base64 = ?,
                                        xml_cdr_sunat_base64 = ?,
                                        estado_comprobante = 1
                                    WHERE id = ?");
                $dbh->beginTransaction();
                $stmt->execute(array(
                    $nombre_xml,
                    $codigo_error_sunat,
                    $mensaje_respuesta_sunat,
                    $hash_signature,
                    $estado_respuesta_sunat,
                    $xml_base64,
                    $xml_cdr_sunat_base64,
                    $id_venta
                ));
                $dbh->commit();
            }
        } catch (Exception $e) {
            $dbh->rollBack();
        }

        return "OK";
    }

    static public function mdlObtenerListadoBoletas($post)
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $columns = [
            "id",
            "comprobante",
            "fecha_emision",
            "ope_gravadas",
            "ope_exoneradas",
            "ope_inafectas",
            "total_igv",
            "importe_total",
            "estado_respuesta_sunat",
            "estado_sunat",
            "nombre_xml",
            "estado_comprobante",
            "mensaje_respuesta_sunat"
        ];

        $query = " SELECT 
                         '' as opciones,
                         v.id,
                        concat(v.serie,'-',v.correlativo) as comprobante, 
                        v.fecha_emision,
                        concat(mon.simbolo,format(v.total_operaciones_gravadas,2)) as ope_gravadas,
                        concat(mon.simbolo,format(v.total_operaciones_exoneradas,2)) as ope_exoneradas,
                        concat(mon.simbolo,format(v.total_operaciones_inafectas,2)) as ope_inafectas,
                        concat(mon.simbolo,format(v.total_igv,2)) as igv,
                        concat(mon.simbolo,format(v.importe_total,2)) as importe_total,
                        v.estado_respuesta_sunat,
                        case when v.estado_respuesta_sunat = 2 then 'Enviado, con errores'
                            when v.estado_respuesta_sunat = 1 then 'Comprobante enviado correctamente'
                            when v.estado_respuesta_sunat is null then 'Pendiente de envío'
                        end as estado_sunat,
                        nombre_xml,
                        estado_comprobante,
                        mensaje_respuesta_sunat
                from venta v inner join serie s on v.id_serie = s.id
                             inner join moneda mon on mon.id = v.id_moneda";

        if (isset($post["search"]["value"])) {
            $query .= '  WHERE s.id_tipo_comprobante = "03"
                        AND v.id_usuario = "' . $id_usuario . '"
                        AND ( v.serie like "%' . $post["search"]["value"] . '%" 
                                or ( case when v.estado_respuesta_sunat = 2 then "Enviado, con errores"
                                when v.estado_respuesta_sunat = 1 then "Comprobante enviado correctamente"
                                when v.estado_respuesta_sunat is null then "Pendiente de envío"
                            end) like "%' . $post["search"]["value"] . '%"                      
                        or v.correlativo like "%' . $post["search"]["value"] . '%")';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY v.id desc ';
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
            $sub_array[] = $row['comprobante'];
            $sub_array[] = $row['fecha_emision'];
            $sub_array[] = $row['ope_gravadas'];
            $sub_array[] = $row['ope_exoneradas'];
            $sub_array[] = $row['ope_inafectas'];
            $sub_array[] = $row['igv'];
            $sub_array[] = $row['importe_total'];
            $sub_array[] = $row['estado_respuesta_sunat'];
            $sub_array[] = $row['estado_sunat'];
            $sub_array[] = $row['nombre_xml'];
            $sub_array[] = $row['estado_comprobante'];
            $sub_array[] = $row['mensaje_respuesta_sunat'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT 1
                                                from venta v inner join serie s on v.id_serie = s.id
                                                where s.id_tipo_comprobante = '03'");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $clientes = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $clientes;
    }

    static public function mdlObtenerListadoBoletasPorFecha($post, $fecha_emision)
    {

        $columns = [
            "id",
            "comprobante",
            "fecha_emision",
            "ope_gravadas",
            "ope_exoneradas",
            "ope_inafectas",
            "total_igv",
            "importe_total",
            "estado_respuesta_sunat",
            "estado_sunat",
            "nombre_xml"
        ];

        $query = " SELECT 
                         v.id,
                        concat(v.serie,'-',v.correlativo) as comprobante, 
                        v.fecha_emision,
                        concat(mon.simbolo,format(v.total_operaciones_gravadas,2)) as ope_gravadas,
                        concat(mon.simbolo,format(v.total_operaciones_exoneradas,2)) as ope_exoneradas,
                        concat(mon.simbolo,format(v.total_operaciones_inafectas,2)) as ope_inafectas,
                        concat(mon.simbolo,format(v.total_igv,2)) as igv,
                        concat(mon.simbolo,format(v.importe_total,2)) as importe_total,
                        v.estado_respuesta_sunat,
                        case when v.estado_respuesta_sunat = 2 then 'Enviado, con errores'
                            when v.estado_respuesta_sunat = 1 then 'Comprobante enviado correctamente'
                            when v.estado_respuesta_sunat is null then 'Pendiente de envío'
                        end as estado_sunat,
                        nombre_xml
                from venta v inner join serie s on v.id_serie = s.id
                             inner join moneda mon on mon.id = v.id_moneda";

        if (isset($post["search"]["value"])) {
            $query .= '  WHERE s.id_tipo_comprobante = "03"  
                        AND date(v.fecha_emision) = "' . $fecha_emision . '"
                        AND ifnull(estado_respuesta_sunat,0) =! 1
                        AND ( v.serie like "%' . $post["search"]["value"] . '%" 
                                or ( case when v.estado_respuesta_sunat = 2 then "Enviado, con errores"
                                when v.estado_respuesta_sunat = 1 then "Comprobante enviado correctamente"
                                when v.estado_respuesta_sunat is null then "Pendiente de envío"
                            end) like "%' . $post["search"]["value"] . '%"                      
                        or v.correlativo like "%' . $post["search"]["value"] . '%")';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY v.id desc ';
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
            $sub_array[] = $row['id'];
            $sub_array[] = $row['comprobante'];
            $sub_array[] = $row['fecha_emision'];
            $sub_array[] = $row['ope_gravadas'];
            $sub_array[] = $row['ope_exoneradas'];
            $sub_array[] = $row['ope_inafectas'];
            $sub_array[] = $row['igv'];
            $sub_array[] = $row['importe_total'];
            $sub_array[] = $row['estado_respuesta_sunat'];
            $sub_array[] = $row['estado_sunat'];
            $sub_array[] = $row['nombre_xml'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT 1
                                                from venta v inner join serie s on v.id_serie = s.id
                                                where s.id_tipo_comprobante = '03'");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $clientes = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $clientes;
    }

    static public function mdlObtenerListadoFacturas($post)
    {

        $id_usuario = $_SESSION["usuario"]->id_usuario;

        $columns = [
            "id",
            "comprobante",
            "fecha_emision",
            "ope_gravadas",
            "ope_exoneradas",
            "ope_inafectas",
            "total_igv",
            "importe_total",
            "estado_respuesta_sunat",
            "estado_sunat",
            "nombre_xml",
            "estado_comprobante",
            "mensaje_respuesta_sunat"
        ];

        $query = " SELECT 
                         '' as opciones,
                         v.id,
                        concat(v.serie,'-',v.correlativo) as comprobante, 
                        v.fecha_emision,
                        concat(mon.simbolo,format(v.total_operaciones_gravadas,2)) as ope_gravadas,
                        concat(mon.simbolo,format(v.total_operaciones_exoneradas,2)) as ope_exoneradas,
                        concat(mon.simbolo,format(v.total_operaciones_inafectas,2)) as ope_inafectas,
                        concat(mon.simbolo,format(v.total_igv,2)) as igv,
                        concat(mon.simbolo,format(v.importe_total,2)) as importe_total,
                        v.estado_respuesta_sunat,
                        case when v.estado_respuesta_sunat = 2 then 'Enviado, con errores'
                            when v.estado_respuesta_sunat = 1 then 'Comprobante enviado correctamente'
                            when v.estado_respuesta_sunat is null then 'Pendiente de envío'
                        end as estado_sunat,
                        nombre_xml,
                        estado_comprobante,
                        mensaje_respuesta_sunat
                from venta v inner join serie s on v.id_serie = s.id
                             inner join moneda mon on mon.id = v.id_moneda";

        if (isset($post["search"]["value"])) {
            $query .= '  WHERE s.id_tipo_comprobante = "01"
                        AND v.id_usuario = "' . $id_usuario . '"
                        AND ( v.serie like "%' . $post["search"]["value"] . '%" 
                        or ( case when v.estado_respuesta_sunat = 2 then "Enviado, con errores"
                                when v.estado_respuesta_sunat = 1 then "Comprobante enviado correctamente"
                                when v.estado_respuesta_sunat is null then "Pendiente de envío"
                            end) like "%' . $post["search"]["value"] . '%"                      
                        or v.correlativo like "%' . $post["search"]["value"] . '%")';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY v.id desc ';
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
            // $sub_array[] = $row['detalles'];
            $sub_array[] = $row['opciones'];
            $sub_array[] = $row['id'];
            $sub_array[] = $row['comprobante'];
            $sub_array[] = $row['fecha_emision'];
            $sub_array[] = $row['ope_gravadas'];
            $sub_array[] = $row['ope_exoneradas'];
            $sub_array[] = $row['ope_inafectas'];
            $sub_array[] = $row['igv'];
            $sub_array[] = $row['importe_total'];
            $sub_array[] = $row['estado_respuesta_sunat'];
            $sub_array[] = $row['estado_sunat'];
            $sub_array[] = $row['nombre_xml'];
            $sub_array[] = $row['estado_comprobante'];
            $sub_array[] = $row['mensaje_respuesta_sunat'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT 1
                                                from venta v inner join serie s on v.id_serie = s.id
                                                where s.id_tipo_comprobante = '03'");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $clientes = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $clientes;
    }

    static public function mdlObtenerVentaPorId($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT e.id_empresa,
                                                    v.id_cliente,
                                                    e.razon_social as empresa,
                                                    e.ruc,
                                                    e.direccion as direccion_empresa,
                                                    concat(e.provincia  ,'-' ,e.departamento ,'-' ,e.distrito) as ubigeo,
                                                    s.id_tipo_comprobante,
                                                    v.serie,
                                                    v.correlativo,
                                                    v.fecha_emision,
                                                    v.hora_emision,
                                                    '' as cajero,
                                                    format(v.total_operaciones_gravadas,2) as ope_gravada,
                                                    format(v.total_operaciones_exoneradas,2) as ope_inafecta,
                                                    format(v.total_operaciones_inafectas,2) as ope_exonerada,
                                                    format(v.total_igv,2) as total_igv,
                                                    format(v.importe_total,2) as importe_total,
                                                    c.id_tipo_documento,
                                                    c.nro_documento,
                                                    c.nombres_apellidos_razon_social as nombres_apellidos_razon_social,
                                                    c.direccion,
                                                    c.telefono,
                                                    v.hash_signature,
                                                    m.simbolo,
                                                    v.forma_pago
                                            FROM venta v inner join empresas e on v.id_empresa_emisora = e.id_empresa
                                                        inner join moneda m on m.id = v.id_moneda
                                                        inner join serie s on s.id = v.id_serie
                                                        inner join clientes c on c.id = v.id_cliente
                                            WHERE v.id = :id_venta");
        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerVentaPorIdXml($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT e.id_empresa,
                                                    v.id_cliente,
                                                    v.tipo_operacion,
                                                    s.id_tipo_comprobante as tipo_comprobante,
                                                    v.id_serie,
                                                    v.serie,
                                                    v.correlativo,
                                                    v.fecha_emision,
                                                    v.hora_emision,
                                                    v.fecha_vencimiento,
                                                    v.id_moneda as moneda,
                                                    v.forma_pago,
                                                    round(ifnull(v.total_operaciones_gravadas,0) + ifnull(v.total_operaciones_exoneradas,0) + ifnull(v.total_operaciones_inafectas,0) + ifnull(v.total_igv,0),2) as monto_credito,
                                                    round(v.total_igv,2) as total_impuestos,
                                                    round(v.total_operaciones_gravadas,2) as total_operaciones_gravadas,
                                                    round(v.total_operaciones_exoneradas,2) as total_operaciones_exoneradas,
                                                    round(v.total_operaciones_inafectas,2) as total_operaciones_inafectas,
                                                    round(v.total_igv,2) as total_igv,
                                                    round(ifnull(v.total_operaciones_gravadas,0) + ifnull(v.total_operaciones_exoneradas,0) + ifnull(v.total_operaciones_inafectas,0),2) as total_sin_impuestos,
                                                    round(ifnull(v.total_operaciones_gravadas,0) + ifnull(v.total_operaciones_exoneradas,0) + ifnull(v.total_operaciones_inafectas,0) + ifnull(v.total_igv,0),2) as total_con_impuestos,
                                                    round(ifnull(v.total_operaciones_gravadas,0) + ifnull(v.total_operaciones_exoneradas,0) + ifnull(v.total_operaciones_inafectas,0) + ifnull(v.total_igv,0),2) as total_a_pagar

                                            FROM venta v inner join empresas e on v.id_empresa_emisora = e.id_empresa
                                                        inner join moneda m on m.id = v.id_moneda
                                                        inner join serie s on s.id = v.id_serie
                                                        inner join clientes c on c.id = v.id_cliente
                                            WHERE v.id = :id_venta");
        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerVentaParaResumen($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT v.id,
                                                s.id_tipo_comprobante,
                                                v.serie,
                                                v.correlativo,
                                                v.id_moneda,	
                                                v.total_operaciones_gravadas,
                                                v.total_operaciones_exoneradas,
                                                v.total_operaciones_inafectas,
                                                v.total_igv,
                                                v.importe_total	
                                            FROM venta v  inner join serie s on s.id = v.id_serie
                                            WHERE v.id = :id_venta");
        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerDetalleVentaPorId($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT dv.codigo_producto, 
                                                    dv.descripcion,
                                                    dv.cantidad,
                                                    format(dv.precio_unitario,2) as precio_unitario,
                                                    format(dv.importe_total,2) as importe_total
                                            FROM detalle_venta dv 
                                            WHERE dv.id_venta  = :id_venta");
        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerDetalleVentaPorIdXml($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT dv.item,
                                                    dv.codigo_producto, 
                                                    dv.descripcion,
                                                    dv.porcentaje_igv,
                                                    p.id_tipo_afectacion_igv,
                                                    p.id_unidad_medida as unidad,
                                                    dv.cantidad,
                                                    p.costo_unitario,
                                                    dv.valor_unitario,
                                                    dv.precio_unitario,
                                                    dv.valor_total,
                                                    dv.igv,
                                                    format(dv.importe_total,2) as importe_total
                                            FROM detalle_venta dv inner join productos p on dv.codigo_producto = p.codigo_producto	
                                            WHERE dv.id_venta  = :id_venta");
        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerCorrelativoResumen($fecha_envio, $resumen, $baja)
    {
        $stmt = Conexion::conectar()->prepare("SELECT max(correlativo) as correlativo
                                                FROM resumenes 
                                            WHERE resumen=:resumen 
                                            AND baja=:baja 
                                            AND fecha_envio=:fecha_envio 
                                        ORDER BY correlativo DESC LIMIT 1");

        $stmt->bindParam(":fecha_envio", $fecha_envio, PDO::PARAM_STR);
        $stmt->bindParam(":resumen", $resumen, PDO::PARAM_STR);
        $stmt->bindParam(":baja", $baja, PDO::PARAM_STR);
        $stmt->execute();
        $correlativo = $stmt->fetch(PDO::FETCH_OBJ);

        return isset($correlativo) ? $correlativo->correlativo + 1 : 1;
    }

    static public function mdlInsertarResumen($comprobante, $resumen_comprobante)
    {


        $dbh = Conexion::conectar();

        try {
            $stmt = $dbh->prepare("INSERT INTO resumenes(fecha_envio, 
                                                        fecha_referencia, 
                                                        correlativo, 
                                                        resumen, 
                                                        baja, 
                                                        estado) 
                                        VALUES(:fecha_envio, 
                                                :fecha_referencia, 
                                                :correlativo, 
                                                :resumen, 
                                                :baja, 
                                                :estado)");

            $dbh->beginTransaction();
            $stmt->execute(array(
                ':fecha_envio' => $comprobante["fecha_envio"],
                ':fecha_referencia' => $comprobante["fecha_emision"],
                ':correlativo' => $comprobante["correlativo"],
                ':resumen' => $comprobante["resumen"],
                ':baja' => $comprobante["baja"],
                ':estado' => $comprobante["estado"]
            ));

            $id_resumen = $dbh->lastInsertId();
            $dbh->commit();

            /* **************************************************************
            R E G I S T R A R   D E T A L L E   D E L   R E S U M E N
            ************************************************************** */
            foreach ($resumen_comprobante as $venta) {

                $stmt = $dbh->prepare("INSERT INTO resumenes_detalle(id_envio,id_comprobante,condicion) 
                                            VALUES(:id_envio,:id_comprobante,:condicion)");

                $dbh->beginTransaction();
                $stmt->execute(array(
                    ':id_envio' => $id_resumen,
                    ':id_comprobante' => $venta["id_comprobante"],
                    ':condicion' => $venta["condicion"]
                ));

                $dbh->commit();

                $productos_venta = VentasModelo::mdlObtenerDetalleVentaPorId($venta["id_comprobante"]);

                /* **************************************************************
                R E G I S T R A R   K A R D E X   D E   D E V O L U C I O N
                ************************************************************** */
                foreach ($productos_venta as $producto) {

                    $stmt = $dbh->prepare("call prc_registrar_kardex_anulacion(:id_venta, :codigo_producto)");

                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        ':id_venta' => $venta["id_comprobante"],
                        ':codigo_producto' => $producto["codigo_producto"]
                    ));

                    $dbh->commit();
                }
            }

            return $id_resumen;
        } catch (Exception $e) {
            $dbh->rollBack();
            return $e->getMessage();
        }
    }

    static public function mdlActualizarRespuestaResumen($id_resumen, $name_xml, $mensaje_sunat, $codigo_sunat, $ticket, $estado, $resumen_comprobante)
    {

        $dbh = Conexion::conectar();

        try {
            $stmt = $dbh->prepare("UPDATE resumenes 
                                    SET nombrexml=:name_xml, 
                                        mensaje_sunat=:mensaje_sunat, 
                                        codigo_sunat=:codigo_sunat, 
                                        estado=:estado, 
                                        ticket=:ticket 
                                    WHERE id=:id_resumen");
            $dbh->beginTransaction();
            $stmt->execute(array(
                ':nombrexml' => $name_xml,
                ':mensaje_sunat' => $mensaje_sunat,
                ':codigo_sunat' => $codigo_sunat,
                ':estado' => $estado,
                ':ticket' => $ticket,
                ':envio_id' => $id_resumen,
            ));
            $dbh->commit();

            if ($estado == 1) {

                foreach ($resumen_comprobante as $comprobante) {

                    $stmt = $dbh->prepare("UPDATE venta
                                    SET codigo_error_sunat = :codigo_sunat,
                                        mensaje_respuesta_sunat = :mensaje_sunat, 
                                        estado_respuesta_sunat = :estado_respuesta_sunat,
                                        estado_comprobante = :estado
                                    WHERE id=:id_venta");
                    $dbh->beginTransaction();
                    $stmt->execute(array(
                        ':codigo_sunat' => $codigo_sunat,
                        ':mensaje_sunat' => $mensaje_sunat,
                        ':estado_respuesta_sunat' => $estado,
                        ':estado' => $comprobante["condicion"],
                        ':id_venta' => $comprobante["id_comprobante"]
                    ));
                    $dbh->commit();
                }
            }
        } catch (Exception $e) {
            $dbh->rollBack();
        }

        return "OK";
    }

    static public function mdlInsertarCuotas($id_venta, $cronograma)
    {


        $dbh = Conexion::conectar();

        try {

            for ($i = 0; $i < count($cronograma); $i++) {

                $stmt = $dbh->prepare("INSERT INTO cuotas(id_venta, cuota, importe, importe_pagado,saldo_pendiente, cuota_pagada,fecha_vencimiento, estado)
                VALUES (:id_venta, :cuota, :importe, :importe_pagado, :saldo_pendiente, :cuota_pagada, :fecha_vencimiento, '1')");

                $dbh->beginTransaction();
                $stmt->execute(array(
                    ':id_venta'            => $id_venta,
                    ':cuota'            => $cronograma[$i]["cuota"],
                    ':importe'            => $cronograma[$i]["importe"],
                    ':importe_pagado'   => 0,
                    ':saldo_pendiente'   => $cronograma[$i]["importe"],
                    ':cuota_pagada'      => 0,
                    ':fecha_vencimiento' => $cronograma[$i]["vencimiento"]
                ));

                $dbh->commit();
            }

            return "ok";
        } catch (Exception $e) {
            $dbh->rollBack();
            return $e->getMessage();
        }
    }

    static public function mdlObtenerCuotas($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT id, 
                                                    id_venta, 
                                                    cuota, 
                                                    importe, 
                                                    fecha_vencimiento, 
                                                    estado
                                            FROM cuotas c 
                                            WHERE c.id_venta  = :id_venta");

        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_NAMED);
    }

    static public function mdlObtenerFacturasPorCobrar($post)
    {

        $columns = [
            "id",
            "factura",
            "fecha_emision",
            "importe_total",
            "nro_cuotas",
            "cuotas_pagadas",
            "saldo_pendiente"
        ];

        $query = "SELECT '' as opciones,
                        v.id,
                    concat(v.serie,'-',v.correlativo) as factura,
                    date(v.fecha_emision) as fecha_emision,
                    round(v.importe_total,2) as importe_total,
                    (select count(c.id) from cuotas c where c.id_venta = v.id) as nro_cuotas,
                    (select count(c.id) from cuotas c where c.id_venta = v.id and c.cuota_pagada = 1) as cuotas_pagadas,
                    round((select round(sum(ifnull(c.saldo_pendiente,0)),2) from cuotas c where c.id_venta = v.id and c.cuota_pagada = 0),2) as saldo_pendiente
                FROM venta v inner join serie s on v.id_serie = s.id
                WHERE s.id_tipo_comprobante = '01'
                and upper(v.forma_pago) = 'CREDITO' ";

        if (isset($post["search"]["value"])) {
            $query .= '  AND  (v.fecha_emision like "%' . $post["search"]["value"] . '%"
                                or concat(v.serie,"-",v.correlativo) like "%' . $post["search"]["value"] . '%")';
        }

        // var_dump($query);
        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY v.id desc ';
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
            $sub_array[] = $row['factura'];
            $sub_array[] = $row['fecha_emision'];
            $sub_array[] = $row['importe_total'];
            $sub_array[] = $row['nro_cuotas'];
            $sub_array[] = $row['cuotas_pagadas'];
            $sub_array[] = $row['saldo_pendiente'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(
            $query = `SELECT '' as opciones,
                            v.id,
                        concat(v.serie,'-',v.correlativo) as factura,
                        date(v.fecha_emision) as fecha_emision,
                        v.importe_total,
                        (select count(1) from cuotas c where c.id_venta = v.id) as nro_cuotas,
                        (select count(1) from cuotas c where c.id_venta = v.id and c.cuota_pagada = 1) as cuotas_pagadas,
                        (select round(sum(ifnull(c.saldo_pendiente,0)),2) from cuotas c where c.id_venta = v.id and c.cuota_pagada = 0) as saldo_pendiente
                    FROM venta v inner join serie s on v.id_serie = s.id
                    WHERE s.id_tipo_comprobante = '01'
                    and upper(v.forma_pago) = 'CREDITO'`
        );

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $facturas = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $facturas;
    }


    static public function mdlObtenerCuotasPorIdVenta($id_venta)
    {

        $stmt = Conexion::conectar()->prepare("SELECT id, 
                                                cuota, 
                                                round(importe,2) as  importe,
                                                round(importe_pagado,2) as  importe_pagado,
                                                round(saldo_pendiente,2) as saldo_pendiente,
                                                case when cuota_pagada = 0 then 'NO' else 'SI' end as cuota_pagada, 
                                                fecha_vencimiento
                                        from cuotas c
                                        where c.id_venta = :id_venta");

        $stmt->bindParam(":id_venta", $id_venta, PDO::PARAM_STR);
        $stmt->execute();

        return $stmt->fetchAll();
    }
}
