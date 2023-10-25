<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">REPORTE VENTAS POR CATEGORIA</h2>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Reporte Ventas por Categoría</li>
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

                <table id="tbl_ventas_categorias" class="table shadow border border-secondary" style="width:100%">
                    <thead class="bg-main text-left">
                        <th>Categoría</th>
                        <th>Cantidad</th>
                        <th>Precio Venta</th>
                        <th>Total Venta</th>
                        <th>Ganancias</th>
                    </thead>
                </table>

            </div>

        </div>

    </div>

</div>

<script>
    $(document).ready(function() {
        fnc_CargarDataTableVentasCategoria();
    })

    function fnc_CargarDataTableVentasCategoria() {

        if ($.fn.DataTable.isDataTable('#tbl_ventas_categorias')) {
            $('#tbl_ventas_categorias').DataTable().destroy();
            $('#tbl_ventas_categorias tbody').empty();
        }

        $("#tbl_ventas_categorias").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'REPORTE VENTAS POR CATEGORIA';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/reportes.ajax.php',
                data: {
                    'accion': 'reporte_ventas_por_categoria'
                },
                type: 'POST'
            },
            scrollX: true,
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },
            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })
    }
</script>