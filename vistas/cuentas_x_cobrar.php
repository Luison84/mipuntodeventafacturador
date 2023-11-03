<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">Cuentas por Cobrar</h2>
            </div><!-- /.col -->
            <div class="col-sm-6 d-none d-md-block">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="/pos">Inicio</a></li>
                    <li class="breadcrumb-item active">Cuentas x Cobrar</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div><!-- /.content-header -->

<!-- Main content -->
<div class="content mb-3">
    <div class="container-fluid">
        <!-- row para criterios de busqueda -->
        <div class="row">
            <div class="col-md-12">
                <table id="tbl_facturas_x_cobrar" class="table shadow border border-secondary" style="width:100%">
                    <thead class="bg-main text-left">
                        <th></th>
                        <th>Venta N°</th>
                        <th>Comprobante</th>
                        <th>Fecha Emisión</th>
                        <th>Total</th>
                        <th>Nro Cuotas</th>
                        <th>Cuotas Pagadas</th>
                        <th>Saldo Pendiente</th>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- =============================================================================================================================
MODAL MOSTRAR DETALLE DE CUOTAS
===============================================================================================================================-->
<div class="modal fade" id="mdlCuotas" role="dialog" tabindex="-1">

    <div class="modal-dialog modal-xl" role="document">

        <!-- contenido del modal -->
        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header my-bg py-1">

                <h5 class="modal-title text-white text-lg">Detalle de Cuotas</h5>

                <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times text-sm m-0 p-0"></i>
                </button>

            </div>

            <!-- cuerpo del modal -->
            <div class="modal-body">

                <div class="row">

                    <input type="hidden" name="id_venta" id="id_venta" value="0">
                    <div class="col-lg-3">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-money-bill-alt mr-1 my-text-color"></i>Importe a pagar</label>
                        <input type="text" class="form-control form-control-sm" id="importe_a_pagar" name="importe_a_pagar" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                    </div>

                    <div class="col-lg-3">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-money-bill-alt mr-1 my-text-color"></i>Saldo Pendiente</label>
                        <input type="text" class="form-control form-control-sm" id="saldo_pendiente" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                    </div>


                    <div class="col-lg-6 text-right d-flex align-items-end justify-content-end">
                        <a class="btn btn-sm btn-success  fw-bold w-25" id="btnPagar" style="position: relative;">
                            <span class="text-button">PAGAR</span>
                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                            </span>
                        </a>
                        <a class="btn btn-sm btn-success  fw-bold w-25" id="btnCalcular" style="position: relative;">
                            <span class="text-button">CALCULAR</span>
                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                            </span>
                        </a>
                    </div>


                </div>

                <div class="row mt-3">

                    <!--LISTADO DE CUOTAS DE LA FACTURA SELECCIONADA -->
                    <div class="col-md-12">
                        <table id="tbl_cuotas_factura" class="table w-100 shadow border border-secondary">
                            <thead class="bg-main text-left">
                                <th>Id Cuota</th>
                                <th>Cuota</th>
                                <th>Importe</th>
                                <th>Importe Pagado</th>
                                <th>Saldo Pendiente</th>
                                <th>Cuota Pagada?</th>
                                <th>Fecha Vencimiento</th>
                            </thead>
                        </table>
                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

<script>
    $(document).ready(function() {
        fnc_CargarDataTableFacturasPorCobrar();

        $('#tbl_facturas_x_cobrar tbody').on('click', '.btnPagarCuotas', function() {
            fnc_MostrarListadoCuotas($("#tbl_facturas_x_cobrar").DataTable().row($(this).parents('tr')).data());

        });

        $("#btnPagar").on('click', function() {
            if (!$("#importe_a_pagar").val()) {
                mensajeToast("error", "Ingrese el monto a pagar");
                return;
            }

            fnc_Pagar();

        });

        $('#mdlCuotas').on('hidden.bs.modal', function(e) {
            fnc_CargarDataTableFacturasPorCobrar();
            $("#id_venta").val(0);

            $("#importe_a_pagar").val('')
            $("#saldo_pendiente").val('')
        })

        $("#btnCalcular").on('click', function() {
            fnc_CalcularSaldoPendiente();
        });

    })

    function fnc_CargarDataTableFacturasPorCobrar() {

        if ($.fn.DataTable.isDataTable('#tbl_facturas_x_cobrar')) {
            $('#tbl_facturas_x_cobrar').DataTable().destroy();
            $('#tbl_facturas_x_cobrar tbody').empty();
        }

        $("#tbl_facturas_x_cobrar").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/ventas.ajax.php',
                data: {
                    'accion': 'facturas_x_cobrar'
                },
                type: 'POST'
            },
            scrollX: true,
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        $(td).html(`<center> 
                                        <span class='btnPagarCuotas px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Pagar Cuotas'> 
                                            <i class='fas fa-check-circle fs-5 my-color '></i>
                                        </span>
                                    </center>
                        `)

                    }
                }
            ],
            language: {
                url: "vistas/assets/languages/spanish.json"
            }
        })
    }

    function fnc_MostrarListadoCuotas(data) {
        $("#mdlCuotas").modal("show")
        $("#id_venta").val(data["1"]);
        fnc_CargarDataTableCuotas(data["1"])
    }

    function fnc_CargarDataTableCuotas($id_venta) {

        if ($.fn.DataTable.isDataTable('#tbl_cuotas_factura')) {
            $('#tbl_cuotas_factura').DataTable().destroy();
            $('#tbl_cuotas_factura tbody').empty();
        }

        $("#tbl_cuotas_factura").DataTable({
            dom: 'Bfrtip',
            searching: false,
            paging: false,
            buttons: ['pageLength'],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            ajax: {
                url: 'ajax/ventas.ajax.php',
                dataSrc: function(json) {
                    console.log("🚀 ~ file: cuentas_x_cobrar.php:227 ~ fnc_CargarDataTableCuotas ~ json:", json)
                    
                    return json;
                },
                data: {
                    'accion': 'obtener_cuotas_x_id_venta',
                    'id_venta': $id_venta
                },
                type: 'POST',
                async: false
            },
            scrollX: true,
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                }

            ],
            language: {
                url: "vistas/assets/languages/spanish.json"
            }
        })
    }

    function fnc_Pagar() {

        let v_saldo_pendiente = 0;

        $('#tbl_cuotas_factura').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_cuotas_factura').DataTable().row(index);
            var data = row.data();

            v_saldo_pendiente = v_saldo_pendiente + parseFloat(data["4"])
        })

        if (parseFloat($("#importe_a_pagar").val()) > parseFloat(v_saldo_pendiente)) {
            mensajeToast("error", "El importe a pagar supera el saldo pendiente");
            return;
        }


        Swal.fire({
            title: 'Está seguro(a) de realizar el Pago?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo pagarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();

                formData.append('accion', 'pagar_cuota');
                formData.append('id_venta', $("#id_venta").val());
                formData.append('monto_a_pagar', $("#importe_a_pagar").val())

                response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);

                fnc_CargarDataTableCuotas($("#id_venta").val());
                $("#importe_a_pagar").val('');
                fnc_CalcularSaldoPendiente();

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

            }
        })
    }

    function fnc_CalcularSaldoPendiente() {

        let v_saldo_pendiente = 0;


        $('#tbl_cuotas_factura').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_cuotas_factura').DataTable().row(index);
            var data = row.data();
            alert("entro")
            v_saldo_pendiente = v_saldo_pendiente + parseFloat(data["4"])
            console.log("🚀 ~ file: cuentas_x_cobrar.php:245 ~ $ ~ v_saldo_pendiente:", v_saldo_pendiente)
        })

        $("#saldo_pendiente").val(v_saldo_pendiente);
    }
</script>