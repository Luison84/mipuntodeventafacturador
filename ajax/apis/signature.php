<?php
require_once('api_signature/XMLSecurityKey.php');
require_once('api_signature/XMLSecurityDSig.php');
require_once('api_signature/XMLSecEnc.php');

class Signature {
    public function signature_xml($flg_firma, $ruta, $ruta_firma, $pass_firma) {      
        
        
        $doc = new DOMDocument();

        $doc->formatOutput = FALSE;
        $doc->preserveWhiteSpace = TRUE;
        $doc->load($ruta);

        $objDSig = new XMLSecurityDSig(FALSE);
        $objDSig->setCanonicalMethod(XMLSecurityDSig::C14N);
        $options['force_uri'] = TRUE;
        $options['id_name'] = 'ID';
        $options['overwrite'] = FALSE;

        $objDSig->addReference($doc, XMLSecurityDSig::SHA1, array('http://www.w3.org/2000/09/xmldsig#enveloped-signature'), $options);
        $objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA1, array('type' => 'private'));

        
        // $ruta_firma = "\home\tutoria3\public_html\fe\certificado\certificado_phperu.pfx";
        $pfx = file_get_contents($ruta_firma);
        $key = array();
        // var_dump($pfx);
        //openssl_sign($pfx, $key, $pass_firma);
        openssl_pkcs12_read($pfx, $key, "123456");
        
        $objKey->loadKey($key["pkey"]);
        $objDSig->add509Cert($key["cert"], TRUE, FALSE);
        $objDSig->sign($objKey, $doc->documentElement->getElementsByTagName("ExtensionContent")->item($flg_firma));

        $atributo = $doc->getElementsByTagName('Signature')->item(0);
        $atributo->setAttribute('Id', 'SignatureSP');
        
        //===================rescatamos Codigo(HASH_CPE)==================
        $hash_cpe = $doc->getElementsByTagName('DigestValue')->item(0)->nodeValue;
        $firma_cpe = $doc->getElementsByTagName('SignatureValue')->item(0)->nodeValue;

        $doc->save($ruta);
        $resp['respuesta'] = 'ok';
        $resp['hash_cpe'] = $hash_cpe;
        $resp['firma_cpe'] = $firma_cpe;
        return $resp;
    }
}
?>