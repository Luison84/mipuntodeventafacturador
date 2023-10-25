<?php

require_once "conexion.php";

class CajasModelo{

    static public function mdlListarCajas(){

        $stmt = Conexion::conectar()->prepare("SELECT c.id,
                                                c.nombre_caja
                                            from cajas c
                                            where c.estado = 1
                                            order by c.id");

        $stmt -> execute();

        return $stmt->fetchAll();

    }

}