<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">KARDEX x PRODUCTO</h2>
            </div><!-- /.col -->
            <div class="col-sm-6  d-none d-md-block">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Kardex x Producto</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content mb-3">

    <div class="container-fluid">

        <!-- row para criterios de busqueda -->
        <div class="row">

            <div class="col-md-12">

                <table id="tbl_kardex_x_producto" class="table shadow border border-secondary" style="width:100%">
                    <thead class="bg-main text-left">
                        <th> </th> <!-- 0 -->
                        <th>Cod. Producto</th>
                        <th>Producto</th>
                        <th>Fecha Mov.</th>
                        <th>Tipo Mov</th>
                        <th>Cantidad</th>
                        <th>Stock</th>
                    </thead>
                </table>

            </div>

        </div>

    </div>

</div>

<script>
    $(document).ready(function() {
        fnc_CargarDataTableKardexPorProducto();
    })

    function fnc_CargarDataTableKardexPorProducto() {

        if ($.fn.DataTable.isDataTable('#tbl_kardex_x_producto')) {
            $('#tbl_kardex_x_producto').DataTable().destroy();
            $('#tbl_kardex_x_producto tbody').empty();
        }

        $("#tbl_kardex_x_producto").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'KARDEX / INVENTARIO';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            "ordering": false,
            order: [],
            ajax: {
                url: 'ajax/reportes.ajax.php',
                data: {
                    'accion': 'reporte_kardex_x_producto'
                },
                type: 'POST'
            },
            scrollX: true,
            responsive: {
                details: {
                    type: 'column'
                }
            },
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },
                {
                    targets: 0,
                    orderable: false,
                    className: 'control'
                },
            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })
    }
</script>