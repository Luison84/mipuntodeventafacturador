<!-- Content Header (Page header) -->
<div class="content-header pb-1">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">BOLETA</h2>

            </div><!-- /.col -->

            <div class="col-sm-6 d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="/">Inicio</a></li>

                    <li class="breadcrumb-item active">Ventas / Boleta</li>

                </ol>

            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container-fluid -->

</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content">

    <input type="hidden" name="id_caja" id="id_caja" value="0">

    <div class="row">

        <div class="col-12 ">

            <div class="card card-primary card-outline card-outline-tabs">

                <div class="card-header p-0 border-bottom-0">

                    <ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">

                        <!-- TAB REGISTRO DE BOLETAS -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="registrar-boletas-tab" data-toggle="pill" href="#registrar-boletas" role="tab" aria-controls="registrar-boletas" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar Boleta</a>
                        </li>

                        <!-- TAB LISTADO DE BOLETAS -->
                        <li class="nav-item">
                            <a class="nav-link my-0" id="listado-boletas-tab" data-toggle="pill" href="#listado-boletas" role="tab" aria-controls="listado-boletas" aria-selected="true"><i class="fas fa-list"></i> Listado de Boletas</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body py-1">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT REGISTRO DE BOLETAS -->
                        <div class="tab-pane fade active show" id="registrar-boletas" role="tabpanel" aria-labelledby="registrar-boletas-tab">

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
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-building mr-1 my-text-color"></i> Empresa Emisora</label>
                                                        <select class="form-select" id="empresa_emisora" name="empresa_emisora" aria-label="Floating label select example" required>
                                                        </select>
                                                        <div class="invalid-feedback">Seleccione Empresa</div>
                                                    </div>

                                                    <!-- FECHA DE EMISION -->
                                                    <div class="col-12 col-md-4 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-calendar-alt mr-1 my-text-color"></i> Fecha Emisión</label>
                                                        <div class="input-group input-group-sm mb-3 ">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_emision"><i class="fas fa-calendar-alt ml-1 text-white"></i></span>
                                                            <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_emision" name="fecha_emision" aria-describedby="inputGroup-sizing-sm" required>
                                                            <div class="invalid-feedback">Ingrese Fecha de Emisión</div>
                                                        </div>
                                                    </div>

                                                    <!-- TIPO COMPROBANTE -->
                                                    <div class="col-12 col-md-8 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-contract mr-1 my-text-color"></i>Tipo de Comprobante</label>
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
                                    <!-- DATOS DEL CLIENTE -->
                                    <!-- --------------------------------------------------------- -->
                                    <div class="col-12 col-lg-6">

                                        <div class="card card-gray shadow">

                                            <div class="card-header">
                                                <h3 class="card-title fs-6">DATOS DEL CLIENTE</h3>
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

                                                    <div class="col-12 col-md-6 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-signature mr-1 my-text-color"></i>Tipo Documento</label>
                                                        <select class="form-select" id="tipo_documento" name="tipo_documento" aria-label="Floating label select example" required>
                                                        </select>
                                                        <div class="invalid-feedback">Seleccione el Tipo de Documento</div>
                                                    </div>

                                                    <div class="col-12 col-md-6 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i> Nro Documento</label>
                                                        <div class="input-group input-group-sm mb-3 ">
                                                            <span class="input-group-text btnConsultarDni" id="inputGroup-sizing-sm" style="cursor: pointer;"><i class="fas fa-search ml-1 text-white"></i></span>
                                                            <input type="text" class="form-control form-control-sm" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="nro_documento" name="nro_documento" placeholder="Ingrese Nro de documento" aria-describedby="inputGroup-sizing-sm" required>
                                                            <div class="invalid-feedback">Ingrese el Nro de Documento</div>
                                                        </div>

                                                    </div>

                                                    <div class="col-12 col-md-12 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-user-tie mr-1 my-text-color"></i>Nombre del Cliente/ Razón Social</label>
                                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nombre_cliente_razon_social" name="nombre_cliente_razon_social" placeholder="Ingrese Nombre del Cliente o Razón Social" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                                    </div>

                                                    <div class="col-12 col-md-9 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-map-marker-alt mr-1 my-text-color"></i>Dirección</label>
                                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="direccion" name="direccion" placeholder="Ingrese la dirección" aria-label="Small" aria-describedby="inputGroup-sizing-sm">

                                                    </div>

                                                    <div class="col-12 col-md-3 mb-2">
                                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-phone-alt mr-1 my-text-color"></i>Teléfono</label>
                                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="telefono" name="telefono" placeholder="Teléfono" aria-label="Small" aria-describedby="inputGroup-sizing-sm">

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

                                                    <div class="d-block col-12 d-lg-none col-lg-12 mb-3">
                                                        <div class="col-12 text-center px-2 rounded-3">
                                                            <div class="btn fw-bold fs-3  text-warning my-bg w-100" id="totalVenta">S/0.00</div>
                                                        </div>
                                                    </div>

                                                    <!-- INPUT PARA INGRESO DEL CODIGO DE BARRAS O DESCRIPCION DEL PRODUCTO -->
                                                    <div class="col-12 mb-2">
                                                        <!-- <div class="form-floating mb-2">
                                                            <input type="text" id="producto" class="form-control" name="producto">
                                                            <label for="producto">Digite el Producto a vender</label>                                                            
                                                        </div> -->
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

                                            <!-- <div class="d-none d-lg-block col-lg-12 mb-3">
                                                <div class="col-12 text-center px-2 rounded-3">
                                                    <div class="btn fw-bold fs-3  text-warning my-bg w-100" id="totalVenta">S/0.00</div>
                                                </div>
                                            </div> -->

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

                                                <!-- <div class="row">
                                                    <div class="col-12 text-right">
                                                        <a class="btn btn-sm btn-danger  fw-bold w-25" id="btnCancelarVenta" style="position: relative;">
                                                            <span class="text-button">CANCELAR</span>
                                                            <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                                <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                            </span>
                                                        </a>

                                                        <a class="btn btn-sm btn-success  fw-bold w-25" id="btnGuardarComprobante" style="position: relative;">
                                                            <span class="text-button">VENDER</span>
                                                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                                                <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                                                            </span>
                                                        </a>

                                                    </div>
                                                </div> -->
                                            </div>

                                            <!-- <div class="col-12 text-center">
                                                <div class="form-group clearfix w-100 d-flex justify-content-evenly ">
                                                    <div class="icheck-warning d-inline mx-2">
                                                        <input type="radio" id="rb-venta-envio" value="1" name="rb_generar_venta" checked="">
                                                        <label for="rb-venta-envio">
                                                            Generar Venta y Enviar Comprobante
                                                        </label>
                                                    </div>

                                                    <div class="icheck-success d-inline mx-2">
                                                        <input type="radio" id="rb-venta" value="2" name="rb_generar_venta">
                                                        <label for="rb-venta">
                                                            Solo Generar Venta
                                                        </label>
                                                    </div>

                                                </div>

                                            </div> -->
                                        </div>


                                    </div>

                                </div>

                            </form>

                        </div>

                        <!-- TAB CONTENT LISTADO DE BOLETAS -->
                        <div class="tab-pane fade" id="listado-boletas" role="tabpanel" aria-labelledby="listado-boletas-tab">

                            <div class="row">

                                <!--LISTADO DE BOLETAS -->
                                <div class="col-md-12">

                                    <table id="tbl_boletas" class="table shadow border border-secondary" style="width:100%">
                                        <thead class="bg-main text-left">
                                            <th></th>
                                            <th>Id</th>
                                            <th>Comprob.</th>
                                            <th>Fec. Emisión</th>
                                            <th>Ope. Gravadas</th>
                                            <th>Ope. Exoneradas</th>
                                            <th>Ope. Inafectas</th>
                                            <th>Total Igv</th>
                                            <th>Importe Total</th>
                                            <th>Cod. Est. Sunat</th>
                                            <th>SUNAT</th>
                                            <th>Nombre Xml</th>
                                            <th>Estado Comprobante</th>
                                            <th>Mensaje Sunat</th>
                                        </thead>
                                    </table>

                                </div>

                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


<script>
    //Variables Globales
    var itemProducto = 1;
    $(document).ready(function() {

        /*===================================================================*/
        // V E R I F I C A R   E L   E S T A D O   D E   L A   C A J A
        /*===================================================================*/
        fnc_ObtenerEstadoCajaPorDia()

        /*===================================================================*/
        // I N I C I A L I Z A R   F O R M U L A R I O 
        /*===================================================================*/
        fnc_InicializarFormulario();


        $('#tipo_comprobante').on('change', function(e) {
            $("#correlativo").val('')
            CargarSelect(null, $("#serie"), "--Seleccionar--", "ajax/ventas.ajax.php",
                'obtener_serie_comprobante', $('#tipo_comprobante').val());
        });

        $('#tipo_documento').on('change', function(e) {

            $("#nro_documento").val('')
            $("#nombre_cliente_razon_social").val('')
            $("#direccion").val('')
            $("#telefono").val('')

            if ($('#tipo_documento').val() == 0) {
                fnc_BloquearDatosCliente(true)
            } else {
                fnc_BloquearDatosCliente(false)
            }

        });

        $('#serie').on('change', function(e) {
            fnc_ObtenerCorrelativo($("#serie").val())
        })

        $(".btnConsultarDni").on('click', function() {
            fnc_ConsultarNroDocumento($("#nro_documento").val());
        })

        $("#producto").on('keypress', function(e) {
            if (e.which == 13) {
                CargarProductos($("#producto").val());
            }
        });

        /* ======================================================================================
        EVENTO PARA MODIFICAR EL PRECIO DE VENTA DEL PRODUCTO
        ====================================================================================== */
        $('#tbl_ListadoProductos tbody').on('click', '.dropdown-item', function() {

            codigo_producto = $(this).attr("codigo");
            precio_venta = parseFloat($(this).attr("precio")).toFixed(2);

            recalcularMontos(codigo_producto, precio_venta);
        });

        /* ======================================================================================
        EVENTO PARA MODIFICAR LA CANTIDAD DE PRODUCTOS A COMPRAR
        ====================================================================================== */
        $('#tbl_ListadoProductos tbody').on('change', '.iptCantidad', function() {

            cantidad_actual = $(this)[0]['value'];
            cod_producto_actual = $(this)[0]['attributes']['codigoproducto']['value'];

            if (cantidad_actual.length == 0 || cantidad_actual == 0) {
                cantidad_actual = 1;
            }

            $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

                var row = $('#tbl_ListadoProductos').DataTable().row(index);

                var data = row.data();

                if (data['codigo_producto'] == cod_producto_actual) {

                    $.ajax({
                        async: false,
                        url: "ajax/productos.ajax.php",
                        method: "POST",
                        data: {
                            'accion': 'verificar_stock',
                            'codigo_producto': cod_producto_actual,
                            'cantidad_a_comprar': cantidad_actual
                        },
                        dataType: 'json',
                        success: function(respuesta) {

                            //SI EL PRODUCTO NO TIENE STOCK
                            if (parseInt(respuesta['stock']) < parseInt(cantidad_actual)) {


                                mensajeToast('error', ' El producto ' + data['descripcion'] + ' no tiene el stock ingresado, el stock actual es: ' + respuesta.stock);

                                $precio = $('#tbl_ListadoProductos').DataTable().cell(
                                    index, 6).data()
                                $id_tipo_afectacion = $('#tbl_ListadoProductos')
                                    .DataTable().cell(index, 3).data()

                                let $subtotal = 0;
                                let $factor_igv = 0;
                                let $porcentaje_igv = 0;
                                let $igv = 0;
                                let $importe = 0;

                                // ACTUALIZAR CANTIDAD A 1
                                $('#tbl_ListadoProductos').DataTable().cell(index, 7)
                                    .data(`<input  type="number" min="0"
                                                                    style="width:80px;" 
                                                                    codigoProducto = "` + cod_producto_actual + `" 
                                                                    class="form-control text-center iptCantidad m-0 p-0" 
                                                                    value="1">`).draw();

                                $('#tbl_ListadoProductos').DataTable().cell(index, 8)
                                    .data("1")

                                //ACTUALIZAR SUBTOTAL
                                $subtotal = $precio * 1;
                                $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat($subtotal).toFixed(2)).draw();

                                //ACTUALIZAR IGV
                                if ($id_tipo_afectacion == 10) {
                                    $factor_igv = 1.18;
                                    $porcentaje_igv = 0.18;
                                    $igv = ($precio * 1 * $porcentaje_igv);
                                } else {
                                    $igv = 0
                                    $factor_igv = 1;
                                }

                                $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($igv).toFixed(2)).draw();

                                //ACTUALIZAR IMPORTE
                                $importe = ($precio * 1) * $factor_igv; // * EL FACTOR DE IGV = 1.18
                                $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat($importe).toFixed(2)).draw();

                                $("#producto").val("");
                                $("#producto").focus();

                                //

                                // RECALCULAMOS TOTALES
                                recalcularTotales();

                                // CUANDO EL PRODUCTO SI TIENE STOCK
                            } else {


                                //OBTENER PRECIO DEL PRODUCTO
                                $precio = $('#tbl_ListadoProductos').DataTable().cell(
                                    index, 6).data();
                                $id_tipo_afectacion = $('#tbl_ListadoProductos')
                                    .DataTable().cell(index, 3).data();

                                let $subtotal = 0;
                                let $factor_igv = 0;
                                let $porcentaje_igv = 0;
                                let $igv = 0;
                                let $importe = 0;

                                // ACTUALIZAR CANTIDAD
                                $('#tbl_ListadoProductos').DataTable().cell(index, 7)
                                    .data(`<input type="number"  min="0"
                                                                                                style="width:80px;" 
                                                                                                codigoProducto = "` +
                                        cod_producto_actual + `" 
                                                                                                class="form-control text-center iptCantidad m-0 p-0" 
                                                                                                value="` +
                                        cantidad_actual + `">`).draw();


                                $('#tbl_ListadoProductos').DataTable().cell(index, 8)
                                    .data(cantidad_actual)

                                //CALCULAR SUBTOTAL
                                $subtotal = $precio * cantidad_actual
                                $('#tbl_ListadoProductos').DataTable().cell(index, 9)
                                    .data(parseFloat($subtotal).toFixed(2)).draw();

                                //CALCULAR IGV
                                if ($id_tipo_afectacion == 10) {
                                    $factor_igv = 1.18;
                                    $porcentaje_igv = 0.18;
                                    $igv = ($precio * cantidad_actual *
                                        $porcentaje_igv); // * EL % DE IGV = 0.18

                                } else {
                                    $igv = 0
                                    $factor_igv = 1;
                                }
                                $('#tbl_ListadoProductos').DataTable().cell(index, 10)
                                    .data(parseFloat($igv).toFixed(2)).draw();

                                //CALCULAR IMPORTE
                                $importe = ($precio * cantidad_actual) *
                                    $factor_igv; // * EL FACTOR DE IGV = 1.18
                                $('#tbl_ListadoProductos').DataTable().cell(index, 11)
                                    .data(parseFloat($importe).toFixed(2)).draw();

                                $("#producto").val("");
                                $("#producto").focus();

                                // RECALCULAMOS TOTALES
                                recalcularTotales();
                            }
                        }
                    });

                }

            });

        });

        /* ======================================================================================
        EVENTO PARA ELIMINAR UN PRODUCTO DEL LISTADO
        ====================================================================================== */
        $('#tbl_ListadoProductos tbody').on('click', '.btnEliminarproducto', function() {
            $('#tbl_ListadoProductos').DataTable().row($(this).parents('tr')).remove().draw();
            recalcularTotales();
        });

        $("#btnGuardarComprobante").on('click', function() {
            fnc_GuardarVenta();
        })

        /* ======================================================================================
        EVENTO PARA MODIFICAR EL PRECIO DE VENTA DEL PRODUCTO
        ====================================================================================== */
        // $('#tbl_boletas tbody').on('click', '.dropdown-item', function() {

        //     id_boleta = $(this).attr("id-boleta");
        //     opcion = $(this).attr("opcion");

        //     alert(opcion);
        // });

        $("#total_recibido").change(function() {
            $total_venta = $("#totalVenta").html().replace('S/ ', '');
            $total_recibido = parseFloat($("#total_recibido   ").val());

            if ($total_recibido < $total_venta) {
                mensajeToast("warning", "El monto recibido es menor al valor de la venta");
                $("#total_recibido").val($total_venta)
                $("#vuelto").val(0)
                return;
            }

            $("#vuelto").val(parseFloat($total_recibido - $total_venta).toFixed(2));
        })

        $('#tbl_boletas tbody').on('click', '.btnEnviarSunat', function() {
            var data = $('#tbl_boletas').DataTable().row($(this).parents('tr')).data();
            $id_venta = data[1];
            fnc_EnviarComprobanteSunat($id_venta)
        })

        $('#tbl_boletas tbody').on('click', '.btnImprimirBoleta', function() {
            var data = $('#tbl_boletas').DataTable().row($(this).parents('tr')).data();
            $id_venta = data[1];
            fnc_ImprimirBoleta($id_venta)
        });

        $("#btnCancelarVenta").on('click', function() {
            fnc_InicializarFormulario();
        })

        $('#tbl_ListadoProductos tbody').on('keypress', '.iptCantidad', function(e) {
            var key = e.keyCode;
            //102 -> F
            //98 -> B

            if (key == 45) {
                e.preventDefault();
            }

        });

        $("#listado-boletas-tab").on('click', function() {
            fnc_CargarDataTableListadoBoletas();
        })

        $('#tbl_boletas tbody').on('click', '.btnAnularBoleta', function() {
            var data = $('#tbl_boletas').DataTable().row($(this).parents('tr')).data();
            $id_venta = data[1];
            $fecha_emision = data[3];
            fnc_AnularComprobante($id_venta, $fecha_emision)
        });

        $('#tbl_boletas tbody').on('click', '.btnMensajeRespuestaSunat', function() {
            var data = $('#tbl_boletas').DataTable().row($(this).parents('tr')).data();
            Swal.fire(data[13])
        })

    })

    function fnc_InicializarFormulario() {

        CargarSelects();
        fnc_ObtenerCorrelativo($("#serie").val())
        fnc_BloquearDatosCliente(true);
        fnc_CargarPluginDateTime();
        fnc_CargarAutocompleteProductos()
        fnc_CargarDataTableListadoBoletas();

        fnc_CargarDataTableListadoProductos();


        //Datos del Comprobante
        $("#tipo_comprobante").attr("readonly", true);
        // $("#serie").val('')
        // $("#correlativo").val('')
        // $("#moneda").val('')

        //Datos del Cliente
        // $("#tipo_documento").val('')
        $("#nro_documento").val('')
        $("#nombre_cliente_razon_social").val('')
        $("#direccion").val('')
        $("#telefono").val('')

        //Datos de la Venta
        $("#forma_pago").attr("readonly", true);
        $("#producto").val('')

        $("#totalVenta").html('')
        $("#totalVenta").html('S/ 0.00')
        // $("#forma_pago").val('')
        $("#total_recibido").val('')
        $("#vuelto").val('')

        //Datos del Resumen
        $("#resumen_opes_gravadas").html('S/ 0.00')
        $("#resumen_opes_inafectas").html('S/ 0.00')
        $("#resumen_opes_exoneradas").html('S/ 0.00')
        $("#resumen_subtotal").html('S/ 0.00')
        $("#resumen_total_igv").html('S/ 0.00')
        $("#resumen_total_venta").html('S/ 0.00')

        $(".needs-validation-venta").removeClass("was-validated");
    }

    /*===================================================================*/
    // C A R G A R   D R O P D O W N'S
    /*===================================================================*/
    function CargarSelects() {

        // EMPRESA EMISORA
        CargarSelect(1, $("#empresa_emisora"), "--Seleccionar--", "ajax/empresas.ajax.php", 'obtener_empresas_select');

        // TIPO DE COMPROBANTE
        CargarSelect('03', $("#tipo_comprobante"), "--Seleccionar--", "ajax/series.ajax.php", 'obtener_tipo_comprobante');

        // SERIE DEL COMPROBANTE
        CargarSelect(null, $("#serie"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_serie_comprobante', $('#tipo_comprobante option:selected').val());
        $("#serie").prop('selectedIndex', 1).change();

        //MONEDA
        CargarSelect('PEN', $("#moneda"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_moneda');

        //TIPO DE DOCUMENTO
        CargarSelect('0', $("#tipo_documento"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_tipo_documento');

        //FORMA DE PAGO
        CargarSelect('1', $("#forma_pago"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_forma_pago');

        //TIPO DE OPERACION
        CargarSelect('0101', $("#tipo_operacion"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_tipo_operacion');
    }

    /*===================================================================*/
    // P L U G I N   D A T E T I M E P I C K E R
    /*===================================================================*/
    function fnc_CargarPluginDateTime() {
        $('#fecha_emision').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.lang('es', {
                months: 'Enero_Febrero_Marzo_Abril_Mayo_Junio_Julio_Agosto_Septiembre_Octubre_Noviembre_Diciembre'
                    .split('_'),
                monthsShort: 'Enero._Feb._Mar_Abr._May_Jun_Jul._Ago_Sept._Oct._Nov._Dec.'.split(
                    '_'),
                weekdays: 'Domingo_Lunes_Martes_Miercoles_Jueves_Viernes_Sabado'.split('_'),
                weekdaysShort: 'Dom._Lun._Mar._Mier._Jue._Vier._Sab.'.split('_'),
                weekdaysMin: 'Do_Lu_Ma_Mi_Ju_Vi_Sa'.split('_')
            }),
            defaultDate: moment(),
        });
    }

    /*===================================================================*/
    // O B T E N E R   C O R R E L A T I V O
    /*===================================================================*/
    function fnc_ObtenerCorrelativo(id_serie) {
        var formData = new FormData();
        formData.append('accion', 'obtener_correlativo_serie');
        formData.append('id_serie', id_serie);

        response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);
        $("#correlativo").val(response["correlativo"])
    }

    /*===================================================================*/
    //A U T O C O M P L E T E   D E   P R O D U C T O S
    /*===================================================================*/
    function fnc_CargarAutocompleteProductos() {

        $("#producto").autocomplete({
            source: "ajax/autocomplete_productos.ajax.php",
            minLength: 2,
            autoFocus: true,
            select: function(event, ui) {
                CargarProductos(ui.item.id);
                $("#producto").val('');
                $("#producto").focus();
                return false;
            },
            response: function(event, ui) {

                if (!ui.content.length) {
                    var noResult = {
                        value: "",
                        label: '<a href="javascript:void(0);" class="d-flex border border-secondary border-left-0 border-right-0 border-top-0" style="width:100% !important;">' +
                            '<div class=""> ' +
                            '<span class="text-sm fw-bold">No existen datos</span>' +
                            '</div>' +
                            '</a>'
                    };
                    ui.content.push(noResult);
                }
            }
        }).data("ui-autocomplete")._renderItem = function(ul, item) {
            return $("<li class='ui-autocomplete-row'></li>")
                .data("item.autocomplete", item)
                .append(item.label)
                .appendTo(ul);
        };

    }

    /*===================================================================*/
    // C A R G A R   D A T A T A B L E   D E   P R O D U C T O S   A   V E N D ER
    /*===================================================================*/
    function fnc_CargarDataTableListadoProductos() {

        if ($.fn.DataTable.isDataTable('#tbl_ListadoProductos')) {
            $('#tbl_ListadoProductos').DataTable().destroy();
            $('#tbl_ListadoProductos tbody').empty();
        }

        $('#tbl_ListadoProductos').DataTable({
            searching: false,
            paging: false,
            info: false,
            "columns": [{
                    "data": "id"
                },
                {
                    "data": "codigo_producto"
                },
                {
                    "data": "descripcion"
                },
                {
                    "data": "id_tipo_igv"
                },
                {
                    "data": "tipo_igv"
                },
                {
                    "data": "unidad_medida"
                },
                {
                    "data": "precio"
                },
                {
                    "data": "cantidad"
                },
                {
                    "data": "cantidad_final"
                },
                {
                    "data": "subtotal"
                },
                {
                    "data": "igv"
                },
                {
                    "data": "importe"
                },
                {
                    "data": "acciones"
                }
            ],
            columnDefs: [{
                targets: [0, 1, 3, 4, 5, 8],
                visible: false
            }],
            scrollX: true,
            // autoWidth: true,
            scrollY: "50vh",
            "order": [
                [0, 'desc']
            ],
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });

    }

    /*===================================================================*/
    // C A R G A R   P R O D U C T O S   E N   E L   D A T A T A B L E
    /*===================================================================*/
    function CargarProductos(producto = "") {

        var codigo_producto;

        if (producto != "") codigo_producto = producto;
        else codigo_producto = $("#iptCodigoVenta").val();

        var producto_repetido = 0;

        /*===================================================================*/
        // AUMENTAMOS LA CANTIDAD SI EL PRODUCTO YA EXISTE EN EL LISTADO
        /*===================================================================*/
        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);
            var data = row.data();

            if (codigo_producto == data['codigo_producto']) {

                producto_repetido = 1;

                cantidad_a_comprar = parseFloat($.parseHTML(data['cantidad'])[0]['value']) + 1;

                $.ajax({
                    async: false,
                    url: "ajax/productos.ajax.php",
                    method: "POST",
                    data: {
                        'accion': 'verificar_stock',
                        'codigo_producto': codigo_producto,
                        'cantidad_a_comprar': cantidad_a_comprar
                    },
                    dataType: 'json',
                    success: function(respuesta) {

                        if (parseInt(respuesta['stock']) < cantidad_a_comprar) {

                            mensajeToast('error', ' El producto ' + data['descripcion'] + ' no tiene el stock ingresado, el stock actual es: ' + respuesta.stock);

                            $("#producto").val("");
                            $("#producto").focus();

                        } else {

                            $precio = $('#tbl_ListadoProductos').DataTable().cell(index, 6).data()
                            $id_tipo_afectacion = $('#tbl_ListadoProductos').DataTable().cell(index, 3)
                                .data()

                            let $subtotal = 0;
                            let $factor_igv = 0;
                            let $porcentaje_igv = 0;
                            let $igv = 0;
                            let $importe = 0;

                            // ACTUALIZAR CANTIDAD A 1
                            $('#tbl_ListadoProductos').DataTable().cell(index, 7).data(`<input  type="number" min="0"
                                                                    style="width:80px;" 
                                                                    codigoProducto = "` + codigo_producto + `" 
                                                                    class="form-control text-center iptCantidad m-0 p-0" 
                                                                    value="` + cantidad_a_comprar + `">`).draw();

                            $('#tbl_ListadoProductos').DataTable().cell(index, 8).data(
                                cantidad_a_comprar)

                            //ACTUALIZAR SUBTOTAL
                            $subtotal = $precio * cantidad_a_comprar;
                            $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat(
                                $subtotal).toFixed(2)).draw();

                            //ACTUALIZAR IGV
                            if ($id_tipo_afectacion == 10) {
                                $factor_igv = 1.18;
                                $porcentaje_igv = 0.18;
                                $igv = ($precio * cantidad_a_comprar *
                                    $porcentaje_igv); // * EL % DE IGV = 0.18

                            } else {
                                $igv = 0
                                $factor_igv = 1;
                            }



                            $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($igv)
                                .toFixed(2)).draw();

                            //ACTUALIZAR IMPORTE
                            $importe = ($precio * cantidad_a_comprar) *
                                $factor_igv; // * EL FACTOR DE IGV = 1.18
                            $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat(
                                $importe).toFixed(2)).draw();

                            // RECALCULAMOS TOTALES
                            recalcularTotales();

                        }
                    }
                });

            }
        });

        if (producto_repetido == 1) {
            return;
        }

        $.ajax({
            url: "ajax/productos.ajax.php",
            method: "POST",
            data: {
                'accion': 'obtener_producto_x_codigo', //BUSCAR PRODUCTOS POR SU CODIGO DE BARRAS
                'codigo_producto': codigo_producto
            },
            dataType: 'json',
            success: function(respuesta) {

                /*===================================================================*/
                //SI LA RESPUESTA ES VERDADERO, TRAE ALGUN DATO
                /*===================================================================*/
                if (respuesta) {

                    var TotalVenta = 0.00;

                    $('#tbl_ListadoProductos').DataTable().row.add({
                        'id': itemProducto,
                        'codigo_producto': respuesta['codigo_producto'],
                        'descripcion': respuesta['descripcion'],
                        'id_tipo_igv': respuesta['id_tipo_afectacion_igv'],
                        'tipo_igv': respuesta['tipo_afectacion_igv'],
                        'unidad_medida': respuesta['unidad_medida'],
                        'precio': parseFloat(respuesta['precio_unitario_sin_igv']).toFixed(2),
                        'cantidad': '<input type="number" style="width:80px;" codigoProducto = "' +
                            respuesta['codigo_producto'] +
                            '" class="form-control text-center iptCantidad p-0 m-0" value="1">',
                        'cantidad_final': 1,
                        'subtotal': parseFloat(respuesta['precio_unitario_sin_igv'] * 1).toFixed(2),
                        'igv': parseFloat((respuesta['precio_unitario_sin_igv'] * 1 * respuesta[
                            'porcentaje_igv'])).toFixed(2),
                        'importe': parseFloat((respuesta['precio_unitario_sin_igv'] * 1) * respuesta[
                            'factor_igv']).toFixed(2),
                        'acciones': "<center>" +
                            "<span class='btnEliminarproducto text-danger px-1'style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar producto'> " +
                            "<i class='fas fa-trash fs-5'> </i> " +
                            "</span>" +
                            "<div class='btn-group'>" +
                            "<button type='button' class=' p-0 btn btn-primary transparentbar dropdown-toggle btn-sm' data-bs-toggle='dropdown' aria-expanded='false'>" +
                            "<i class='fas fa-hand-holding-usd fs-5 text-green'></i> <i class='fas fa-chevron-down text-primary'></i>" +
                            "</button>" +

                            "<ul class='dropdown-menu'>" +

                            "<li><a class='dropdown-item' codigo = '" + respuesta['codigo_producto'] +
                            "' precio=' " + respuesta['precio_unitario_sin_igv'] +
                            "' style='cursor:pointer; font-size:14px;'>Normal (" + parseFloat(respuesta[
                                'precio_unitario_sin_igv']).toFixed(2) + ")</a></li>" +

                            "<li><a class='dropdown-item' codigo = '" + respuesta['codigo_producto'] +
                            "' precio=' " + respuesta['precio_unitario_mayor_sin_igv'] +
                            "' style='cursor:pointer; font-size:14px;'>Por Mayor (S./ " + parseFloat(
                                respuesta['precio_unitario_mayor_sin_igv']).toFixed(2) + ")</a></li>" +

                            "<li><a class='dropdown-item' codigo = '" + respuesta['codigo_producto'] +
                            "' precio=' " + respuesta['precio_unitario_oferta_sin_igv'] +
                            "' style='cursor:pointer; font-size:14px;'>Oferta (S./ " + parseFloat(
                                respuesta['precio_unitario_oferta_sin_igv']).toFixed(2) + ")</a></li>" +

                            "</ul>" +
                            "</div>" +
                            "</center>"
                    }).draw();

                    itemProducto = itemProducto + 1;
                    //  Recalculamos el total de la venta
                    recalcularTotales();

                    /*===================================================================*/
                    //SI LA RESPUESTA ES FALSO, NO TRAE ALGUN DATO
                    /*===================================================================*/
                } else {
                    mensajeToast('error', 'EL PRODUCTO NO EXISTE O NO TIENE STOCK');
                }

            }
        });

        $("#producto").val("");
        $("#producto").focus();

    }

    function recalcularMontos(codigo_producto, precio_venta) {

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);

            var data = row.data();


            if (data['codigo_producto'] == codigo_producto) {

                // AUMENTAR EN 1 EL VALOR DE LA CANTIDAD
                $('#tbl_ListadoProductos').DataTable().cell(index, 6).data(parseFloat(precio_venta).toFixed(2))
                    .draw();

                //OBTENER PRECIO DEL PRODUCTO
                $precio = $('#tbl_ListadoProductos').DataTable().cell(index, 6).data();
                $id_tipo_afectacion = $('#tbl_ListadoProductos').DataTable().cell(index, 3).data();

                let $subtotal = 0;
                let $factor_igv = 0;
                let $porcentaje_igv = 0;
                let $igv = 0;
                let $importe = 0;

                cantidad_actual = parseFloat($.parseHTML(data['cantidad'])[0]['value']);

                //CALCULAR SUBTOTAL
                $subtotal = $precio * cantidad_actual
                $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat($subtotal).toFixed(2)).draw();

                //CALCULAR IGV
                if ($id_tipo_afectacion == 10) {
                    $factor_igv = 1.18;
                    $porcentaje_igv = 0.18;
                    $igv = ($precio * cantidad_actual * $porcentaje_igv); // * EL % DE IGV = 0.18

                } else {
                    $igv = 0
                    $factor_igv = 1;
                }
                $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($igv).toFixed(2)).draw();

                //CALCULAR IMPORTE
                $importe = ($precio * cantidad_actual) * $factor_igv; // * EL FACTOR DE IGV = 1.18
                $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat($importe).toFixed(2)).draw();

            }

            // RECALCULAMOS TOTALES
            recalcularTotales();


        });

        // RECALCULAMOS TOTALES
        recalcularTotales();

    }

    /*===================================================================*/
    //R E C A L C U L A R   L O S   T O T A L E S  D E   V E N T A
    /*===================================================================*/
    function recalcularTotales() {

        let TotalVenta = 0.00;
        let total_opes_gravadas = 0.00;
        let total_opes_exoneradas = 0.00;
        let total_opes_inafectas = 0.00;
        let subtotal = 0.00;
        let total_igv = 0.00;
        let factor_igv = 1;

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);
            var data = row.data();

            factor_igv = 1;

            if (data['id_tipo_igv'] == 10) {
                total_opes_gravadas = total_opes_gravadas + (data['precio'] * data['cantidad_final']);
                total_igv = total_igv + (data['precio'] * data['cantidad_final'] * 0.18)
                factor_igv = 1.18
            }

            if (data['id_tipo_igv'] == 20) {
                total_opes_exoneradas = total_opes_exoneradas + (data['precio'] * data['cantidad_final']);
            }

            if (data['id_tipo_igv'] == 30) {
                total_opes_inafectas = total_opes_inafectas + (data['precio'] * data['cantidad_final']);
            }


            TotalVenta = TotalVenta + (data['precio'] * data['cantidad_final'] * factor_igv)

        });

        subtotal = subtotal + (total_opes_gravadas + total_opes_exoneradas + total_opes_inafectas);

        $("#totalVenta").html('')
        $("#totalVenta").html('S/ ' + TotalVenta.toFixed(2));

        $("#resumen_opes_gravadas").html('S/ ' + parseFloat(total_opes_gravadas).toFixed(2));
        $("#resumen_opes_inafectas").html('S/ ' + parseFloat(total_opes_inafectas).toFixed(2));
        $("#resumen_opes_exoneradas").html('S/ ' + parseFloat(total_opes_exoneradas).toFixed(2));
        $("#resumen_subtotal").html('S/ ' + parseFloat(subtotal).toFixed(2));
        $("#resumen_total_igv").html('S/ ' + parseFloat(total_igv).toFixed(2));
        $("#resumen_total_venta").html('S/ ' + parseFloat(TotalVenta).toFixed(2));

        $("#total_recibido").val(parseFloat(TotalVenta).toFixed(2))
        $("#vuelto").val(0.00)

    }

    /*===================================================================*/
    //G U A R D A R   V E N T A
    /*===================================================================*/
    function fnc_GuardarVenta() {

        let count = 0;
        form_comprobante_validate = validarFormulario('needs-validation-venta');

        //INICIO DE LAS VALIDACIONES
        if (!form_comprobante_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        if ($("#tipo_documento").val() != "0" && ($("#nro_documento").val() == "" ||
                $("#nombre_cliente_razon_social").val() == "" ||
                $("#direccion").val() == "")) {
            mensajeToast("error", "Debe completar el Nombre y la Dirección del Cliente");
            return;
        }

        if ($("#totalVenta").html().replace('S/ ', '') > 700) {

            if ($("#tipo_documento").val() == "0") {
                mensajeToast("error", "Para montos mayores a 700, se debe identificar al cliente!");
                return;
            }

        }

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {
            count = count + 1;
        });

        if (count == 0) {
            mensajeToast("error", "Ingrese los productos para la venta");
            return;
        }

        if ($("#total_recibido").val() == "") {
            mensajeToast("error", "Ingrese el Total recibido");
            return;
        }

        if (!fnc_ValidarStock()) {
            return;
        }
        //FIN DE LAS VALIDACIONES

        Swal.fire({
            title: 'Está seguro(a) de registrar la Venta?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                detalle_productos = $("#tbl_ListadoProductos").DataTable().rows().data().toArray();

                var formData = new FormData();
                formData.append('accion', 'registrar_venta');
                formData.append('datos_venta', $("#frm-datos-venta").serialize());
                formData.append('id_caja', $("#id_caja").val());
                formData.append('arr_detalle_productos', JSON.stringify(detalle_productos));

                response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);
                console.log("🚀 ~ file: venta_boleta.php:1480 ~ fnc_GuardarVenta ~ response:", response)

                if ($("input[name='rb_generar_venta']:checked").val() == 1) {
                    Swal.fire({
                        position: 'top-center',
                        icon: response.tipo_msj,
                        title: response.msj,
                        showConfirmButton: true
                    })
                } else {
                    Swal.fire({
                        position: 'top-center',
                        icon: response.tipo_msj,
                        title: response.msj,
                        showConfirmButton: true
                    })
                }

                window.open('https://tutorialesphperu.com/pos//vistas/generar_ticket.php?id_venta=' +
                    response["id_venta"],
                    "ModalPopUp",
                    "toolbar=no," +
                    "scrollbars=no," +
                    "location=no," +
                    "statusbar=no," +
                    "menubar=no," +
                    "resizable=0," +
                    "width=400," +
                    "height=600," +
                    "left = 450," +
                    "top=200");

                fnc_InicializarFormulario();

            }

        })
    }

    /*===================================================================*/
    // V A L I D A R   S T O C K   A N T E S   D E  G U A R D A R   V E N T A
    /*===================================================================*/
    function fnc_ValidarStock() {

        let stock_valido = true;

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            $(this).addClass('bg-danger')

            var row = $('#tbl_ListadoProductos').DataTable().row(index);

            var data = row.data();

            var datos = new FormData();
            datos.append('accion', 'verificar_stock');
            datos.append('codigo_producto', data["codigo_producto"]);
            datos.append('cantidad_a_comprar', data["cantidad_final"]);

            response = SolicitudAjax('ajax/productos.ajax.php', 'POST', datos);

            if (response.stock < parseInt(data["cantidad_final"])) {
                mensajeToast("error", "El producto " + data["descripcion"] + " no tiene el stock ingresado, el stock actual es: " + response.stock)
                $('#tbl_ListadoProductos').DataTable().cell(index, 7)
                    .data(`<input  type="number" min="0"
                            style="width:80px;background-color:#D98880" 
                            codigoProducto = "` + cod_producto_actual + `" 
                            class="form-control text-center iptCantidad m-0 p-0" 
                            value="` + data["cantidad_final"] + `">`).draw();
                stock_valido = false;

            }

        });

        return stock_valido;
    }

    /*===================================================================*/
    //GENERALES
    /*===================================================================*/
    function fnc_ConsultarNroDocumento(nro_documento) {

        var formData = new FormData();
        let accion = '';

        if ($("#tipo_documento").val() == 1) {
            accion = 'consultar_dni';
        } else if ($("#tipo_documento").val() == 6) {
            accion = 'consultar_ruc';
        }

        formData.append('accion', accion);
        formData.append('nro_documento', nro_documento);

        response = SolicitudAjax('ajax/apis/apis.ajax.php', 'POST', formData);
        // $("#nro_documento").val('')
        $("#nombre_cliente_razon_social").val('')
        $("#direccion").val('')
        $("#telefono").val('')

        if (response["existe"]) {
            $("#nombre_cliente_razon_social").val(response['razonSocial']);
            $("#direccion").val(response['direccion']);
            $("#telefono").val(response['telefono']);
        } else {

            if (response) {

                if (response['message']) {

                    if (response['message'] == "not found") {
                        mensajeToast("error", 'No se encontraron datos')
                    }

                    if (response['message'] == "dni no valido") {
                        mensajeToast("error", 'El DNI ingresado no es válido')
                    }

                    if (response['message'] == "ruc no valido") {
                        mensajeToast("error", 'El RUC ingresado no es válido')
                    }

                    $("#nro_documento").val('')
                    $("#nombre_cliente_razon_social").val('')
                    $("#direccion").val('')
                    $("#telefono").val('')
                    return;
                }

                if ($("#tipo_documento").val() == 1) {
                    $("#nombre_cliente_razon_social").val(response['nombres'] + ' ' + response['apellidoPaterno'] + ' ' +
                        response['apellidoMaterno']);
                } else if ($("#tipo_documento").val() == 6) {
                    $("#nombre_cliente_razon_social").val(response['razonSocial']);
                    $("#direccion").val(response['direccion']);
                }

            }
        }

    }

    function fnc_BloquearDatosCliente(disabled) {
        $("#nro_documento").prop('disabled', disabled)
        $("#nombre_cliente_razon_social").prop('disabled', disabled)
        $("#direccion").prop('disabled', disabled)
        $("#telefono").prop('disabled', disabled)
        if (disabled == true) $(".btnConsultarDni").prop('readonly', 'true')
        else $(".btnConsultarDni").prop('readonly', 'false');

    }

    function fnc_CargarDataTableListadoBoletas() {

        if ($.fn.DataTable.isDataTable('#tbl_boletas')) {
            $('#tbl_boletas').DataTable().destroy();
            $('#tbl_boletas tbody').empty();
        }

        $("#tbl_boletas").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE BOLETAS';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/ventas.ajax.php',
                data: {
                    'accion': 'obtener_listado_boletas'
                },
                type: 'POST'
            },
            // responsive: false,
            // "info": false,
            // scrollCollapse: true,
            scrollX: true,
            // scrollY: false,
            scrollY: "63vh",
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },

                {
                    targets: [1, 4, 5, 6, 7, 9, 11, 13],
                    visible: false
                },
                {
                    targets: 9,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[9] != 1) {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        } else {
                            $(td).parent().css('background', '#D4EFDF')
                        }
                    }
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        $options = `<div class="btn-group">
                                        
                                        <button class="btn btn-sm dropdown-toggle p-0 m-0 my-text-color fs-5" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-list-alt"></i>
                                        </button>

                                        <div class="dropdown-menu z-3">
                                            <a class="dropdown-item btnImprimirBoleta" style='cursor:pointer;'><i class='px-1 fas fa-print fs-5 text-secondary'></i> <span class='my-color'>Imprimir Boleta (ticket)</span></a>`

                        if (rowData[9] == 1) {

                            $options = $options + `<a href='../fe/facturas/xml/` + rowData[11] + `' download class="dropdown-item btnDescargarXml" style='cursor:pointer;'>
                                                        <i class='px-1 fas fa-file-code fs-5 my-color'></i> <span class='my-color'> Descargar XML</span>
                                                    </a>

                                                    <a href='../fe/facturas/cdr/R-` + rowData[11] + `' download class="dropdown-item btnDescargarCdr" style='cursor:pointer;'>
                                                        <i class='px-1 fas fa-file-code fs-5 text-info'></i> <span class='my-color'>Descargar CDR</span>
                                                    </a>`;
                        }

                        if (rowData[9] == 2) {

                            $options = $options + `<a href='../fe/facturas/xml/` + rowData[11] + `' download class="dropdown-item btnDescargarXml" style='cursor:pointer;'>
                                                    <i class='px-1 fas fa-file-code fs-5 my-color'></i> <span class='my-color'> Descargar XML</span>
                                                </a>`;
                        }

                        if (rowData[9] == 1 && rowData[12] != 2) {
                            $options = $options + `<a class = "dropdown-item btnAnularBoleta" style='cursor:pointer;'> 
                                                        <i class = 'px-1 fas fa-ban fs-5 text-danger'> </i> <span class='my-color'>Anular Boleta</span> 
                                                    </a>`;
                        }

                        if (rowData[9] != 1 || rowData[12] == 0) {
                            $options = $options + `<a class = "dropdown-item btnEnviarSunat" style = 'cursor:pointer;'> 
                                                        <i class='px-1 fas fa-share-square fs-5 text-warning'> </i> <span class='my-color'>Enviar a Sunat</span > 
                                                    </a>
                                                <a class="dropdown-item btnEditarComprobante" style = 'cursor:pointer;'> 
                                                    <i class='px-1 fas fa-pencil-alt fs-5 text-primary'></i><span class='my-color'>Editar Comprobante</span> 
                                                </a>`
                        }

                        $options = $options + `</div>
                                            </div>`;

                        $(td).html($options)

                        // $(td).html(
                        //     "<span class='btnImprimirBoleta text-success px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Imprimir Boleta (ticket)'>" +
                        //     "<i class='fas fa-print fs-5 text-secondary'></i>" +
                        //     "</span>");

                        // if (rowData[9] == 1) {
                        //     $(td).append(
                        //         "<a href='../fe/facturas/xml/" + rowData[11] +
                        //         "' download class='btnDescargarXml text-warning px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Descargar Xml'>" +
                        //         "<i class='fas fa-file-code fs-5 text-info'></i>" +
                        //         "</a>" +
                        //         "<a href='../fe/facturas/cdr/R-" + rowData[11] +
                        //         "' download class='btnDescargarCdr text-warning px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Descargar CDR'>" +
                        //         "<i class='fas fa-file-code fs-5 text-primary'></i>" +
                        //         "</a>")
                        // }

                        // if (rowData[9] == 1 && rowData[12] != 2) {
                        //     $(td).append(
                        //         "<span class='btnAnularBoleta px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Anular Boleta'>" +
                        //         "<i class='fas fa-ban fs-5 text-danger'></i>" +
                        //         "</span>")
                        // }

                        // if (rowData[9] != 1 || rowData[12] == 0) {
                        //     $(td).append(
                        //         "<span class='btnEnviarSunat text-warning px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Enviar a Sunat'>" +
                        //         "<i class='fas fa-share-square fs-5 text-success'></i>" +
                        //         "</span>" +
                        //         "<span class='btnEditarComprobante text-primary px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Editar Comprobante'>" +
                        //         "<i class='fas fa-pencil-alt fs-5 text-primary'></i>" +
                        //         "</span>");
                        // }
                    }
                },
                {
                    targets: 10,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[9] == 2) {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-window-close fs-5 text-danger btnMensajeRespuestaSunat' data-bs-toggle='tooltip' data-bs-placement='top' title='" + rowData[12] + "'></i>" +
                                "</center>");
                        } else if (rowData[9] == 1) {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-check-circle fs-5 text-success btnMensajeRespuestaSunat' data-bs-toggle='tooltip' data-bs-placement='top' title='" + rowData[12] + "'></i>" +
                                "</center>");
                        } else if (rowData[9] == 3) {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-window-close fs-5 text-danger btnMensajeRespuestaSunat' data-bs-toggle='tooltip' data-bs-placement='top' title='" + rowData[12] + "'></i>" +
                                "</center>");
                        } else {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-share-square fs-5 text-warning btnMensajeRespuestaSunat'  data-bs-toggle='tooltip' data-bs-placement='top' title='Pendiente de envio'></i>" +
                                "</center>");
                        }

                    }
                },
                {
                    targets: 12,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[12] == 1) {
                            $(td).html("<center>" +
                                "<span class='rounded-pill bg-success p-1 px-3'>Registrado en Sunat</span>" +
                                "</center>");
                        } else if (rowData[12] == 2) {
                            $(td).html("<center>" +
                                "<span class='rounded-pill bg-danger p-1 px-3'>Anulado Sunat</span>" +
                                "</center>");
                        } else if (rowData[12] == 0) {
                            $(td).html("<center>" +
                                "<span class='rounded-pill bg-secondary p-1 px-3'>Pendiente de envío</span>" +
                                "</center>");
                        }

                    }
                }

            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })
    }

    function fnc_EnviarComprobanteSunat($id_venta) {

        Swal.fire({
            title: 'Está seguro(a) de enviar el comprobante a Sunat?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo enviarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'enviar_comprobante_sunat');
                formData.append('id_venta', $id_venta);

                response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                $("#tbl_boletas").DataTable().ajax.reload();

            }
        })


    }

    function fnc_ImprimirBoleta($id_venta) {
        window.open('https://tutorialesphperu.com/pos//vistas/generar_ticket.php?id_venta=' + $id_venta,
            "ModalPopUp",
            "toolbar=no," +
            "scrollbars=no," +
            "location=no," +
            "statusbar=no," +
            "menubar=no," +
            "resizable=0," +
            "width=400," +
            "height=600," +
            "left = 450," +
            "top=200");
    }

    function fnc_AnularComprobante($id_venta, $fecha_emision) {

        Swal.fire({
            title: 'Está seguro(a) de anular el Comprobantes?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo anularlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();

                formData.append('accion', 'anular_boleta');
                formData.append('fecha_emision', $("#fecha_emision").val());
                formData.append('condicion', 3);
                formData.append('id_venta', $id_venta)

                response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);
                console.log("🚀 ~ file: venta_resumen_boletas.php:328 ~ fnc_EnviarResumenComprobantes ~ response:", response)

                if (response) {
                    Swal.fire({
                        position: 'top-center',
                        icon: response.tipo_msj,
                        title: response.msj,
                        showConfirmButton: true
                    })
                } else {
                    Swal.fire({
                        position: 'top-center',
                        icon: 'error',
                        title: "Error de Conexión con Sunat",
                        showConfirmButton: true
                    })
                }

                fnc_CargarDataTableListadoBoletas()

            }
        })


    }

    function fnc_ObtenerEstadoCajaPorDia() {

        var datos = new FormData();
        datos.append('accion', 'obtener_estado_caja_por_dia');

        response = SolicitudAjax('ajax/arqueo_caja.ajax.php', 'POST', datos)
        // console.log("🚀 ~ file: venta_boleta.php:1869 ~ fnc_ObtenerEstadoCajaPorDia ~ response:", response)

        //CUANDO LA CAJA ESTA CERRADA
        if (response['cantidad'] == '0' || response['estado'] == '0') {
            Swal.fire({
                position: 'top-center',
                icon: 'warning',
                title: 'Debe aperturar la caja',
                showConfirmButton: false,
                timer: 1500
            })
            $(".nav-link").removeClass('active');
            // $(this).addClass('active');
            CargarContenido('vistas/caja.php', 'content-wrapper');

        } else {
            $("#id_caja").val(response["id"]);
        }
    }

    // function ajustarHeadersDataTables(element) {

    //     var observer = window.ResizeObserver ? new ResizeObserver(function(entries) {
    //         entries.forEach(function(entry) {
    //             $(entry.target).DataTable().columns.adjust();
    //         });
    //     }) : null;

    //     // Function to add a datatable to the ResizeObserver entries array
    //     resizeHandler = function($table) {
    //         if (observer)
    //             observer.observe($table[0]);
    //     };

    //     // Initiate additional resize handling on datatable
    //     resizeHandler(element);

    // }
</script>