<?php

require_once "conexion.php";

class EmpresasModelo
{


    static public function mdlObtenerEmpresas_Select()
    {

        $stmt = Conexion::conectar()->prepare("SELECT id_empresa, razon_social 
                                                FROM empresas 
                                                WHERE estado = 1");

        $stmt->execute();
        return $stmt->fetchAll();
    }

    static public function mdlObtenerEmpresas($post)
    {

        $columns = [
            "id_empresa",
            "razon_social",
            "nombre_comercial",
            "id_tipo_documento",
            "tipo_documento",
            "ruc",
            "direccion",
            "simbolo_moneda",
            "email",
            "telefono",
            "provincia",
            "departamento",
            "distrito",
            "ubigeo",
            "usuario_sol",
            "clave_sol",
            "estado"
        ];

        $query = " SELECT 
                            '' as opciones,
                            e.id_empresa, 
                            e.razon_social, 
                            e.nombre_comercial, 
                            e.id_tipo_documento, 
                            td.descripcion as tipo_documento,
                            e.ruc, 
                            e.direccion, 
                            e.simbolo_moneda, 
                            e.email, 
                            e.telefono, 
                            e.provincia, 
                            e.departamento, 
                            e.distrito, 
                            e.ubigeo, 
                            e.usuario_sol, 
                            e.clave_sol,
                            case when e.estado = 1 then 'ACTIVO' else 'INACTIVO' end as estado
                    FROM empresas e inner join tipo_documento td on e.id_tipo_documento = td.id";

        if (isset($post["search"]["value"])) {
            $query .= ' WHERE e.razon_social like "%' . $post["search"]["value"] . '%"
                        or e.nombre_comercial like "%' . $post["search"]["value"] . '%"
                        or td.descripcion like "%' . $post["search"]["value"] . '%"
                        or e.ruc like "%' . $post["search"]["value"] . '%"
                        or e.direccion like "%' . $post["search"]["value"] . '%"
                        or e.email like "%' . $post["search"]["value"] . '%"
                        or e.telefono like "%' . $post["search"]["value"] . '%"
                        or e.provincia like "%' . $post["search"]["value"] . '%"
                        or e.departamento like "%' . $post["search"]["value"] . '%"
                        or e.distrito like "%' . $post["search"]["value"] . '%"
                        or case when e.estado = 1 then "ACTIVO" else "INACTIVO" end like "%' . $post["search"]["value"] . '%"';
        }

        if (isset($post["order"])) {
            $query .= ' ORDER BY ' . $columns[$post['order']['0']['column']] . ' ' . $post['order']['0']['dir'] . ' ';
        } else {
            $query .= ' ORDER BY e.id_empresa desc ';
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
            $sub_array[] = $row['id_empresa'];
            $sub_array[] = $row['razon_social'];
            $sub_array[] = $row['nombre_comercial'];
            $sub_array[] = $row['id_tipo_documento'];
            $sub_array[] = $row['tipo_documento'];
            $sub_array[] = $row['ruc'];
            $sub_array[] = $row['direccion'];
            $sub_array[] = $row['simbolo_moneda'];
            $sub_array[] = $row['email'];
            $sub_array[] = $row['telefono'];
            $sub_array[] = $row['provincia'];
            $sub_array[] = $row['departamento'];
            $sub_array[] = $row['distrito'];
            $sub_array[] = $row['ubigeo'];
            $sub_array[] = $row['usuario_sol'];
            $sub_array[] = $row['clave_sol'];
            $sub_array[] = $row['estado'];
            $data[] = $sub_array;
        }

        $stmt = Conexion::conectar()->prepare(" SELECT  1
                                                FROM empresas e 
                                                INNER JOIN tipo_documento td 
                                                ON e.id_tipo_documento = td.id");

        $stmt->execute();

        $count_all_data = $stmt->rowCount();

        $empresas = array(
            'draw' => $post['draw'],
            "recordsTotal" => $count_all_data,
            "recordsFiltered" => $number_filter_row,
            "data" => $data
        );

        return $empresas;
    }

    //=========================================================================================
    // R E G I S T R A R   E M P R E S A
    //=========================================================================================
    static public function mdlRegistrarEmpresa($empresa, $certificado = null, $imagen_logo = null)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = $dbh->prepare("INSERT INTO empresas(razon_social, 
                                                        nombre_comercial, 
                                                        id_tipo_documento, 
                                                        ruc, 
                                                        direccion, 
                                                        email, 
                                                        telefono, 
                                                        provincia, 
                                                        departamento, 
                                                        distrito, 
                                                        ubigeo, 
                                                        certificado_digital,
                                                        clave_certificado,
                                                        usuario_sol, 
                                                        clave_sol, 
                                                        es_principal,
                                                        fact_bol_defecto,
                                                        logo,
                                                        estado)
                                    VALUES(:razon_social, 
                                            UPPER(:nombre_comercial), 
                                            :id_tipo_documento, 
                                            :ruc, 
                                            UPPER(:direccion), 
                                            :email, 
                                            :telefono, 
                                            UPPER(:provincia), 
                                            UPPER(:departamento), 
                                            UPPER(:distrito), 
                                            :ubigeo, 
                                            :certificado_digital,
                                            :clave_certificado,
                                            :usuario_sol, 
                                            :clave_sol, 
                                            :es_principal,
                                            :fact_bol_defecto,
                                            :logo,
                                            :estado)");
            $dbh->beginTransaction();
            $stmt->execute(array(
                ':razon_social' => $empresa['razon_social'],
                ':nombre_comercial' => $empresa['nombre_comercial'],
                ':id_tipo_documento' => $empresa['tipo_documento'],
                ':ruc' => $empresa['nro_documento'],
                ':direccion' => $empresa['direccion'],
                ':email' => $empresa['email'],
                ':telefono' => $empresa['telefono'],
                ':provincia' => $empresa['provincia'],
                ':departamento' => $empresa['departamento'],
                ':distrito' => $empresa['distrito'],
                ':ubigeo' => $empresa['ubigeo'],
                ':certificado_digital' => $certificado["nombre_archivo"],
                ':clave_certificado' => $empresa['clave_certificado'] ,
                ':usuario_sol' => $empresa['usuario_sol'],
                ':clave_sol' => $empresa['clave_sol'],
                ':es_principal' => $empresa['rb_empresa_principal'],
                ':fact_bol_defecto' => $empresa['rb_fact_bol_defecto'],
                ':logo' => $imagen_logo["nuevoNombre"] ?? '',
                ':estado' => $empresa['estado']
            ));
            $dbh->commit();

            //GUARDAMOS EL CERTIFICADO
            if ($certificado) {
                $guardarCertificado = new EmpresasModelo();
                $guardarCertificado->guardarCertificado('../fe/certificado/', $certificado);
            }

            //GUARDAMOS EL LOGO DE LA EMPRESA
            if ($imagen_logo) {
                $guardarImagen = new EmpresasModelo();
                $guardarImagen->guardarImagen($imagen_logo["folder"], $imagen_logo["ubicacionTemporal"], $imagen_logo["nuevoNombre"]);
            }            

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se registró la empresa correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al registrar la empresa ' . $e->getMessage();
        }

        return $respuesta;
    }

    public function guardarImagen($folder, $ubicacionTemporal, $nuevoNombre)
    {
        file_put_contents(strtolower($folder . $nuevoNombre), file_get_contents($ubicacionTemporal));
    }

    //=========================================================================================
    // A C T U A L I Z A R   E M P R E S A
    //=========================================================================================
    static public function mdlActualizarEmpresa($empresa, $certificado = null)
    {

        $dbh = Conexion::conectar();

        try {

            $stmt = Conexion::conectar()->prepare("select certificado_digital, clave_certificado from empresas where id_empresa = :id_empresa");
            $stmt->bindParam(":id_empresa", $empresa["id_empresa"], PDO::PARAM_STR);
            $stmt->execute();

            $datos = $stmt->fetch();

            $certificado_actual = $datos["certificado_digital"];
            $clave_certificado_actual = $datos["clave_certificado"];

            $stmt = $dbh->prepare("UPDATE   empresas
                                     SET    razon_social = upper(?), 
                                            nombre_comercial = upper(?), 
                                            id_tipo_documento = ?, 
                                            ruc = ?, 
                                            direccion = upper(?), 
                                            email = ?, 
                                            telefono = ?, 
                                            provincia = upper(?), 
                                            departamento = upper(?), 
                                            distrito = upper(?), 
                                            ubigeo = ?, 
                                            certificado_digital = ?,
                                            clave_certificado = ?,
                                            usuario_sol = ?, 
                                            clave_sol = ?, 
                                            estado = ?
                                    WHERE   id_empresa = ?");
            $dbh->beginTransaction();
            $stmt->execute(array(
                $empresa['razon_social'],
                $empresa['nombre_comercial'],
                $empresa['tipo_documento'],
                $empresa['nro_documento'],
                $empresa['direccion'],
                $empresa['email'],
                $empresa['telefono'],
                $empresa['provincia'],
                $empresa['departamento'],
                $empresa['distrito'],
                $empresa['ubigeo'],
                $certificado['nombre_archivo'] ?? $certificado_actual,
                $empresa['clave_certificado'] ?? $clave_certificado_actual,
                $empresa['usuario_sol'],
                $empresa['clave_sol'],
                $empresa['estado'],
                $empresa['id_empresa']
            ));
            $dbh->commit();

            //GUARDAMOS EL CERTIFICADO
            if ($certificado) {
                $guardarCertificado = new EmpresasModelo();
                $guardarCertificado->guardarCertificado('../fe/certificado/', $certificado);
            }

            $respuesta['tipo_msj'] = 'success';
            $respuesta['msj'] = 'Se actualizó la empresa correctamente';
        } catch (Exception $e) {
            $dbh->rollBack();
            $respuesta['tipo_msj'] = 'error';
            $respuesta['msj'] = 'Error al actualizar la empresa ' . $e->getMessage();
        }

        return $respuesta;
    }

    static public function mdlValidarRucEmpresa($id_empresa, $ruc)
    {

        $stmt = Conexion::conectar()->prepare(" SELECT count(1) as existe
                                            FROM empresas emp 
                                            WHERE emp.id_empresa != :id_empresa
                                            AND emp.ruc = :ruc");

        $stmt->bindParam(":id_empresa", $id_empresa, PDO::PARAM_STR);
        $stmt->bindParam(":ruc", $ruc, PDO::PARAM_STR);

        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }

    public function guardarCertificado($folder, $certificado)
    {
        file_put_contents(strtolower($folder . $certificado["nombre_archivo"]), file_get_contents($certificado["ubicacionTemporal"]));
    }

    //=========================================================================================
    // OBTENER EMPRESA POR ID
    //=========================================================================================
    static public function mdlObtenerEmpresaPorId($id_empresa)
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
                                                        clave_certificado,
                                                        es_principal,
                                                        fact_bol_defecto,
                                                        logo,
                                                        estado
                                                FROM empresas
                                                where id_empresa = :id_empresa");
        $stmt->bindParam(":id_empresa", $id_empresa, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_NAMED);
    }
}
