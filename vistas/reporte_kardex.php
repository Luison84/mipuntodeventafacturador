<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">REPORTE KARDEX</h2>
            </div><!-- /.col -->
            <div class="col-sm-6  d-none d-md-block">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Reporte Kardex</li>
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

                <table id="tbl_kardex" class="table shadow border border-secondary" style="width:100%">
                    <thead class="bg-main text-left">
                        <th>Cod. Producto</th>
                        <th>Producto</th>
                        <th>Entradas</th>
                        <th>Salidas</th>
                        <th>Existencias</th>
                        <th>Costo Existencias</th>
                    </thead>
                </table>

            </div>

        </div>

    </div>

</div>

<script>
    $(document).ready(function() {
        fnc_CargarDataTableKardex();
    })

    function fnc_CargarDataTableKardex() {

        if ($.fn.DataTable.isDataTable('#tbl_kardex')) {
            $('#tbl_kardex').DataTable().destroy();
            $('#tbl_kardex tbody').empty();
        }

        $("#tbl_kardex").DataTable({
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
            order: [],
            ajax: {
                url: 'ajax/reportes.ajax.php',
                data: {
                    'accion': 'reporte_kardex'
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