<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-md-6">
                <h2 class="m-0">Adminsitrar Ventas</h2>
            </div>
            <div class="col-md-6">
                <ol class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item">Ventas</li>
                    <li class="breadcrumb-item active">Administrar Ventas</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<div class="content pb-2">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card card-gray shadow">
                    <div class="card-header">
                        <h3 class="card-title">Criterios de Busqueda</h3>
                        <div class="card-tools"><button class="btn btn-tool" type="button" data-card-widget="collapse"><i class="fas fa-minus"></i></button></div>
                    </div>
                    <div class="card-body">
                        <div class="row">

                            <!-- FECHA DESDE -->
                            <div class="col-12 col-md-3 mb-2">
                                <label class="mb-0 ml-1 text-sm my-text-color">
                                    <i class="fas fa-calendar-alt mr-1 my-text-color"></i> Desde
                                </label>
                                <div class="input-group input-group-sm mb-3 ">
                                    <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_desde">
                                        <i class="fas fa-calendar-alt ml-1 text-white"></i>
                                    </span>
                                    <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_desde" name="fecha_desde" aria-describedby="inputGroup-sizing-sm" required>
                                    <div class="invalid-feedback">Ingrese Fecha de Emisión</div>
                                </div>
                            </div>


                            <!-- FECHA HASTA -->
                            <div class="col-12 col-md-3 mb-2">
                                <label class="mb-0 ml-1 text-sm my-text-color">
                                    <i class="fas fa-calendar-alt mr-1 my-text-color"></i> Hasta
                                </label>
                                <div class="input-group input-group-sm mb-3 ">
                                    <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_hasta">
                                        <i class="fas fa-calendar-alt ml-1 text-white"></i>
                                    </span>
                                    <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_hasta" name="fecha_hasta" aria-describedby="inputGroup-sizing-sm" required>
                                    <div class="invalid-feedback">Ingrese Fecha de Emisión</div>
                                </div>
                            </div>

                            <div class="col-md-6 d-flex flex-row align-items-center justify-content-end">
                                <a class="btn btn-sm btn-success fw-bold w-25" id="btnFiltrar" style="position: relative;">
                                    <span class="text-button">BUSCAR</span>
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
        
        <div class="row">
            <div class="col-md-12">
                <table class="display nowrap table-striped w-100 shadow" id="lstVentas">
                    <thead class="bg-gray">
                        <tr>
                            <th>Nro Boleta</th>
                            <th>Codigo Barras</th>
                            <th>Categoria</th>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Total Venta</th>
                            <th>Fecha Venta</th>
                        </tr>
                    </thead>
                    <tbody class="small"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {

        var table, ventas_desde, ventas_hasta;
        var groupColumn = 0;

        $('#ventas_desde, #ventas_hasta').inputmask('dd/mm/yyyy', {
            'placeholder': 'dd/mm/yyyy'
        })

        $("#ventas_desde").val(moment().startOf('month').format('DD/MM/YYYY'));
        $("#ventas_hasta").val(moment().format('DD/MM/YYYY'));

        ventas_desde = $("#ventas_desde").val();
        ventas_hasta = $("#ventas_hasta").val();

        ventas_desde = ventas_desde.substr(6, 4) + '-' + ventas_desde.substr(3, 2) + '-' + ventas_desde.substr(0, 2);
        ventas_hasta = ventas_hasta.substr(6, 4) + '-' + ventas_hasta.substr(3, 2) + '-' + ventas_hasta.substr(0, 2);

        table = $('#lstVentas').DataTable({
            "columnDefs": [{
                    visible: false,
                    targets: groupColumn
                },
                {
                    targets: [1, 2, 3, 4, 5],
                    orderable: false
                }
            ],
            "order": [
                [6, 'desc']
            ],
            dom: 'Bfrtip',
            buttons: [
                'excel', 'print', 'pageLength',

            ],
            lengthMenu: [0, 5, 10, 15, 20, 50],
            "pageLength": 15,
            ajax: {
                url: 'ajax/ventas.ajax.php',
                type: 'POST',
                dataType: 'json',
                "dataSrc": "",
                data: {
                    'accion': 2,
                    'fechaDesde': ventas_desde,
                    'fechaHasta': ventas_hasta
                }
            },
            drawCallback: function(settings) {

                var api = this.api();
                var rows = api.rows({
                    page: 'current'
                }).nodes();
                var last = null;

                api.column(groupColumn, {
                    page: 'current'
                }).data().each(function(group, i) {

                    if (last !== group) {

                        const data = group.split("-");
                        var nroBoleta = data[0];
                        nroBoleta = nroBoleta.split(":")[1].trim();

                        $(rows).eq(i).before(
                            '<tr class="group">' +
                            '<td colspan="6" class="fs-6 fw-bold fst-italic bg-success text-white"> ' +
                            '<i nroBoleta = ' + nroBoleta + ' class="fas fa-trash fs-6 text-danger mx-2 btnEliminarVenta" style="cursor:pointer;"></i> ' +
                            group +
                            '</td>' +
                            '</tr>'
                        );

                        last = group;
                    }
                });
            },
            language: {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });


    })
</script>