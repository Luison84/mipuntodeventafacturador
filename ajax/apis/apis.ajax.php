<?php

require_once('../../modelos/clientes.modelo.php');

if (isset($_POST["accion"])) {

    switch ($_POST["accion"]) {

        case 'consultar_dni':

            // Datos
            $token = 'apis-token-5544.90Ef81FECRR3Hn4N52JYvlbUuQl0Q4wk';
            $dni = $_POST["nro_documento"];

            $response = ClientesModelo::mdlObtenerClientePorDocumento(1,$dni);
            if($response){
                $response["existe"] = "1";
                echo json_encode($response);
                return;
            }
            

            // Iniciar llamada a API
            $curl = curl_init();

            // Buscar dni
            curl_setopt_array($curl, array(
                // para user api versión 2
                CURLOPT_URL => 'https://api.apis.net.pe/v2/reniec/dni?numero=' . $dni,
                // para user api versión 1
                // CURLOPT_URL => 'https://api.apis.net.pe/v1/dni?numero=' . $dni,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYPEER => 0,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 2,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_CUSTOMREQUEST => 'GET',
                CURLOPT_HTTPHEADER => array(
                    'Referer: https://apis.net.pe/consulta-dni-api',
                    'Authorization: Bearer ' . $token
                ),
            ));

            $response = curl_exec($curl);

            curl_close($curl);
            // Datos listos para usar
            echo $response;
            break;


        case 'consultar_ruc':

            $token = 'apis-token-5544.90Ef81FECRR3Hn4N52JYvlbUuQl0Q4wk';
            $ruc = $_POST["nro_documento"];

            $response = ClientesModelo::mdlObtenerClientePorDocumento(6,$ruc);
            if($response){
                $response["existe"] = "1";
                echo json_encode($response);
                return;
            }
            // Iniciar llamada a API
            $curl = curl_init();

            // Buscar ruc sunat
            curl_setopt_array($curl, array(
                // para usar la versión 2
                CURLOPT_URL => 'https://api.apis.net.pe/v2/sunat/ruc?numero=' . $ruc,
                // para usar la versión 1
                // CURLOPT_URL => 'https://api.apis.net.pe/v1/ruc?numero=' . $ruc,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYPEER => 0,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_CUSTOMREQUEST => 'GET',
                CURLOPT_HTTPHEADER => array(
                    'Referer: http://apis.net.pe/api-ruc',
                    'Authorization: Bearer ' . $token
                ),
            ));

            $response = curl_exec($curl);
            curl_close($curl);
            // Datos de empresas según padron reducido
            echo $response;
            break;
    }
}
