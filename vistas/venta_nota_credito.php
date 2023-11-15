<!-- Content Header (Page header) -->
<div class="content-header pb-1">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">NOTA DE CRÉDITO</h2>

            </div><!-- /.col -->

            <div class="col-sm-6 d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="/">Inicio</a></li>

                    <li class="breadcrumb-item active">Ventas / Nota de Crédito</li>

                </ol>

            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container-fluid -->

</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content" style="position: relative;">

    <input type="hidden" name="id_caja" id="id_caja" value="0">

    <div class="row">

        <div class="col-12 ">

            <form id="frm-datos-venta" class="needs-validation-venta" novalidate>

                <div class="row">

                    <!-- --------------------------------------------------------- -->
                    <!-- OPCIONES DE REGISTRO DE VENTA (ENVIO SUNAT O SOLO REGISTRAR) -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-6 text-center mb-2">
                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-center my-0 ">
                            <div class="icheck-warning d-inline mx-2">
                                <input type="radio" id="rb-venta-envio" value="1" name="rb_generar_venta" checked="">
                                <label for="rb-venta-envio">
                                    Generar Venta y Enviar Comprobante
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-lg-6 text-center mb-2">
                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-center my-0 ">
                            <div class="icheck-success d-inline mx-2">
                                <input type="radio" id="rb-venta" value="2" name="rb_generar_venta">
                                <label for="rb-venta">
                                    Solo Generar Venta
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- --------------------------------------------------------- -->
                    <!-- DATOS DEL COMPROBANTE -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-6">

                        <div class="card card-gray shadow">

                            <div class="card-header">
                                <h3 class="card-title fs-6">COMPROBANTE DE PAGO</h3>
                                <div class="card-tools m-0">

                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove">
                                        <i class="fas fa-times"></i>
                                    </button>

                                </div> <!-- ./ end card-tools -->
                            </div> <!-- ./ end card-header -->

                            <div class="card-body py-2">

                                <div class="row">

                                    <!-- EMITIR POR -->
                                    <div class="col-12 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-building mr-1 my-text-color"></i> Empresa Emisora
                                        </label>
                                        <select class="form-select" id="empresa_emisora" name="empresa_emisora" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Empresa</div>
                                    </div>


                                    <!-- FECHA DE EMISION -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-calendar-alt mr-1 my-text-color"></i> Fecha Emisión
                                        </label>
                                        <div class="input-group input-group-sm mb-3 ">
                                            <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_emision">
                                                <i class="fas fa-calendar-alt ml-1 text-white"></i>
                                            </span>
                                            <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_emision" name="fecha_emision" aria-describedby="inputGroup-sizing-sm" required>
                                            <div class="invalid-feedback">Ingrese Fecha de Emisión</div>
                                        </div>
                                    </div>


                                    <!-- TIPO COMPROBANTE -->
                                    <div class="col-12 col-md-8 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-file-contract mr-1 my-text-color"></i>Tipo de Comprobante
                                        </label>
                                        <select class="form-select" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>


                                    <!-- SERIE -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Serie</label>
                                        <select class="form-select" id="serie" name="serie" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Serie del Comprobante</div>
                                    </div>

                                    <!-- CORRELATIVO -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Correlativo</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="correlativo" name="correlativo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required readonly>
                                    </div>

                                    <!-- MONEDA -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-money-bill-wave mr-1 my-text-color"></i>Moneda</label>
                                        <select class="form-select" id="moneda" name="moneda" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione la moneda</div>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- --------------------------------------------------------- -->
                    <!-- DATOS DEL COMPROBANTE MODIFICADO-->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-6">

                        <div class="card card-gray shadow">

                            <div class="card-header">
                                <h3 class="card-title fs-6">COMPROBANTE DE PAGO A MODIFICAR</h3>
                                <div class="card-tools m-0">

                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove">
                                        <i class="fas fa-times"></i>
                                    </button>

                                </div> <!-- ./ end card-tools -->
                            </div> <!-- ./ end card-header -->

                            <div class="card-body py-2">

                                <div class="row">
                                 

                                    <!-- TIPO COMPROBANTE -->
                                    <div class="col-12 col-md-8 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-file-contract mr-1 my-text-color"></i>Tipo de Comprobante
                                        </label>
                                        <select class="form-select" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>


                                    <!-- SERIE -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Serie</label>
                                        <select class="form-select" id="serie" name="serie" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Serie del Comprobante</div>
                                    </div>

                                    <!-- CORRELATIVO -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Correlativo</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="correlativo" name="correlativo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required readonly>
                                    </div>

                                    <!-- TIPO NOTA DE CREDITO -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-money-bill-wave mr-1 my-text-color"></i>Motivo Nota de Crédito</label>
                                        <select class="form-select" id="moneda" name="moneda" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el motivo</div>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- --------------------------------------------------------- -->
                    <!-- LISTADO DE PRODUCTOS -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-8">

                        <div class="card card-gray shadow">

                            <div class="card-header">
                                <h4 class="card-title fs-6">LISTADO DE PRODUCTOS</h4>
                            </div> <!-- ./ end card-header -->

                            <div class="card-body py-2">

                                <div class="row">

                                    <div class="d-block col-12 d-lg-none mb-3">
                                        <div class="col-12 text-center px-2 rounded-3">
                                            <div class="btn fw-bold fs-3  text-warning my-bg w-100" id="totalVenta">S/0.00</div>
                                        </div>
                                    </div>

                                    <!-- INPUT PARA INGRESO DEL CODIGO DE BARRAS O DESCRIPCION DEL PRODUCTO -->
                                    <div class="col-12 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-cart-plus mr-1 my-text-color"></i>Digite el Producto a vender</label>
                                        <input type="text" placeholder="Ingrese el código de barras o el nombre del producto" style="border-radius: 20px;" class="form-control form-control-sm" id="producto" name="producto" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                    </div>

                                    <div class="col-12 col-lg-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-alt mr-1 my-text-color"></i>Tipo Operación</label>
                                        <select class="form-select" id="tipo_operacion" name="tipo_operacion" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Ingrese el Tipo de Operación</div>
                                    </div>

                                    <!-- FORMA DE PAGO -->
                                    <div class="col-12 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="far fa-credit-card mr-1 my-text-color"></i>Forma de Pago</label>
                                        <select class="form-select" id="forma_pago" name="forma_pago" aria-label="Floating label select example" required readonly>
                                        </select>
                                        <div class="invalid-feedback">Ingrese Forma de Pago</div>
                                    </div>

                                    <!-- TOTAL RECIBIDO -->
                                    <div class="col-6 col-lg-3 mb-2">

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-hand-holding-usd mr-1 my-text-color"></i>Total Recibido</label>
                                        <input type="number" min="0" step="0.01" placeholder="Dinero recibido" style="border-radius: 20px;" class="form-control form-control-sm" id="total_recibido" name="total_recibido" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                    </div>

                                    <!-- VUELTO -->
                                    <div class="col-6 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-hand-holding-usd mr-1 my-text-color"></i>Vuelto</label>
                                        <input type="number" min="0" step="0.01" placeholder="Vuelto" style="border-radius: 20px;" class="form-control form-control-sm" id="vuelto" name="vuelto" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                    </div>


                                    <!-- LISTADO QUE CONTIENE LOS PRODUCTOS QUE SE VAN AGREGANDO PARA LA COMPRA -->
                                    <div class="col-md-12 mt-2">

                                        <table id="tbl_ListadoProductos" class="display nowrap table-striped w-100 shadow ">
                                            <thead class="bg-main text-left fs-6">
                                                <tr>
                                                    <th>ITEM</th>
                                                    <th>CÓDIGO</th>
                                                    <th>DESCRIPCIÓN</th>
                                                    <th>ID TIPO IGV</th>
                                                    <th>TIPO IGV</th>
                                                    <th>UND/MEDIDA</th>
                                                    <th>VALOR</th>
                                                    <th>CANTIDAD</th>
                                                    <th>CANTIDAD FINAL</th>
                                                    <th>SUBTOTAL</th>
                                                    <th>IGV</th>
                                                    <th>IMPORTE</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="small text-left fs-6">
                                            </tbody>
                                        </table>
                                        <!-- / table -->
                                    </div>


                                    <!-- /.col -->
                                </div>
                            </div> <!-- ./ end card-body -->
                        </div>
                    </div>

                    <!-- --------------------------------------------------------- -->
                    <!-- RESUMEN DE LA VENTA -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-4">

                        <div class="row">

                            <div class="col-12">
                                <!-- --------------------------------------------------------- -->
                                <!-- RESUMEN DE LA VENTA -->
                                <!-- --------------------------------------------------------- -->
                                <div class="card card-gray shadow w-lg-100 float-right">

                                    <div class="card-header">
                                        <h3 class="card-title fs-6">RESUMEN</h3>
                                    </div> <!-- ./ end card-header -->

                                    <div class="card-body py-2">

                                        <div class="row fw-bold">

                                            <div class="col-12 col-md-12">
                                                <span>OP. GRAVADAS</span>
                                                <span class="float-right" id="resumen_opes_gravadas">S/
                                                    0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>OP. INAFECTAS</span>
                                                <span class="float-right" id="resumen_opes_inafectas">S/
                                                    0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>OP. EXONERADAS</span>
                                                <span class="float-right" id="resumen_opes_exoneradas">S/
                                                    0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>SUBTOTAL</span>
                                                <span class="float-right" id="resumen_subtotal">S/ 0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>IGV</span>
                                                <span class="float-right" id="resumen_total_igv">S/ 0.00</span>
                                                <hr class="m-1" />
                                            </div>

                                            <div class="col-12 col-md-12 fs-4 my-color">
                                                <span>TOTAL</span>
                                                <span class="float-right " id="resumen_total_venta">S/
                                                    0.00</span>
                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </div>

                            <div class="col-12 text-center my-1">

                                <div class="row">
                                    <div class="col-6">
                                        <a class="btn btn-sm btn-danger  fw-bold w-100 " id="btnCancelarVenta" style="position: relative;">
                                            <span class="text-button">CANCELAR</span>
                                            <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="col-6">
                                        <a class="btn btn-sm btn-success  fw-bold  w-100" id="btnGuardarComprobante" style="position: relative;">
                                            <span class="text-button">VENDER</span>
                                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                                <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                                            </span>
                                        </a>
                                    </div>
                                </div>

                            </div>
                            
                        </div>

                    </div>

                </div>

            </form>

        </div>

    </div>

</div>

<!-- <div class="loading">Loading</div> -->