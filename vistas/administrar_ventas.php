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
                <table class="display nowrap table-striped w-100 shadow" id="tbl_ventas">
                    <thead class="bg-main">
                        <tr>
                            <th>Fec. Emisión</th>
                            <th>Fec. Vencimiento</th>
                            <th>Tipo</th>
                            <th>Serie</th>
                            <th>Número</th>
                            <th>Tipo Doc. Ident.</th>
                            <th>Nro Doc. Ident.</th>
                            <th>Apellidos y Nombres / Razón Social</th>
                            <th>Valor Facturado Exportacion</th>
                            <th>Base Imponible Operación Gravada</th>
                            <th>Importe Total Operacion Exonerada</th>
                            <th>Importe Total Operacion Inafecta</th>
                            <th>ISC</th>
                            <th>IGV</th>
                            <th>Otros Tributos No Forma Parte Base Imponible</th>
                            <th>Importe Total Comprobante Pago</th>
                            <th>Tipo Cambio</th>
                            <th>Fecha Referencia</th>
                            <th>Tipo Referencia</th>
                            <th>Serie Referencia</th>
                            <th>Nro Comprobante Pago o Documento</th>
                            <th>Moneda</th>
                            <th>Equivalente Dólares Americanos</th>
                            <th>Fecha Vencimiento</th>
                            <th>Condición Contado/Crédito</th>
                            <th>Codigo Centro Costos</th>
                            <th>codigo_centro Costos 2</th>
                            <th>Cuenta Contable Base Imponible</th>
                            <th>Cuenta Contable Otros Tributos</th>
                            <th>Cuenta Contable Total</th>
                            <th>Régimen Especial</th>
                            <th>Porcentaje Régimen Especial</th>
                            <th>Importe Régimen Especial</th>
                            <th>Serie Documento Régimen Especial</th>
                            <th>Numero Documento Regimen Especial</th>
                            <th>Fecha Documento Regimen Especial</th>
                            <th>Código Presupuesto</th>
                            <th>Porcentaje IGV</th>
                            <th>Glosa</th>
                            <th>Medio Pago</th>
                            <th>Condición Percepción</th>
                            <th>Importe Calculo Régimen Especial</th>
                            <th>Impuesto Consumo Bolsas Plástico</th>
                            <th>Cuenta Contable ICBPER</th>
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

        fnc_InicializarFormulario();
        
    })

    function fnc_InicializarFormulario() {
        fnc_CargarPluginDateTime();
        fnc_CargarDataTableVentas();
    }

    /*===================================================================*/
    // P L U G I N   D A T E T I M E P I C K E R
    /*===================================================================*/
    function fnc_CargarPluginDateTime() {

        $('#fecha_desde').datetimepicker({
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

        $('#fecha_hasta').datetimepicker({
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

    function fnc_CargarDataTableVentas() {

        if ($.fn.DataTable.isDataTable('#tbl_ventas')) {
            $('#tbl_ventas').DataTable().destroy();
            $('#tbl_ventas tbody').empty();
        }

        $("#tbl_ventas").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE COMPROBANTES';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            ajax: {
                url: "ajax/ventas.ajax.php",
                dataSrc: '',
                type: "POST",
                data: {
                    'accion': 'reporte_ventas' //1: LISTAR PRODUCTOS
                },
            },
            scrollX: true,
            // scrollY: "63vh",
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