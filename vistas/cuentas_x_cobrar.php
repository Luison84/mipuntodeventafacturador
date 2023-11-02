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

<script>
    $(document).ready(function() {
        fnc_CargarDataTableFacturasPorCobrar();
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
            columnDefs: [
                {
                "className": "dt-center",
                "targets": "_all"
                }, 
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                       
                        $(td).html(`<center> 
                                        <span class='btnPagarCuotas px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Pagar Cuotas'> 
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