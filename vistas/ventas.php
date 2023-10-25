<!-- Content Header (Page header) -->
<div class="content-header pb-1">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">PUNTO DE VENTA</h2>

            </div><!-- /.col -->

            <div class="col-sm-6">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>

                    <li class="breadcrumb-item active">Ventas</li>

                </ol>

            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container-fluid -->

</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content mb-3">

    <div class="container-fluid">

        <form id="frm-datos-venta" class="needs-validation-venta" novalidate>

            <!-- --------------------------------------------------------- -->
            <!-- COMPROBANTE DE PAGO -->
            <!-- --------------------------------------------------------- -->
            <div class="row">

                <div class="col-12">

                    <div class="card card-gray shadow">

                        <div class="card-header">
                            <h3 class="card-title fs-6">COMPROBANTE DE PAGO</h3>
                        </div> <!-- ./ end card-header -->

                        <div class="card-body py-2">

                            <div class="row">

                                <!-- TIPO COMPROBANTE -->
                                <div class="col-3">
                                    <div class="form-floating mb-2">
                                        <select class="form-select select2" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required>
                                        </select>
                                        <label for="serie">Tipo de Comprobante</label>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>
                                </div>

                                <!-- SERIE -->
                                <div class="col-3">
                                    <div class="form-floating mb-2">
                                        <select class="form-select select2" id="serie" name="serie" aria-label="Floating label select example" required>
                                        </select>
                                        <label for="serie">Serie</label>
                                        <div class="invalid-feedback">Seleccione Serie del Comprobante</div>
                                    </div>
                                </div>

                                <!-- CORRELATIVO -->
                                <div class="col-3">
                                    <div class="form-floating mb-2">
                                        <input type="text" id="correlativo" class="form-control" name="correlativo" required readonly>
                                        <label for="correlativo">Correlativo *(Referencial)</label>
                                        <div class="invalid-feedback">Ingrese el correlativo</div>
                                    </div>
                                </div>

                                <!-- MONEDA -->
                                <div class="col-3">
                                    <div class="form-floating mb-2">
                                        <select class="form-select select2" id="moneda" name="moneda" aria-label="Floating label select example" required>
                                        </select>
                                        <label for="moneda">Moneda</label>
                                        <div class="invalid-feedback">Seleccione la moneda</div>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- --------------------------------------------------------- -->
            <!-- DATOS DEL CLIENTE -->
            <!-- --------------------------------------------------------- -->
            <div class="row">

                <div class="col-12">

                    <div class="card card-gray shadow">

                        <div class="card-header">
                            <h3 class="card-title fs-6">DATOS DEL CLIENTE</h3>
                        </div> <!-- ./ end card-header -->

                        <div class="card-body py-2">

                            <div class="row">

                                <div class="col-4">

                                    <div class="form-floating mb-2">
                                        <select class="form-select select2" id="tipo_documento" name="tipo_documento" aria-label="Floating label select example" required>
                                        </select>
                                        <label for="tipo_documento">Tipo Documento</label>
                                        <div class="invalid-feedback">Seleccione el Tipo de Documento</div>
                                    </div>

                                </div>

                                <div class="col-4">

                                    <div class="form-floating mb-2" style="position: relative;">
                                        <input type="text" id="nro_documento" class="form-control" name="nro_documento">
                                        <label for="nro_documento">Nro Documento</label>
                                        <i class="fas fa-search fs-5 text-primary" id="btnConsultarDni" style="cursor: pointer; position: absolute; top: 50%; right:20px; transform: translateX(-50%) translateY(-50%);"></i>
                                        <div class="invalid-feedback">Ingrese el Nro de Documento</div>
                                    </div>

                                </div>

                                <div class="col-4">

                                    <div class="form-floating mb-2">
                                        <input type="text" id="nombre_cliente_razon_social" class="form-control" name="nombre_cliente_razon_social">
                                        <label for="nombre_cliente_razon_social">Nombre del Cliente / Razón Social</label>
                                        <div class="invalid-feedback">Ingrese el Nombre/Razón Social del Cliente</div>
                                    </div>

                                </div>

                                <div class="col-6">

                                    <div class="form-floating mb-2">
                                        <input type="text" id="direccion" class="form-control" name="direccion">
                                        <label for="direccion">Dirección</label>
                                    </div>

                                </div>

                                <div class="col-4">

                                    <div class="form-floating mb-2">
                                        <input type="text" id="telefono" class="form-control" name="telefono">
                                        <label for="telefono">Teléfono</label>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

            <!-- --------------------------------------------------------- -->
            <!-- LISTADO DE PRODUCTOS (CARRITO DE COMPRAS) -->
            <!-- --------------------------------------------------------- -->
            <div class="row">

                <div class="col-12">

                    <div class="card card-gray shadow">

                        <div class="card-header">
                            <h3 class="card-title fs-6">LISTADO DE PRODUCTOS</h3>
                        </div> <!-- ./ end card-header -->

                        <div class="card-body py-2">

                            <div class="row">

                                <!-- INPUT PARA INGRESO DEL CODIGO DE BARRAS O DESCRIPCION DEL PRODUCTO -->
                                <div class="col-md-12 mb-3">
                                    <div class="form-floating mb-2">
                                        <input type="text" id="producto" class="form-control" name="producto">
                                        <label for="producto">Digite el Producto a vender</label>
                                        <!-- <div class="invalid-feedback">Ingrese el codigo del Producto</div> -->
                                    </div>
                                </div>

                                <!-- TOTAL VENTA-->
                                <div class="col-md-6 mb-3 py-1 rounded-3" style="background-color: gray;color: white;text-align:center;border:1px solid gray;">
                                    <h2 class="fw-bold m-0 text-warning"><span class="fw-bold fs-1 text-warning" id="totalVenta">S/ 0.00</span></h2>
                                </div>

                                <!-- FORMA DE PAGO -->
                                <div class="col-2">
                                    <div class="form-floating mb-2">
                                        <select class="form-select select2" id="forma_pago" name="forma_pago" aria-label="Floating label select example" required>
                                        </select>
                                        <label for="forma_pago">Forma de Pago</label>
                                        <!-- <div class="invalid-feedback">Ingrese el codigo del Producto</div> -->
                                    </div>
                                </div>

                                <!-- TOTAL RECIBIDO -->
                                <div class="col-md-2">
                                    <div class="form-floating mb-2">
                                        <input type="number" step="0.01" id="total_recibido" class="form-control" name="total_recibido">
                                        <label for="total_recibido">Total Recibido</label>
                                        <!-- <div class="invalid-feedback">Ingrese el codigo del Producto</div> -->
                                    </div>
                                </div>

                                <!-- VUELTO -->
                                <div class="col-md-2">
                                    <div class="form-floating mb-2">
                                        <input type="number" id="vuelto" class="form-control" name="vuelto">
                                        <label for="vuelto">Vuelto</label>
                                        <!-- <div class="invalid-feedback">Ingrese el codigo del Producto</div> -->
                                    </div>
                                </div>

                                <!-- LISTADO QUE CONTIENE LOS PRODUCTOS QUE SE VAN AGREGANDO PARA LA COMPRA -->
                                <div class="col-md-12">

                                    <table id="tbl_ListadoProductos" class="display nowrap table-striped w-100 shadow ">
                                        <thead class="bg-gray text-left fs-6">
                                            <tr>
                                                <th>ITEM</th>
                                                <th>CÓDIGO</th>
                                                <th>DESCRIPCIÓN</th>
                                                <th>ID TIPO IGV</th>
                                                <th>TIPO IGV</th>
                                                <th>UND/MEDIDA</th>
                                                <th>PRECIO</th>
                                                <th>CANTIDAD</th>
                                                <th>CANTIDAD FINAL</th>
                                                <th>SUBTOTAL</th>
                                                <th>IGV</th>
                                                <th>IMPORTE</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody class="small text-left fs-6">
                                        </tbody>
                                    </table>
                                    <!-- / table -->
                                </div>
                                <!-- /.col -->
                            </div>
                        </div> <!-- ./ end card-body -->
                    </div>
                </div>
            </div>

            <!-- --------------------------------------------------------- -->
            <!--RESUMEN DE LA VENTA -->
            <!-- --------------------------------------------------------- -->
            <div class="row">

                <div class="col-12">

                    <div class="card card-gray shadow w-25 float-right">

                        <div class="card-header">
                            <h3 class="card-title fs-6">RESUMEN</h3>
                        </div> <!-- ./ end card-header -->

                        <div class="card-body py-2">

                            <div class="row fw-bold">

                                <div class="col-12">
                                    <span>OP. GRAVADAS</span>
                                    <span class="float-right" id="resumen_opes_gravadas">S/ 0.00</span>
                                </div>
                                <div class="col-12">
                                    <span>OP. INAFECTAS</span>
                                    <span class="float-right" id="resumen_opes_inafectas">S/ 0.00</span>
                                </div>
                                <div class="col-12">
                                    <span>OP. EXONERADAS</span>
                                    <span class="float-right" id="resumen_opes_exoneradas">S/ 0.00</span>
                                </div>
                                <div class="col-12">
                                    <span>SUBTOTAL</span>
                                    <span class="float-right" id="resumen_subtotal">S/ 0.00</span>
                                </div>
                                <div class="col-12">
                                    <span>IGV</span>
                                    <span class="float-right" id="resumen_total_igv">S/ 0.00</span>
                                    <hr class="m-1" />
                                </div>

                                <div class="col-12 fs-5">
                                    <span>TOTAL</span>
                                    <span class="float-right" id="resumen_total_venta">S/ 0.00</span>
                                </div>

                                <div class="col-12 text-center mt-3">
                                    <a class="btn btn-success w-100 fw-bold" id="btnGuardarComprobante">GENERAR VENTA</a>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </form>

    </div>

</div>

<script>
    //Variables Globales
    var itemProducto = 1;

    $(document).ready(function() {

        /* VERIFICAR EL ESTADO DE LA CAJA */
        // fnc_ObtenerEstadoCajaPorDia()

        /*===================================================================*/
        //CARGAR DROPDOWN'S
        /*===================================================================*/
        CargarSelects();

        $('#tipo_comprobante').on('change', function(e) {
            $("#correlativo").val('')
            CargarSelect(null, $("#serie"), "--Seleccione Serie--", "ajax/ventas.ajax.php", 'obtener_serie_comprobante', $('#tipo_comprobante').val());

        });

        $('#tipo_documento').on('change', function(e) {

            $("#nro_documento").val('')
            $("#nombre_cliente_razon_social").val('')
            $("#direccion").val('')
            $("#telefono").val('')

            if ($('#tipo_documento').val() == 0) {
                fnc_BloquearDatosCliente(true)
            } else {
                fnc_BloquearDatosCliente(false)
            }

        });

        $("#nro_documento").on('focusout', function() {
            fnc_ConsultarNroDocumento($("#nro_documento").val())
        })

        $('#serie').on('change', function(e) {
            fnc_ObtenerCorrelativo($("#serie").val())
        })

        $("#btnConsultarDni").on('click', function() {
            fnc_ConsultarNroDocumento($("#nro_documento").val());
        })

        /*===================================================================*/
        //CARGAR AUTOCOMPLETE DE PRODUCTOS
        /*===================================================================*/
        fnc_CargarAutocompleteProductos()

        $("#producto").on('keypress', function(e) {
            if (e.which == 13) {
                CargarProductos($("#producto").val());
            }
        });

        /*===================================================================*/
        //CARGAR DATATABLE DE PRODUCTOS A VENDER
        /*===================================================================*/
        fnc_CargarDataTableListadoProductos();

        /* ======================================================================================
        EVENTO PARA MODIFICAR LA CANTIDAD DE PRODUCTOS A COMPRAR
        ======================================================================================*/
        $('#tbl_ListadoProductos tbody').on('change', '.iptCantidad', function() {

            cantidad_actual = $(this)[0]['value'];
            cod_producto_actual = $(this)[0]['attributes'][2]['value'];

            $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

                var row = $('#tbl_ListadoProductos').DataTable().row(index);

                var data = row.data();

                if (data['codigo_producto'] == cod_producto_actual) {

                    $.ajax({
                        async: false,
                        url: "ajax/productos.ajax.php",
                        method: "POST",
                        data: {
                            'accion': 'verificar_stock',
                            'codigo_producto': cod_producto_actual,
                            'cantidad_a_comprar': cantidad_actual
                        },
                        dataType: 'json',
                        success: function(respuesta) {

                            //SI EL PRODUCTO NO TIENE STOCK
                            if (parseInt(respuesta['existe']) == 0) {

                                mensajeToast('error', ' El producto ' + data['descripcion_producto'] + ' ya no tiene stock');

                                $precio = $('#tbl_ListadoProductos').DataTable().cell(index, 6).data()
                                $id_tipo_afectacion = $('#tbl_ListadoProductos').DataTable().cell(index, 3).data()

                                let $subtotal = 0;
                                let $factor_igv = 0;
                                let $porcentaje_igv = 0;
                                let $igv = 0;
                                let $importe = 0;

                                // ACTUALIZAR CANTIDAD A 1
                                $('#tbl_ListadoProductos').DataTable().cell(index, 7).data(`<input  type="number" 
                                                                    style="width:80px;" 
                                                                    codigoProducto = "` + cod_producto_actual + `" 
                                                                    class="form-control text-center iptCantidad m-0 p-0" 
                                                                    value="1">`).draw();

                                $('#tbl_ListadoProductos').DataTable().cell(index, 8).data("1")

                                //ACTUALIZAR SUBTOTAL
                                $subtotal = $precio * 1;
                                $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat($subtotal).toFixed(2)).draw();

                                //ACTUALIZAR IGV
                                if ($id_tipo_afectacion == 10) {
                                    $factor_igv = 1.18;
                                    $porcentaje_igv = 0.18;
                                    $igv = ($precio * 1 * $porcentaje_igv);
                                } else {
                                    $igv = 0
                                    $factor_igv = 1;
                                }

                                $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($igv).toFixed(2)).draw();

                                //ACTUALIZAR IMPORTE
                                $importe = ($precio * 1) * $factor_igv; // * EL FACTOR DE IGV = 1.18
                                $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat($importe).toFixed(2)).draw();

                                $("#producto").val("");
                                $("#producto").focus();

                                // RECALCULAMOS TOTALES
                                recalcularTotales();

                                // CUANDO EL PRODUCTO SI TIENE STOCK
                            } else {

                                //OBTENER PRECIO DEL PRODUCTO
                                $precio = $('#tbl_ListadoProductos').DataTable().cell(index, 6).data();
                                $id_tipo_afectacion = $('#tbl_ListadoProductos').DataTable().cell(index, 3).data();

                                let $subtotal = 0;
                                let $factor_igv = 0;
                                let $porcentaje_igv = 0;
                                let $igv = 0;
                                let $importe = 0;

                                // ACTUALIZAR CANTIDAD
                                $('#tbl_ListadoProductos').DataTable().cell(index, 7).data(`<input type="number" 
                                                                                                style="width:80px;" 
                                                                                                codigoProducto = "` + cod_producto_actual + `" 
                                                                                                class="form-control text-center iptCantidad m-0 p-0" 
                                                                                                value="` + cantidad_actual + `">`).draw();


                                $('#tbl_ListadoProductos').DataTable().cell(index, 8).data(cantidad_actual)

                                //CALCULAR SUBTOTAL
                                $subtotal = $precio * cantidad_actual
                                $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat($subtotal).toFixed(2)).draw();

                                //CALCULAR IGV
                                if ($id_tipo_afectacion == 10) {
                                    $factor_igv = 1.18;
                                    $porcentaje_igv = 0.18;
                                    $igv = ($precio * cantidad_actual * $porcentaje_igv); // * EL % DE IGV = 0.18

                                } else {
                                    $igv = 0
                                    $factor_igv = 1;
                                }
                                $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($igv).toFixed(2)).draw();

                                //CALCULAR IMPORTE
                                $importe = ($precio * cantidad_actual) * $factor_igv; // * EL FACTOR DE IGV = 1.18
                                $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat($importe).toFixed(2)).draw();

                                $("#producto").val("");
                                $("#producto").focus();

                                // RECALCULAMOS TOTALES
                                recalcularTotales();
                            }
                        }
                    });

                }

            });

        });

        /* ======================================================================================
        EVENTO PARA ELIMINAR UN PRODUCTO DEL LISTADO
        ======================================================================================*/
        $('#tbl_ListadoProductos tbody').on('click', '.btnEliminarproducto', function() {
            $('#tbl_ListadoProductos').DataTable().row($(this).parents('tr')).remove().draw();
            recalcularTotales();
        });

        $("#btnGuardarComprobante").on('click', function() {
            fnc_GuardarVenta();
        })
    })

    /*===================================================================*/
    //CARGAR DROPDOWN'S
    /*===================================================================*/
    function CargarSelects() {
        CargarSelect('03', $("#tipo_comprobante"), "--Seleccione Tipo Comprobante--", "ajax/ventas.ajax.php", 'obtener_tipo_comprobante');
        CargarSelect(3, $("#serie"), "--Seleccione Serie--", "ajax/ventas.ajax.php", 'obtener_serie_comprobante', $('#tipo_comprobante').val());
        fnc_ObtenerCorrelativo($("#serie").val())
        CargarSelect('PEN', $("#moneda"), "--Seleccione Moneda--", "ajax/ventas.ajax.php", 'obtener_moneda');
        CargarSelect('0', $("#tipo_documento"), "--Seleccione Tipo Documento--", "ajax/ventas.ajax.php", 'obtener_tipo_documento');
        fnc_BloquearDatosCliente(true);
        CargarSelect(1, $("#forma_pago"), "--Seleccione Forma de Pago--", "ajax/ventas.ajax.php", 'obtener_forma_pago');

        $('.select2').select2()
    }

    function fnc_ObtenerCorrelativo(id_serie) {
        var formData = new FormData();
        formData.append('accion', 'obtener_correlativo_serie');
        formData.append('id_serie', id_serie);

        response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);
        $("#correlativo").val(response["correlativo"])
    }
    /*===================================================================*/
    //CARGAR AUTOCOMPLETE DE PRODUCTOS
    /*===================================================================*/
    function fnc_CargarAutocompleteProductos() {

        $("#producto").autocomplete({
            source: "ajax/autocomplete_productos.ajax.php",
            minLength: 2,
            autoFocus: true,
            select: function(event, ui) {
                CargarProductos(ui.item.id);
                $("#producto").val('');
                $("#producto").focus();
                return false;
            },
            response: function(event, ui) {

                if (!ui.content.length) {
                    var noResult = {
                        value: "",
                        label: '<a href="javascript:void(0);" class="d-flex border border-secondary border-left-0 border-right-0 border-top-0" style="width:100% !important;">' +
                            '<div class=""> ' +
                            '<span class="text-sm fw-bold">No existen datos</span>' +
                            '</div>' +
                            '</a>'
                    };
                    ui.content.push(noResult);
                }
            }
        }).data("ui-autocomplete")._renderItem = function(ul, item) {
            return $("<li class='ui-autocomplete-row'></li>")
                .data("item.autocomplete", item)
                .append(item.label)
                .appendTo(ul);
        };

    }

    /*===================================================================*/
    //CARGAR DATATABLE DE PRODUCTOS A VENDER
    /*===================================================================*/
    function fnc_CargarDataTableListadoProductos() {

        if ($.fn.DataTable.isDataTable('#tbl_ListadoProductos')) {
            $('#tbl_ListadoProductos').DataTable().destroy();
            $('#tbl_ListadoProductos tbody').empty();
        }

        $('#tbl_ListadoProductos').DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE PRODUCTOS';
                    return printTitle
                }
            }, 'pageLength'],
            "columns": [{
                    "data": "id"
                },
                {
                    "data": "codigo_producto"
                },
                {
                    "data": "descripcion"
                },
                {
                    "data": "id_tipo_igv"
                },
                {
                    "data": "tipo_igv"
                },
                {
                    "data": "unidad_medida"
                },
                {
                    "data": "precio"
                },
                {
                    "data": "cantidad"
                },
                {
                    "data": "cantidad_final"
                },
                {
                    "data": "subtotal"
                },
                {
                    "data": "igv"
                },
                {
                    "data": "importe"
                },
                {
                    "data": "acciones"
                }
            ],
            columnDefs: [{
                targets: [0, 1, 3, 8],
                visible: false
            }],
            "order": [
                [0, 'desc']
            ],
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });
    }

    /*===================================================================*/
    //CARGAR PRODUCTOS EN EL DATATABLE
    /*===================================================================*/
    function CargarProductos(producto = "") {

        var codigo_producto;

        if (producto != "") codigo_producto = producto;
        else codigo_producto = $("#iptCodigoVenta").val();

        var producto_repetido = 0;

        /*===================================================================*/
        // AUMENTAMOS LA CANTIDAD SI EL PRODUCTO YA EXISTE EN EL LISTADO
        /*===================================================================*/
        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);
            var data = row.data();

            if (codigo_producto == data['codigo_producto']) {

                producto_repetido = 1;

                cantidad_a_comprar = parseFloat($.parseHTML(data['cantidad'])[0]['value']) + 1;

                $.ajax({
                    async: false,
                    url: "ajax/productos.ajax.php",
                    method: "POST",
                    data: {
                        'accion': 'verificar_stock',
                        'codigo_producto': codigo_producto,
                        'cantidad_a_comprar': cantidad_a_comprar
                    },
                    dataType: 'json',
                    success: function(respuesta) {

                        if (parseInt(respuesta['existe']) == 0) {

                            mensajeToast('error', ' El producto ' + data['descripcion'] + ' ya no tiene stock');

                            $("#producto").val("");
                            $("#producto").focus();

                        } else {

                            $precio = $('#tbl_ListadoProductos').DataTable().cell(index, 6).data()
                            $id_tipo_afectacion = $('#tbl_ListadoProductos').DataTable().cell(index, 3).data()

                            let $subtotal = 0;
                            let $factor_igv = 0;
                            let $porcentaje_igv = 0;
                            let $igv = 0;
                            let $importe = 0;

                            // ACTUALIZAR CANTIDAD A 1
                            $('#tbl_ListadoProductos').DataTable().cell(index, 7).data(`<input  type="number" 
                                                                    style="width:80px;" 
                                                                    codigoProducto = "` + codigo_producto + `" 
                                                                    class="form-control text-center iptCantidad m-0 p-0" 
                                                                    value="` + cantidad_a_comprar + `">`).draw();

                            $('#tbl_ListadoProductos').DataTable().cell(index, 8).data(cantidad_a_comprar)

                            //ACTUALIZAR SUBTOTAL
                            $subtotal = $precio * cantidad_a_comprar;
                            $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat($subtotal).toFixed(2)).draw();

                            //ACTUALIZAR IGV
                            if ($id_tipo_afectacion == 10) {
                                $factor_igv = 1.18;
                                $porcentaje_igv = 0.18;
                                $igv = ($precio * cantidad_a_comprar * $porcentaje_igv); // * EL % DE IGV = 0.18

                            } else {
                                $igv = 0
                                $factor_igv = 1;
                            }



                            $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($igv).toFixed(2)).draw();

                            //ACTUALIZAR IMPORTE
                            $importe = ($precio * cantidad_a_comprar) * $factor_igv; // * EL FACTOR DE IGV = 1.18
                            $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat($importe).toFixed(2)).draw();

                            // RECALCULAMOS TOTALES
                            recalcularTotales();

                        }
                    }
                });

            }
        });

        if (producto_repetido == 1) {
            return;
        }

        $.ajax({
            url: "ajax/productos.ajax.php",
            method: "POST",
            data: {
                'accion': 'obtener_producto_x_codigo', //BUSCAR PRODUCTOS POR SU CODIGO DE BARRAS
                'codigo_producto': codigo_producto
            },
            dataType: 'json',
            success: function(respuesta) {

                /*===================================================================*/
                //SI LA RESPUESTA ES VERDADERO, TRAE ALGUN DATO
                /*===================================================================*/
                if (respuesta) {

                    var TotalVenta = 0.00;

                    $('#tbl_ListadoProductos').DataTable().row.add({
                        'id': itemProducto,
                        'codigo_producto': respuesta['codigo_producto'],
                        'descripcion': respuesta['descripcion'],
                        'id_tipo_igv': respuesta['id_tipo_afectacion_igv'],
                        'tipo_igv': respuesta['tipo_afectacion_igv'],
                        'unidad_medida': respuesta['unidad_medida'],
                        'precio': parseFloat(respuesta['precio_unitario_sin_igv']).toFixed(2),
                        'cantidad': '<input type="number" style="width:80px;" codigoProducto = "' + respuesta['codigo_producto'] + '" class="form-control text-center iptCantidad p-0 m-0" value="1">',
                        'cantidad_final': 1,
                        'subtotal': parseFloat(respuesta['precio_unitario_sin_igv'] * 1).toFixed(2),
                        'igv': parseFloat((respuesta['precio_unitario_sin_igv'] * 1 * respuesta['porcentaje_igv'])).toFixed(2),
                        'importe': parseFloat((respuesta['precio_unitario_sin_igv'] * 1) * respuesta['factor_igv']).toFixed(2),
                        'acciones': "<center>" +
                            "<span class='btnEliminarproducto text-danger px-1'style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar producto'> " +
                            "<i class='fas fa-trash fs-5'> </i> " +
                            "</span>" +
                            "<div class='btn-group'>" +
                            "<button type='button' class=' p-0 btn btn-primary transparentbar dropdown-toggle btn-sm' data-bs-toggle='dropdown' aria-expanded='false'>" +
                            "<i class='fas fa-hand-holding-usd fs-5 text-green'></i> <i class='fas fa-chevron-down text-primary'></i>" +
                            "</button>" +

                            "<ul class='dropdown-menu'>" +
                            "<li><a class='dropdown-item' codigo = '" + respuesta['codigo_producto'] + "' precio=' " + respuesta['precio_unitario_con_igv'] + "' style='cursor:pointer; font-size:14px;'>Normal (" + respuesta['precio_venta_producto'] + ")</a></li>" +
                            "<li><a class='dropdown-item' codigo = '" + respuesta['codigo_producto'] + "' precio=' " + respuesta['precio_unitario_mayor_con_igv'] + "' style='cursor:pointer; font-size:14px;'>Por Mayor (S./ " + parseFloat(respuesta['precio_mayor_producto']).toFixed(2) + ")</a></li>" +
                            "<li><a class='dropdown-item' codigo = '" + respuesta['codigo_producto'] + "' precio=' " + respuesta['precio_unitario_oferta_con_igv'] + "' style='cursor:pointer; font-size:14px;'>Oferta (S./ " + parseFloat(respuesta['precio_oferta_producto']).toFixed(2) + ")</a></li>" +
                            "</ul>" +
                            "</div>" +
                            "</center>"
                    }).draw();

                    itemProducto = itemProducto + 1;

                    //  Recalculamos el total de la venta
                    recalcularTotales();

                    /*===================================================================*/
                    //SI LA RESPUESTA ES FALSO, NO TRAE ALGUN DATO
                    /*===================================================================*/
                } else {
                    mensajeToast('error', 'EL PRODUCTO NO EXISTE O NO TIENE STOCK');
                }

            }
        });

        $("#producto").val("");
        $("#producto").focus();

    }

    /*===================================================================*/
    //RECALCULAR LOS TOTALES DE VENTA
    /*===================================================================*/
    function recalcularTotales() {

        let TotalVenta = 0.00;
        let total_opes_gravadas = 0.00;
        let total_opes_exoneradas = 0.00;
        let total_opes_inafectas = 0.00;
        let subtotal = 0.00;
        let total_igv = 0.00;
        let factor_igv = 1;

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);
            var data = row.data();

            factor_igv = 1;

            if (data['id_tipo_igv'] == 10) {
                total_opes_gravadas = total_opes_gravadas + (data['precio'] * data['cantidad_final']);
                total_igv = total_igv + (data['precio'] * data['cantidad_final'] * 0.18)
                factor_igv = 1.18
            }

            if (data['id_tipo_igv'] == 20) {
                total_opes_exoneradas = total_opes_exoneradas + (data['precio'] * data['cantidad_final']);
            }

            if (data['id_tipo_igv'] == 30) {
                total_opes_inafectas = total_opes_inafectas + (data['precio'] * data['cantidad_final']);
            }

            
            TotalVenta = TotalVenta + (data['precio'] * data['cantidad_final'] * factor_igv)

        });

        subtotal = subtotal + (total_opes_gravadas + total_opes_exoneradas + total_opes_inafectas);

        $("#totalVenta").html('')
        $("#totalVenta").html('S/ ' + TotalVenta.toFixed(2));

        $("#resumen_opes_gravadas").html('S/ ' + parseFloat(total_opes_gravadas).toFixed(2));
        $("#resumen_opes_inafectas").html('S/ ' + parseFloat(total_opes_inafectas).toFixed(2));
        $("#resumen_opes_exoneradas").html('S/ ' + parseFloat(total_opes_exoneradas).toFixed(2));
        $("#resumen_subtotal").html('S/ ' + parseFloat(subtotal).toFixed(2));
        $("#resumen_total_igv").html('S/ ' + parseFloat(total_igv).toFixed(2));
        $("#resumen_total_venta").html('S/ ' + parseFloat(TotalVenta).toFixed(2));

        $("#total_recibido").val(parseFloat(TotalVenta).toFixed(2))

    }

    function fnc_GuardarVenta() {

        let count = 0;
        form_comprobante_validate = validarFormulario('needs-validation-venta');

        //INICIO DE LAS VALIDACIONES
        if (!form_comprobante_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        if ($("#tipo_documento").val() != "0" && ($("#nro_documento").val() == "" ||
                $("#nombre_cliente_razon_social").val() == "" ||
                $("#direccion").val() == "")) {
            mensajeToast("error", "Debe completar los datos del Cliente");
            return;
        }


        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {
            count = count + 1;
        });

        if (count == 0) {
            mensajeToast("error", "Ingrese los productos para la venta");
            return;
        }

        if ($("#total_recibido").val() == "" ){
            mensajeToast("error", "Ingrese el Total recibido");
            return;
        }
        //FIN DE LAS VALIDACIONES

        Swal.fire({
            title: 'Está seguro(a) de registrar la Venta?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                detalle_productos = $("#tbl_ListadoProductos").DataTable().rows().data().toArray();

                var formData = new FormData();
                formData.append('accion', 'registrar_comprobante');
                formData.append('datos_venta', $("#frm-datos-venta").serialize());
                formData.append('arr_detalle_productos', JSON.stringify(detalle_productos));

                response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);               

                Swal.fire({
                    position: 'top-center',
                    icon: 'success',
                    title: 'Se generó la venta correctamente',
                    showConfirmButton: true,
                    timer: 2000
                })

                fnc_LimpiarFomulario();

            }

        })
    }

    function fnc_LimpiarFomulario() {

        //Datos del Comprobante
        $("#tipo_comprobante").val('')
        $("#serie").val('')
        $("#correlativo").val('')
        $("#moneda").val('')

        //Datos del Cliente
        $("#tipo_documento").val('')
        $("#nro_documento").val('')
        $("#nombre_cliente_razon_social").val('')
        $("#direccion").val('')
        $("#telefono").val('')

        //Datos de la Venta
        $("#producto").val('')
        $("#totalVenta").html('')
        $("#totalVenta").html('S/ 0.00')
        $("#forma_pago").val('')
        $("#total_recibido").val('')
        $("#vuelto").val('')

        CargarSelects();

        //Listado de Productos
        fnc_CargarDataTableListadoProductos();

        //Datos del Resumen
        $("#resumen_opes_gravadas").html('S/ 0.00')
        $("#resumen_opes_inafectas").html('S/ 0.00')
        $("#resumen_opes_exoneradas").html('S/ 0.00')
        $("#resumen_subtotal").html('S/ 0.00')
        $("#resumen_total_igv").html('S/ 0.00')
        $("#resumen_total_venta").html('S/ 0.00')

        $(".needs-validation-venta").removeClass("was-validated");
    }


    /*===================================================================*/
    //GENERALES
    /*===================================================================*/
    function fnc_ConsultarNroDocumento(nro_documento) {

        var formData = new FormData();
        let accion = '';

        if ($("#tipo_documento").val() == 1) {
            accion = 'consultar_dni';
        } else if ($("#tipo_documento").val() == 6) {
            accion = 'consultar_ruc';
        }

        formData.append('accion', accion);
        formData.append('nro_documento', nro_documento);

        response = SolicitudAjax('ajax/apis/apis.ajax.php', 'POST', formData);

        if (response) {

            if (response['message']) {

                if (response['message'] == "not found") {
                    mensajeToast("error", 'No se encontraron datos')
                }

                if (response['message'] == "dni no valido") {
                    mensajeToast("error", 'El DNI ingresado no es válido')
                }

                if (response['message'] == "ruc no valido") {
                    mensajeToast("error", 'El RUC ingresado no es válido')
                }

                $("#nro_documento").val('')
                $("#nombre_cliente_razon_social").val('')
                $("#direccion").val('')
                $("#telefono").val('')
                return;
            }

            if ($("#tipo_documento").val() == 1) {
                $("#nombre_cliente_razon_social").val(response['nombres'] + ' ' + response['apellidoPaterno'] + ' ' + response['apellidoMaterno']);
            } else if ($("#tipo_documento").val() == 6) {
                $("#nombre_cliente_razon_social").val(response['razonSocial']);
                $("#direccion").val(response['direccion']);
            }

        }
    }

    function fnc_BloquearDatosCliente(disabled) {
        $("#nro_documento").prop('disabled', disabled)
        $("#nombre_cliente_razon_social").prop('disabled', disabled)
        $("#direccion").prop('disabled', disabled)
        $("#telefono").prop('disabled', disabled)
        if (disabled == true) $("#btnConsultarDni").css('visibility', 'hidden')
        else $("#btnConsultarDni").css('visibility', 'visible');

    }

</script>