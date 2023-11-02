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

                    <div class="col-lg-4">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Importe a pagar</label>
                        <input type="text" class="form-control form-control-sm" id="importe_a_pagar" name="importe_a_pagar" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                    </div>

                    <div class="col-lg-8 text-right col-lg-8 text-right d-flex align-items-end justify-content-end">
                        <a class="btn btn-sm btn-success  fw-bold w-25" id="" style="position: relative;">
                            <span class="text-button">PAGAR</span>
                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                            </span>
                        </a>
                    </div>


                </div>

                <div class="row mt-3">

                    <!--LISTADO DE PRODUCTOS COMPRADOS -->
                    <div class="col-md-12">
                        <table id="tbl_cuotas_factura" class="table w-100 shadow border border-secondary">
                            <thead class="bg-main text-left">
                                <th></th>
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
        fnc_CargarDataTableCuotas(data["1"])
    }

    function fnc_CargarDataTableCuotas($id_venta) {

        if ($.fn.DataTable.isDataTable('#tbl_cuotas_factura')) {
            $('#tbl_cuotas_factura').DataTable().destroy();
            $('#tbl_cuotas_factura tbody').empty();
        }

        $("#tbl_cuotas_factura").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            ajax: {
                url: 'ajax/ventas.ajax.php',
                dataSrc: '',
                data: {
                    'accion': 'obtener_cuotas_x_id_venta',
                    'id_venta': $id_venta
                },
                type: 'POST'
            },
            scrollX: true,
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },
                {
                    targets: [1],
                    visible: false
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        $(td).html(`<center> 
                                        <span class='btnIngresarImporte px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Ingresar Importe'> 
                                            <i class='fas fa-money-bill-alt fs-5 text-success'></i>
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
</script>