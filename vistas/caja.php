<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 mb-2 fw-bold">ADMINISTRAR CAJA</h2>
                <span>Fecha Caja: <?php echo date("Y-m-d"); ?> <span class="bg-success p-1 px-3 mx-3 rounded-pill" id="estado_caja"></span></span>
            </div><!-- /.col -->
            <div class="col-sm-6 d-none d-md-block">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Reportes</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content">

    <div class="container-fluid">

        <div class="row mb-4">

            <div class="col-12 mb-3">
                <input type="hidden" name="id_caja" id="id_caja" value="0">
                <button class="btn btn-secondary float-left" id="btnAbrirCerrarCaja"></button>
                <a class="btn btn-primary float-right ml-2" id="btnImprimirArqueo">IMPRIMIR ARQUEO</a>
            </div>
            <!-- MOVIMIENTO DE CAJA -->
            <div class="col-md-6">

                <!-- MONTO APERTURA -->
                <div class="card card-gray shadow collapsed-card mb-1">

                    <div class="card-header">

                        <h3 class="card-title" id="title-header">MONTO APERTURA</h3>

                        <div class="card-tools">
                            <span class="btn btn-tool fs-4" id="importe_monto_apertura"></span>
                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body" style="display: none;">

                    </div> <!-- ./ end card-body -->

                </div>

                <!-- INGRESOS -->
                <div class="card card-success shadow collapsed-card mb-1">

                    <div class="card-header">

                        <h3 class="card-title" id="title-header">INGRESOS</h3>

                        <div class="card-tools">

                            <span class="btn btn-tool fs-4" id="importe_ingresos"></span>

                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body" style="display: none;">
                    </div> <!-- ./ end card-body -->

                </div>

                <!-- DEVOLUCIONES -->
                <div class="card card-warning shadow collapsed-card mb-1">

                    <div class="card-header">

                        <h3 class="card-title" id="title-header">DEVOLUCIONES</h3>

                        <div class="card-tools">

                            <span class="btn btn-tool fs-4" id="importe_devoluciones"></span>

                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-plus"></i>
                            </button>


                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body" style="display: none;">

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group mb-2">
                                    <input type="text" class="form-control form-control-sm" id="descripcion_devolucion" placeholder="Descripción de la Devolución">
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group mb-2">
                                    <input type="number" class="form-control form-control-sm" id="monto_devolucion" placeholder="Monto de la Devolución">
                                </div>
                            </div>

                            <div class="col-2">
                                <a class="btn btn-success btn-sm float-right" id="btnRegistrarDevolucion"><i class="fas fa-plus-circle fs-6"></i></a>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <table id="tbl_movimientos_devoluciones" class="table table-striped w-100 shadow border border-secondary">
                                    <thead class="bg-gray">
                                        <tr style="font-size: 15px;">
                                            <th> </th> <!-- 0 -->
                                            <th> id</th> <!-- 0 -->
                                            <th class="text-cetner">Descripción</th> <!-- 1 -->
                                            <th>Monto</th><!-- 2 -->
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>

                    </div> <!-- ./ end card-body -->

                </div>

                <!-- GASTOS -->
                <div class="card card-info shadow collapsed-card mb-1">

                    <div class="card-header">

                        <h3 class="card-title" id="title-header">GASTOS</h3>

                        <div class="card-tools">

                            <span class="btn btn-tool fs-4" id="importe_gastos"></span>

                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-plus"></i>
                            </button>


                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body" style="display: none;">

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group mb-2">
                                    <input type="text" class="form-control form-control-sm" id="descripcion_gasto" placeholder="Descripción del gasto">
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group mb-2">
                                    <input type="number" class="form-control form-control-sm" id="monto_gasto" placeholder="Monto del gasto">
                                </div>
                            </div>

                            <div class="col-2">
                                <a class="btn btn-success btn-sm float-right" id="btnRegistrarGasto"><i class="fas fa-plus-circle fs-6"></i></a>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <table id="tbl_movimientos_gastos" class="table table-striped w-100 shadow border border-secondary">
                                    <thead class="bg-gray">
                                        <tr style="font-size: 15px;">
                                            <th> id</th> <!-- 0 -->
                                            <th class="text-cetner">Descripción</th> <!-- 1 -->
                                            <th>Monto</th><!-- 2 -->
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>

                    </div> <!-- ./ end card-body -->

                </div>

                <div class="row">
                    <div class="col-md-12 px-3 text-success fs-5 fw-bold">
                        <span>INGRESOS</span>
                        <span class="float-right" id="importe_ingreso_total"></span>
                    </div>

                    <div class="col-md-12 px-3 text-danger fs-5 fw-bold">
                        <span>EGRESOS <sub>(DEVOLUCIONES + GASTOS)</sub></span>
                        <span class="float-right" id="importe_egreso_total"></span>
                    </div>

                    <div class="col-md-12 px-3 text-secondary fs-5 fw-bold">
                        <span>SALDO <sub>(INGRESOS - EGRESOS)</sub></span>
                        <span class="float-right" id="importe_saldo_total"></span>
                    </div>

                    <div class="col-md-12 px-3 text-info fs-5 fw-bold">
                        <span>MONTO FINAL <sub>(MONTO APERTURA + SALDO)</sub></span>
                        <span class="float-right" id="importe_monto_apertura_saldo_total"></span>
                    </div>
                </div>

            </div>

            <!-- GRAFICO DE DOUGHNUT -->
            <div class="col-md-6">

                <div class="row">
                    <div class="col-12" style="border: 1px solid #34495e;">
                        <div class="chart w-100">
                            <div id="chartContainerCaja" style="min-height: 250px; height: 300px; max-height: 350px; width: 100%;">
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="row pt-3 pb-3">

            <div class="col-12">

                <table id="tbl_arqueo_caja" class="table table-striped w-100 shadow border border-secondary">
                    <thead class="bg-gray">
                        <tr style="font-size: 15px;">
                            <th class="text-cetner"></th> <!-- 10 -->
                            <th>ID</th> <!-- 2 -->
                            <th>Usuario</th> <!-- 3 -->
                            <th>Fec. Apertura</th> <!-- 4 -->
                            <th>Fec. Cierre</th> <!-- 5 -->
                            <th>Monto Apertura</th> <!-- 6 -->
                            <th>Ingresos</th> <!-- 7 -->
                            <th>Devoluciones</th> <!-- 8 -->
                            <th>Gastos</th> <!-- 9 -->
                            <th>Monto Final</th> <!-- 10 -->
                            <th>Estado</th> <!-- 11 -->
                        </tr>
                    </thead>
                    <tbody class="text-small">
                    </tbody>
                </table>

            </div>

        </div>

    </div>

</div>

<!-- =============================================================================================================================
M O D A L   M O N T O   A P E R T U R A
===============================================================================================================================-->
<div class="modal fade" id="mdlMontoApertura" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <form id="frm-datos-apertura" class="needs-validation-apertura" novalidate>

            <div class="modal-content">

                <!-- cabecera del modal -->
                <div class="modal-header my-bg py-1">

                    <h5 class="modal-title text-white text-lg">Aperturar Caja</h5>

                    <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                        <i class="fas fa-times text-sm m-0 p-0"></i>
                    </button>

                </div>

                <div class="modal-body">

                    <div class="row">

                        <div class="col-12 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Monto Apertura</label>
                            <input type="number" min="0" step="0.01" placeholder="Ingrese el monto de apertura" class="form-control form-control-sm" id="monto_apertura" name="monto_apertura" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                            <div class="invalid-feedback">Ingrese monto de apertura</div>
                        </div>

                    </div>

                </div>

                <div class="modal-footer">

                    <a class="btn btn-sm btn-danger  fw-bold " id="btnCancelarApertura" style="position: relative; width: 160px;" data-bs-dismiss="modal">
                        <span class="text-button">CANCELAR</span>
                        <span class="btn fw-bold icon-btn-danger ">
                            <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                        </span>
                    </a>

                    <a class="btn btn-sm btn-success  fw-bold " id="btnAperturarCaja" style="position: relative; width: 160px;">
                        <span class="text-button">APERTURAR</span>
                        <span class="btn fw-bold icon-btn-success ">
                            <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                        </span>
                    </a>
                </div>

            </div>

        </form>

    </div>
</div>
<!-- /. End -->

<!-- =============================================================================================================================
M O D A L   C I E R R E   D E   C A J A
===============================================================================================================================-->
<div class="modal fade" id="mdlCerrarCaja" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">.modal('show')

    <div class="modal-dialog modal-dialog-centered modal-lg">

        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header my-bg py-1">

                <h5 class="modal-title text-white text-lg">Cierre de Caja</h5>

                <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times text-sm m-0 p-0"></i>
                </button>

            </div>

            <div class="modal-body">

                <div class="row">

                    <div class="col-6 mb-2">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Monto Efectivo Real</label>
                        <input type="number" min="0" step="0.01" placeholder="Ingrese el monto de apertura" class="form-control form-control-sm" id="monto_efectivo_real" name="monto_efectivo_real" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                        <div class="invalid-feedback">Ingrese el monto de efectivo</div>
                    </div>

                    <div class="col-6 mb-2">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Monto Efectivo Caja</label>
                        <input type="number" min="0" step="0.01" placeholder="Ingrese el monto de apertura" class="form-control form-control-sm" id="monto_efectivo_caja" name="monto_efectivo_caja" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                    </div>

                    <div class="col-6 mb-2">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Sobrante</label>
                        <input type="number" placeholder="Ingrese el monto de apertura" class="form-control form-control-sm" id="sobrante" name="sobrante" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                    </div>

                    <div class="col-6 mb-2">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Faltante</label>
                        <input type="number" placeholder="Ingrese el monto de apertura" class="form-control form-control-sm" id="faltante" name="faltante" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                    </div>

                </div>

            </div>

            <div class="modal-footer">

                <a class="btn btn-sm btn-danger  fw-bold " id="btnCancelarCierreCaja" style="position: relative; width: 160px;">
                    <span class="text-button">CANCELAR</span>
                    <span class="btn fw-bold icon-btn-danger ">
                        <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                    </span>
                </a>

                <a class="btn btn-sm btn-success  fw-bold " id="btnGuardarCierreCaja" style="position: relative; width: 160px;">
                    <span class="text-button">CERRAR CAJA</span>
                    <span class="btn fw-bold icon-btn-success ">
                        <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                    </span>
                </a>
            </div>

        </div>

    </div>
</div>
<!-- /. End -->

<div class="loading">Loading</div>



<script>
    $(document).ready(function() {

        fnc_MostrarLoader()

        fnc_ObtenerEstadoCajaPorDia();
        fnc_CargarDataTableArqueosCaja();
        fnc_CargarDataTableDevoluciones();
        // fnc_CargarTableditDevoluciones();
        fnc_CargarDataTableGastos();
        // fnc_CargarTableditGastos();

        $("#btnAbrirCerrarCaja").on('click', function() {

            if ($("#btnAbrirCerrarCaja").attr('estado-caja') == 1) {
                fnc_CerrarCaja($("#btnAbrirCerrarCaja").attr('id-caja'), 0)
            } else {
                fnc_AbrirCaja()
            }
        })

        $("#btnRegistrarDevolucion").on('click', function() {
            fnc_RegistrarDevolucion();
        })

        $("#btnRegistrarGasto").on('click', function() {
            fnc_RegistrarGasto();
        })

        $("#btnAperturarCaja").on('click', function() {
            fnc_AperturarCaja();
        })

        $("#btnImprimirArqueo").on('click', function() {
            fnc_ImprimirArqueo($("#btnAbrirCerrarCaja").attr('id-caja'));
        })

        $('#tbl_arqueo_caja tbody').on('click', '.btnCerrarCaja', function() {
            var data = $("#tbl_arqueo_caja").DataTable().row($(this).parents('tr')).data();
            fnc_CerrarCaja(data["id"], data['monto_final'])
        })

        // $("#monto_apertura").keypress(function(e) {
        //     var key = e.keyCode;
        //     if (key == 13) {
        //         fnc_AperturarCaja();
        //         e.preventDefault();
        //     }

        // });

        $("#monto_efectivo_real").keyup(function(e) {
            let $sobrante = 0;
            let $faltante = 0;

            let $efectivo_real = parseFloat($("#monto_efectivo_real").val()).toFixed(2);
            let $efectivo_caja = parseFloat($("#monto_efectivo_caja").val());

            $sobrante = $efectivo_real - $efectivo_caja;
            $("#sobrante").val($sobrante.toFixed(2))

            $faltante = $efectivo_caja - $efectivo_real;
            $("#faltante").val($faltante.toFixed(2))

            if (parseFloat($sobrante) < 0) {
                $("#sobrante").val(0.00)
            }

            if (parseFloat($faltante) < 0) {
                $("#faltante").val(0.00)
            }

        })

        $("#btnGuardarCierreCaja").on('click', function() {

            if ($("#monto_efectivo_real").val() == "" || $("#monto_efectivo_real").val() == "0") {
                mensajeToast("error", "El monto real de efectivo debe ser mayor a 0");
                return;
            }

            Swal.fire({
                title: 'Está seguro de cerrar la caja?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Si, deseo cerrar la caja!',
                cancelButtonText: 'Cancelar',
            }).then((result) => {

                if (result.isConfirmed) {

                    var formData = new FormData();
                    formData.append('accion', 'cerrar_caja')
                    formData.append('id_caja', $("#id_caja").val() > 0 ? $("#id_caja").val() : $("#btnAbrirCerrarCaja").attr('id-caja'));
                    formData.append('ingresos', $("#importe_ingresos").html().replace($("#btnAbrirCerrarCaja").attr('simbolo-moneda'), ''));
                    formData.append('devoluciones', $("#importe_devoluciones").html().replace($("#btnAbrirCerrarCaja").attr('simbolo-moneda'), ''));
                    formData.append('gastos', $("#importe_gastos").html().replace($("#btnAbrirCerrarCaja").attr('simbolo-moneda'), ''));
                    formData.append('monto_final', $("#importe_monto_apertura_saldo_total").html().replace($("#btnAbrirCerrarCaja").attr('simbolo-moneda'), ''));
                    formData.append('monto_real', parseFloat($("#monto_efectivo_real").val()));
                    formData.append('sobrante', parseFloat($("#sobrante").val()));
                    formData.append('faltante', parseFloat($("#faltante").val()));

                    response = SolicitudAjax("ajax/arqueo_caja.ajax.php", "POST", formData);

                    $("#mdlCerrarCaja").modal('hide')
                    $("#monto_efectivo_real").val('')
                    $("#sobrante").val('')
                    $("#faltante").val('')
                    $("#monto_efectivo_caja").val('')

                    Swal.fire({
                        position: 'top-center',
                        icon: response.tipo_msj,
                        title: response.msj,
                        showConfirmButton: true
                    })

                    $("#id_caja").val(0)
                    fnc_ObtenerEstadoCajaPorDia();
                    fnc_CargarDataTableArqueosCaja();

                }
            })
        })

        $("#btnCancelarCierreCaja").on('click', function() {
            $("#mdlCerrarCaja").modal('hide')
        })

        $('#mdlCerrarCaja').on('hidden.bs.modal', function(e) {
            $("#monto_efectivo_real").val('')
        })

        $('#mdlMontoApertura').on('hidden.bs.modal', function(e) {
            $("#monto_apertura").val('')
            $(".needs-validation-apertura").removeClass("was-validated");
        })

        fnc_OcultarLoader();

    })

    function fnc_MostrarLoader() {
        $(".loading").removeClass('d-none');
        $(".loading").addClass('d-block');
    }

    function fnc_OcultarLoader() {
        $(".loading").removeClass('d-block');
        $(".loading").addClass('d-none')
    }

    function fnc_ObtenerEstadoCajaPorDia() {

        var datos = new FormData();
        datos.append('accion', 'obtener_estado_caja_por_dia');

        response = SolicitudAjax('ajax/arqueo_caja.ajax.php', 'POST', datos)

        //CUANDO LA CAJA ESTA ABIERTA
        if (response['estado'] == '1') {

            //COLOCAR LOS MONTOS DE LOS MOVIMIENTOS DEL DIA Y MOSTRAR BOTON CERRAR CAJA
            $("#estado_caja").html('CAJA ABIERTA')
            $("#estado_caja").removeClass('bg-secondary');
            $("#estado_caja").addClass('bg-success');

            $("#btnAbrirCerrarCaja").html('CERRAR CAJA');
            $("#btnAbrirCerrarCaja").removeClass('bg-success');
            $("#btnAbrirCerrarCaja").addClass('bg-secondary');
            $("#btnAbrirCerrarCaja").attr('estado-caja', 1)
            $("#btnAbrirCerrarCaja").attr('id-caja', response['id'])
            $("#btnAbrirCerrarCaja").attr('simbolo-moneda', response['simbolo_moneda'])

            $("#btnImprimirArqueo").removeClass('d-none')
            $("#btnImprimirArqueo").addClass('d-block')


            let monto_apertura = parseFloat(response['monto_apertura']);
            let ingresos = parseFloat(response['ingresos']);
            let devoluciones = parseFloat(response['devoluciones']);
            let gastos = parseFloat(response['gastos']);
            let ingreso_total = ingresos;
            let egreso_total = parseFloat(response['devoluciones']) + parseFloat(response['gastos']);
            let saldo_total = ingreso_total - egreso_total;
            let monto_apertura_saldo_total = monto_apertura + saldo_total;

            $("#importe_monto_apertura").html(response['simbolo_moneda'] + monto_apertura.toFixed(2).toString())
            $("#importe_ingresos").html(response['simbolo_moneda'] + ingresos.toFixed(2).toString())
            $("#importe_devoluciones").html(response['simbolo_moneda'] + devoluciones.toFixed(2).toString())
            $("#importe_gastos").html(response['simbolo_moneda'] + gastos.toFixed(2).toString())

            $("#importe_ingreso_total").html(response['simbolo_moneda'] + ingreso_total.toFixed(2).toString())
            $("#importe_egreso_total").html(response['simbolo_moneda'] + egreso_total.toFixed(2).toString())
            $("#importe_saldo_total").html(response['simbolo_moneda'] + saldo_total.toFixed(2).toString())
            $("#importe_monto_apertura_saldo_total").html(response['simbolo_moneda'] + monto_apertura_saldo_total.toFixed(2).toString())

            fnc_CargarGraficoDoughnut(response['id']);


            //CUANDO LA CAJA ESTA CERRADA
        } else {

            //COLOCAR LOS MONTOS EN 0 Y MOSTRAR BOTON APERTURAR CAJA
            $("#estado_caja").html('CAJA CERRADA')
            $("#estado_caja").removeClass('bg-success');
            $("#estado_caja").addClass('bg-secondary');

            $("#btnAbrirCerrarCaja").html('APERTURAR CAJA');
            $("#btnAbrirCerrarCaja").removeClass('bg-secondary');
            $("#btnAbrirCerrarCaja").addClass('bg-success');
            $("#btnAbrirCerrarCaja").attr('estado-caja', 0)
            $("#btnAbrirCerrarCaja").attr('id-caja', response['id'])

            $("#btnImprimirArqueo").removeClass('d-block')
            $("#btnImprimirArqueo").addClass('d-none')

            $("#importe_monto_apertura").html(response['simbolo_moneda'] + '0.00')
            $("#importe_ingresos").html(response['simbolo_moneda'] + '0.00')
            $("#importe_devoluciones").html(response['simbolo_moneda'] + '0.00')
            $("#importe_gastos").html(response['simbolo_moneda'] + '0.00')
            $("#importe_ingreso_total").html(response['simbolo_moneda'] + '0.00')
            $("#importe_egreso_total").html(response['simbolo_moneda'] + '0.00')
            $("#importe_saldo_total").html(response['simbolo_moneda'] + '0.00')
            $("#importe_monto_apertura_saldo_total").html(response['simbolo_moneda'] + '0.00')

            $("#chartContainerCaja").html('');

        }
    }

    function fnc_CargarDataTableArqueosCaja() {

        if ($.fn.DataTable.isDataTable('#tbl_arqueo_caja')) {
            $('#tbl_arqueo_caja').DataTable().destroy();
            $('#tbl_arqueo_caja tbody').empty();
        }

        $("#tbl_arqueo_caja").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            ajax: {
                url: "ajax/arqueo_caja.ajax.php",
                dataSrc: '',
                type: "POST",
                data: {
                    'accion': 'listar_arqueos_por_usuario' //1: LISTAR PRODUCTOS
                },
            },
            responsive: {
                details: {
                    type: 'column'
                }
            },
            columnDefs: [{
                    targets: 0,
                    createdCell: function(td, cellData, rowData, row, col) {
                        $(td).html("<span class='btnMostrarDetalleArqueo text-primary px-1' style='cursor:pointer;'  data-bs-toggle='tooltip' data-bs-placement='top' title='Ver Arqueo'>" +
                            "<i class='fas fa-eye fs-5'></i>" +
                            "</span>")

                        if (rowData["estado"] == "CAJA ABIERTA") {
                            $(td).append("<span class='btnCerrarCaja text-danger px-1' style='cursor:pointer;'  data-bs-toggle='tooltip' data-bs-placement='top' title='Cerrar Caja'>" +
                                "<i class='fas fa-ban fs-5'></i>" +
                                "</span>")
                        }
                    }
                },
                {
                    targets: 10,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[10] == 'CAJA ABIERTA') {
                            $(td).html('<span class="bg-success px-2 py-1 rounded "> ' + rowData[10] + ' </span>')
                        } else {
                            $(td).html('<span class="bg-secondary px-2 py-1 rounded "> ' + rowData[10] + ' </span>')
                        }
                    }
                },
                // {
                //     targets: 1,
                //     orderable: false,
                //     createdCell: function(td, cellData, rowData, row, col) {

                //         if (parseInt(rowData[17]) == 0) {
                //             $(td).html("<span class='btnEditarProducto text-primary px-1' style='cursor:pointer;'>" +
                //                 "<i class='fas fa-pencil-alt fs-5'></i>" +
                //                 "</span>" +
                //                 "<span class='btnAumentarStock text-success px-1' style='cursor:pointer;'>" +
                //                 "<i class='fas fa-plus-circle fs-5'></i>" +
                //                 "</span>" +
                //                 "<span class='btnDisminuirStock text-warning px-1' style='cursor:pointer;'>" +
                //                 "<i class='fas fa-minus-circle fs-5'></i>" +
                //                 "</span>" +
                //                 "<span class='btnActivarProducto text-danger px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Activar Producto'>" +
                //                 "<i class='fas fa-toggle-off fs-5 text-danger'> </i> " +
                //                 "</span>")
                //         } else {
                //             $(td).html("<span class='btnEditarProducto text-primary px-1' style='cursor:pointer;'>" +
                //                 "<i class='fas fa-pencil-alt fs-5'></i>" +
                //                 "</span>" +
                //                 "<span class='btnAumentarStock text-success px-1' style='cursor:pointer;'>" +
                //                 "<i class='fas fa-plus-circle fs-5'></i>" +
                //                 "</span>" +
                //                 "<span class='btnDisminuirStock text-warning px-1' style='cursor:pointer;'>" +
                //                 "<i class='fas fa-minus-circle fs-5'></i>" +
                //                 "</span>" +
                //                 "<span class='btnDesactivarProducto text-danger px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Desactivar Producto'>" +
                //                 "<i class='fas fa-toggle-on fs-5 text-success'> </i> " +
                //                 "</span>")
                //         }
                //     }
                // }

            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });

    }


    /* =======================================================
    SOLICITUD AJAX GRAFICO DE DOUGHNUT
    =======================================================*/
    function fnc_CargarGraficoDoughnut($id_caja) {

        $.ajax({
            url: "ajax/arqueo_caja.ajax.php",
            method: 'POST',
            data: {
                'accion': 'obtener_movimientos_arqueo_caja_por_usuario', //parametro para obtener las ventas del mes
                'id_caja': $id_caja
            },
            dataType: 'json',
            success: function(respuesta) {

                var chart = new CanvasJS.Chart("chartContainerCaja", {
                    animationEnabled: true,
                    // title:{
                    //     text: "Email Categories",
                    //     horizontalAlign: "left"
                    // },
                    data: [{
                        type: "doughnut",
                        startAngle: 60,
                        //innerRadius: 60,
                        indexLabelFontSize: 17,
                        indexLabel: "{label} - #percent%",
                        toolTipContent: "<b>{label}:</b> {y} (#percent%)",
                        dataPoints: respuesta
                    }]
                });
                chart.render();

            }
        });


    }

    function fnc_CerrarCaja(id_caja, monto_real) {

        $("#mdlCerrarCaja").modal('show')
        $("#id_caja").val(id_caja);
        if (monto_real && monto_real > 0) {
            $("#monto_efectivo_caja").val(monto_real);
        } else {
            $("#monto_efectivo_caja").val(parseFloat($("#importe_monto_apertura_saldo_total").html().replace('S/', '')).toFixed(2));
        }


    }

    function fnc_AbrirCaja() {
        $("#mdlMontoApertura").modal('show');
    }

    function fnc_AperturarCaja() {

        let form_apertura_validate = validarFormulario('needs-validation-apertura');

        //INICIO DE LAS VALIDACIONES
        if (!form_apertura_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro de abrir la caja?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo abrir la caja!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'abrir_caja')
                formData.append('id_caja', $("#btnAbrirCerrarCaja").attr('id-caja'))
                formData.append('monto_apertura', $("#monto_apertura").val())

                response = SolicitudAjax("ajax/arqueo_caja.ajax.php", "POST", formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                $("#mdlMontoApertura").modal('hide');
                $("#monto_apertura").val('')


                fnc_ObtenerEstadoCajaPorDia();
                fnc_CargarDataTableArqueosCaja();
                $(".needs-validation-apertura").removeClass("was-validated");

            }
        })

    }

    function fnc_CargarDataTableDevoluciones() {

        if ($.fn.DataTable.isDataTable('#tbl_movimientos_devoluciones')) {
            $('#tbl_movimientos_devoluciones').DataTable().destroy();
            $('#tbl_movimientos_devoluciones tbody').empty();
        }

        $("#tbl_movimientos_devoluciones").DataTable({
            bFilter: false,
            bPaginate: false,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/arqueo_caja.ajax.php',
                data: {
                    'id_arqueo_caja': $("#btnAbrirCerrarCaja").attr('id-caja'),
                    'accion': 'obtener_devoluciones'
                },
                type: 'POST'
            },
            autoWidth: true,
            scrollX: true,
            columnDefs: [{
                targets: 0,
                orderable: false,
                createdCell: function(td, cellData, rowData, row, col) {

                    $(td).html(`<center> 
                                    <span class='btnEliminarDevolucion px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar Devolución'> 
                                        <i class='fas fa-trash fs-5 text-danger'></i>
                                    </span>
                                </center>`);

                }

            }, ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        ajustarHeadersDataTables($("#tbl_movimientos_devoluciones"));



    }

    // function fnc_CargarTableditDevoluciones() {
    //     $("#tbl_movimientos_devoluciones").on('draw.dt', function() {
    //         $("#tbl_movimientos_devoluciones").Tabledit({
    //             url: 'action.php?id_caja=' + $("#btnAbrirCerrarCaja").attr('id-caja'),
    //             dataType: 'json',
    //             columns: {
    //                 identifier: [0, 'id'],
    //                 editable: [
    //                     [1, 'descripcion'],
    //                     [2, "monto"]
    //                 ]
    //             },
    //             restoreButton: false,
    //             buttons: {
    //                 edit: {
    //                     class: 'btn btn-sm m-0 p-0',
    //                     html: '<i class="fas fa-edit text-primary"></i>',
    //                     action: 'edit'
    //                 },
    //                 delete: {
    //                     class: 'btn btn-sm mx-1 p-0',
    //                     html: '<i class="fas fa-trash text-danger"></i>',
    //                     action: 'delete'
    //                 },
    //                 save: {
    //                     class: 'btn btn-sm btn-success p-0 px-1 rounded-pill',
    //                     html: '<i class="fas fa-check "></i>'
    //                 },
    //                 restore: {
    //                     class: 'btn btn-sm btn-warning',
    //                     html: 'Restore',
    //                     action: 'restore'
    //                 },
    //                 confirm: {
    //                     class: 'btn btn-sm btn-danger p-0 px-1 rounded-pill',
    //                     html: '<i class="fas fa-check "></i>'
    //                 }
    //             },
    //             onSuccess: function(data, textStatus, jqXHR) {
    //                 // if(data.action == "delete"){
    //                 //     $("#"+data.id).remove();
    //                 //     $("#tbl_movimientos_devoluciones").DataTable().ajax.reload;
    //                 // }
    //                 if (data.action == "edit") {
    //                     alert("entro")
    //                     mensajeToast("success", "Se actualizó la Devolución")
    //                     fnc_ObtenerEstadoCajaPorDia();
    //                     $("#tbl_movimientos_devoluciones").DataTable().ajax.reload();
    //                     $("#tbl_arqueo_caja").DataTable().ajax.reload();
    //                 }

    //                 if (data.action == "delete") {
    //                     mensajeToast("success", "Se eliminó la Devolución")
    //                     fnc_ObtenerEstadoCajaPorDia();
    //                     $("#tbl_movimientos_devoluciones").DataTable().ajax.reload();
    //                     $("#tbl_arqueo_caja").DataTable().ajax.reload();
    //                 }
    //             }
    //         })
    //     })
    // }

    function fnc_CargarDataTableGastos() {

        if ($.fn.DataTable.isDataTable('#tbl_movimientos_gastos')) {
            $('#tbl_movimientos_gastos').DataTable().destroy();
            $('#tbl_movimientos_gastos tbody').empty();
        }

        $("#tbl_movimientos_gastos").DataTable({
            bFilter: false,
            bPaginate: false,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/arqueo_caja.ajax.php',
                data: {
                    'id_arqueo_caja': $("#btnAbrirCerrarCaja").attr('id-caja'),
                    'accion': 'obtener_gastos'
                },
                type: 'POST'
            },
            autoWidth: true,
            scrollX: true,
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        ajustarHeadersDataTables($("#tbl_movimientos_gastos"));

    }

    // function fnc_CargarTableditGastos() {
    //     $("#tbl_movimientos_gastos").on('draw.dt', function() {
    //         $("#tbl_movimientos_gastos").Tabledit({
    //             url: 'ajax/actions_editable/actions_gastos.php?id_caja=' + $("#btnAbrirCerrarCaja").attr('id-caja'),
    //             dataType: 'json',
    //             columns: {
    //                 identifier: [0, 'id'],
    //                 editable: [
    //                     [1, 'descripcion'],
    //                     [2, "monto"]
    //                 ]
    //             },
    //             restoreButton: false,
    //             buttons: {
    //                 edit: {
    //                     class: 'btn btn-sm m-0 p-0',
    //                     html: '<i class="fas fa-edit text-primary"></i>',
    //                     action: 'edit'
    //                 },
    //                 delete: {
    //                     class: 'btn btn-sm mx-1 p-0',
    //                     html: '<i class="fas fa-trash text-danger"></i>',
    //                     action: 'delete'
    //                 },
    //                 save: {
    //                     class: 'btn btn-sm btn-success p-0 px-1 rounded-pill',
    //                     html: '<i class="fas fa-check "></i>'
    //                 },
    //                 restore: {
    //                     class: 'btn btn-sm btn-warning',
    //                     html: 'Restore',
    //                     action: 'restore'
    //                 },
    //                 confirm: {
    //                     class: 'btn btn-sm btn-danger p-0 px-1 rounded-pill',
    //                     html: '<i class="fas fa-check "></i>'
    //                 }
    //             },
    //             onSuccess: function(data, textStatus, jqXHR) {

    //                 if (data.action == "edit") {
    //                     alert("entro")
    //                     mensajeToast("success", "Se actualizó el Gasto")
    //                     fnc_ObtenerEstadoCajaPorDia();
    //                     $("#tbl_movimientos_gastos").DataTable().ajax.reload();
    //                     $("#tbl_arqueo_caja").DataTable().ajax.reload();
    //                 }

    //                 if (data.action == "delete") {
    //                     mensajeToast("success", "Se eliminó el Gasto")
    //                     fnc_ObtenerEstadoCajaPorDia();
    //                     $("#tbl_movimientos_gastos").DataTable().ajax.reload();
    //                     $("#tbl_arqueo_caja").DataTable().ajax.reload();
    //                 }
    //             }
    //         })
    //     })
    // }

    function fnc_RegistrarDevolucion() {

        if ($("#descripcion_devolucion").val() == '' || $("#monto_devolucion").val() == '') {
            mensajeToast('warning', 'Complete la descripcion y monto de la Devolución')
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de registrar la Devolución?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'registrar_devolucion_caja');
                formData.append('id_arqueo_caja', $("#btnAbrirCerrarCaja").attr('id-caja'));
                formData.append('descripcion_devolucion', $("#descripcion_devolucion").val());
                formData.append('monto_devolucion', $("#monto_devolucion").val());

                response = SolicitudAjax('ajax/arqueo_caja.ajax.php', 'POST', formData);
                mensajeToast(response['tipo_msj'], response['msj'])
                fnc_ObtenerEstadoCajaPorDia();
                $("#tbl_movimientos_devoluciones").DataTable().ajax.reload();
                $("#tbl_arqueo_caja").DataTable().ajax.reload();

                $("#descripcion_devolucion").val('');
                $("#monto_devolucion").val('');

            }
        })


    }

    function fnc_RegistrarGasto() {

        if ($("#descripcion_gasto").val() == '' || $("#monto_gasto").val() == '') {
            mensajeToast('warning', 'Complete la descripción y monto del Gasto')
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de registrar el Gasto?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'registrar_gasto_caja');
                formData.append('id_arqueo_caja', $("#btnAbrirCerrarCaja").attr('id-caja'));
                formData.append('descripcion_gasto', $("#descripcion_gasto").val());
                formData.append('monto_gasto', $("#monto_gasto").val());

                response = SolicitudAjax('ajax/arqueo_caja.ajax.php', 'POST', formData);
                mensajeToast(response['tipo_msj'], response['msj'])
                fnc_ObtenerEstadoCajaPorDia();
                $("#tbl_movimientos_gastos").DataTable().ajax.reload();
                $("#tbl_arqueo_caja").DataTable().ajax.reload();

                $("#descripcion_gasto").val('');
                $("#monto_gasto").val('');

            }
        })


    }

    function ajustarHeadersDataTables(element) {

        var observer = window.ResizeObserver ? new ResizeObserver(function(entries) {
            entries.forEach(function(entry) {
                $(entry.target).DataTable().columns.adjust();
            });
        }) : null;

        // Function to add a datatable to the ResizeObserver entries array
        resizeHandler = function($table) {
            if (observer)
                observer.observe($table[0]);
        };

        // Initiate additional resize handling on datatable
        resizeHandler(element);

    }

    function fnc_ImprimirArqueo($id_arqueo_caja) {


        window.open('https://tutorialesphperu.com/pos//vistas/imprimir_arqueo.php?id_arqueo_caja=' + $id_arqueo_caja,
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
</script>