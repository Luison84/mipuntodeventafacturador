<!-- Content Header (Page header) -->
<div class="content-header pb-1">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">RESUMEN DE COMPROBANTES</h2>

            </div><!-- /.col -->

            <div class="col-sm-6">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>

                    <li class="breadcrumb-item active">Ventas / Resumen de Comprobantes</li>

                </ol>

            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container-fluid -->

</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content mb-3">

    <!-- row para criterios de busqueda -->
    <div class="row">

        <div class="col-lg-12">

            <div class="card card-gray shadow ">
                <div class="card-header">
                    <h3 class="card-title">CRITERIOS DE BÚSQUEDA</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool text-warning" id="btnLimpiarBusqueda">
                            <i class="fas fa-times"></i>
                        </button>
                    </div> <!-- ./ end card-tools -->
                </div> <!-- ./ end card-header -->
                <div class="card-body py-2">

                    <div class="row">

                        <div class="col-12 col-lg-6 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-building mr-1 my-text-color"></i> Empresa Emisora</label>
                            <select class="form-select" id="empresa_emisora" name="empresa_emisora" aria-label="Floating label select example" required>
                            </select>
                        </div>

                        <div class="col-12 col-lg-2 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-calendar-alt mr-1 my-text-color"></i> Fecha Emisión</label>
                            <div class="input-group input-group-sm mb-3 ">
                                <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_emision"><i class="fas fa-calendar-alt ml-1 text-white"></i></span>
                                <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_emision" name="fecha_emision" aria-describedby="inputGroup-sizing-sm">
                            </div>
                        </div>

                        <div class="col-12 col-lg-2">
                            <a class="btn btn-sm btn-success fw-bold mt-4 w-100" id="btnBuscarComprobantes" style="position: relative;">
                                <span class="text-button">BUSCAR</span>
                                <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                    <i class="fas fa-search fs-5 text-white m-0 p-0"></i>
                                </span>
                            </a>

                        </div>

                        <div class="col-12 col-lg-2">
                            <a class="btn btn-sm btn-info fw-bold mt-4 float-right mx-2 w-100" id="btnEnviarResumen" style="position: relative;">
                                <span class="text-button">ENVIAR RESUMEN</span>
                                <span class="btn fw-bold  icon-btn-custom d-flex align-items-center">
                                    <i class="fas fa-share fs-5 text-white m-0 p-0"></i>
                                </span>
                            </a>

                        </div>

                    </div>

                    <div class="row mt-4">

                        <!--LISTADO DE BOLETAS -->
                        <div class="col-md-12">
                            <table id="tbl_boletas" class="table shadow border border-secondary" style="width:100%">
                                <thead class="bg-main text-left">
                                    <!-- 1, 4, 5, 6, 7, 9, 11], -->
                                    <!-- <th></th>  -->
                                    <!-- <th></th> -->
                                    <th><input type="checkbox" name="select_all" value="1" id="example-select-all" ckass="checkbox-resumenes"></th>
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
                                </thead>
                            </table>
                        </div>

                    </div>
                </div> <!-- ./ end card-body -->
            </div>

        </div>

    </div>


</div>

<script>
    $(document).ready(function() {
        fnc_InicializarFormulario();

        $("#btnBuscarComprobantes").on('click', function() {
            fnc_CargarDataTableListadoBoletas();
        })

        $('#example-select-all').on('click', function() {
            // Get all rows with search applied
            var rows = $("#tbl_boletas").DataTable().rows({
                'search': 'applied'
            }).nodes();
            // Check/uncheck checkboxes for all rows in the table
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        $('#tbl_boletas tbody').on('change', 'input[type="checkbox"]', function() {
            // If checkbox is not checked
            if (!this.checked) {
                var el = $('#example-select-all').get(0);
                // If "Select all" control is checked and has 'indeterminate' property
                if (el && el.checked && ('indeterminate' in el)) {
                    // Set visual state of "Select all" control
                    // as 'indeterminate'
                    el.indeterminate = true;
                }
            }
        });


        $("#btnEnviarResumen").on('click', function() {
            fnc_EnviarResumenComprobantes(1);
        })

        $("#btnAnularComprobantes").on('click', function() {
            fnc_EnviarResumenComprobantes(3);
        })

    })

    /*===================================================================*/
    // C A R G A R   D R O P D O W N'S
    /*===================================================================*/
    function CargarSelects() {
        CargarSelect(1, $("#empresa_emisora"), "--Seleccionar--", "ajax/empresas.ajax.php", 'obtener_empresas_select');
    }

    function fnc_InicializarFormulario() {
        fnc_CargarPluginDateTime();
        fnc_CargarDataTableListadoBoletas();
        CargarSelects();
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

    function fnc_CargarDataTableListadoBoletas() {

        if ($.fn.DataTable.isDataTable('#tbl_boletas')) {
            $('#tbl_boletas').DataTable().destroy();
            $('#tbl_boletas tbody').empty();
        }

        $("#tbl_boletas").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/ventas.ajax.php',
                data: {
                    'accion': 'obtener_listado_boletas_x_fecha',
                    'fecha_emision': $("#fecha_emision").val()
                },
                type: 'POST'
            },
            "autoWidth": true,
            scrollX: true,

            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },

                {
                    targets: [3, 4, 5, 6, 8, 10],
                    visible: false
                },
                // {
                //     targets: 9,
                //     createdCell: function(td, cellData, rowData, row, col) {

                //         if (rowData[9] != 1) {
                //             $(td).parent().css('background', '#F2D7D5')
                //             $(td).parent().css('color', 'black')
                //         } else {
                //             $(td).parent().css('background', '#D4EFDF')
                //         }
                //     }
                // },
                {
                    'targets': 0,
                    'searchable': false,
                    'orderable': false,
                    'className': 'dt-body-center',
                    'render': function(data, type, full, meta) {
                        return '<input type="checkbox" class="checkbox-resumenes" name="id[]" value="' + $('<div/>').text(data).html() + '">';
                    }
                },
                {
                    targets: 9,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[8] == 2) {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-window-close fs-5 text-danger' data-bs-toggle='tooltip' data-bs-placement='top' title='Enviado a Sunat con Error'></i>" +
                                "</center>");
                        } else if (rowData[8] == 1) {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-check-circle fs-5 text-success' data-bs-toggle='tooltip' data-bs-placement='top' title='Enviado a Sunat correctamente'></i>" +
                                "</center>");
                        } else {
                            $(td).html("<center>" +
                                "<i style='cursor:pointer;' class='fas fa-share-square fs-5 text-warning'  data-bs-toggle='tooltip' data-bs-placement='top' title='Pendiente de envio'></i>" +
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

    function fnc_EnviarResumenComprobantes($condicion) {

        let items_seleccionados = 0;

        $("#tbl_boletas").DataTable().$('input[type="checkbox"]').each(function() {

            if (this.checked) {
                items_seleccionados = items_seleccionados + 1;
            }

        })

        if (items_seleccionados == 0) {

            msj = $condicion == 1 ? 'Seleccione los comprobantes a registrar' : 'Seleccione los comprobantes a anular';

            Swal.fire({
                position: 'top-center',
                icon: 'error',
                title: msj,
                showConfirmButton: true
            })

            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de enviar el Resumen de Comprobantes a Sunat?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo enviarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();

                formData.append('accion', 'enviar_resumen_comprobantes');
                formData.append('fecha_emision', $("#fecha_emision").val());
                formData.append('condicion', $condicion);
                formData.append('empresa_emisora', $("#empresa_emisora").val())
                formData.append('ventas', $("#tbl_boletas").DataTable().$('input[type="checkbox"]').serialize())

                response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);

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


                fnc_CargarDataTableListadoBoletas();

                var rows = $("#tbl_boletas").DataTable().rows({
                    'search': 'applied'
                }).nodes();
                // Check/uncheck checkboxes for all rows in the table
                $('input[type="checkbox"]', rows).prop('checked', this.checked);

                // If checkbox is not checked
                if (!this.checked) {
                    var el = $('#example-select-all').get(0);
                    // If "Select all" control is checked and has 'indeterminate' property
                    if (el && el.checked && ('indeterminate' in el)) {
                        // Set visual state of "Select all" control
                        // as 'indeterminate'
                        el.indeterminate = true;
                    }
                }

            }
        })


    }

</script>