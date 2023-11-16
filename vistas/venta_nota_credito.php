<!-- Content Header (Page header) -->
<div class="content-header pb-1">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">NOTA DE CRÉDITO</h2>

            </div><!-- /.col -->

            <div class="col-sm-6 d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="/">Inicio</a></li>

                    <li class="breadcrumb-item active">Ventas / Nota de Crédito</li>

                </ol>

            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container-fluid -->

</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content" style="position: relative;">

    <input type="hidden" name="id_caja" id="id_caja" value="0">

    <div class="row">

        <div class="col-12 ">

            <form id="frm-datos-venta" class="needs-validation-venta" novalidate>

                <div class="row">

                    <!-- --------------------------------------------------------- -->
                    <!-- OPCIONES DE REGISTRO DE VENTA (ENVIO SUNAT O SOLO REGISTRAR) -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-6 text-center mb-2">
                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-center my-0 ">
                            <div class="icheck-warning d-inline mx-2">
                                <input type="radio" id="rb-venta-envio" value="1" name="rb_generar_venta" checked="">
                                <label for="rb-venta-envio">
                                    Generar Venta y Enviar Comprobante
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-lg-6 text-center mb-2">
                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-center my-0 ">
                            <div class="icheck-success d-inline mx-2">
                                <input type="radio" id="rb-venta" value="2" name="rb_generar_venta">
                                <label for="rb-venta">
                                    Solo Generar Venta
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- --------------------------------------------------------- -->
                    <!-- DATOS DEL COMPROBANTE -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-6">

                        <div class="card card-gray shadow">

                            <div class="card-header">
                                <h3 class="card-title fs-6">COMPROBANTE DE PAGO</h3>
                                <div class="card-tools m-0">

                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove">
                                        <i class="fas fa-times"></i>
                                    </button>

                                </div> <!-- ./ end card-tools -->
                            </div> <!-- ./ end card-header -->

                            <div class="card-body py-2">

                                <div class="row">

                                    <!-- EMITIR POR -->
                                    <div class="col-12 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-building mr-1 my-text-color"></i> Empresa Emisora
                                        </label>
                                        <select class="form-select" id="empresa_emisora" name="empresa_emisora" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Empresa</div>
                                    </div>


                                    <!-- FECHA DE EMISION -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-calendar-alt mr-1 my-text-color"></i> Fecha Emisión
                                        </label>
                                        <div class="input-group input-group-sm mb-3 ">
                                            <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_emision">
                                                <i class="fas fa-calendar-alt ml-1 text-white"></i>
                                            </span>
                                            <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_emision" name="fecha_emision" aria-describedby="inputGroup-sizing-sm" required>
                                            <div class="invalid-feedback">Ingrese Fecha de Emisión</div>
                                        </div>
                                    </div>

                                    <!-- TIPO COMPROBANTE -->
                                    <div class="col-12 col-md-8 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-file-contract mr-1 my-text-color"></i>Tipo de Comprobante
                                        </label>
                                        <select class="form-select" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required readonly>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>

                                    <!-- SERIE -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Serie</label>
                                        <select class="form-select" id="serie" name="serie" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Serie del Comprobante</div>
                                    </div>

                                    <!-- CORRELATIVO -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Correlativo</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="correlativo" name="correlativo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required readonly>
                                    </div>

                                    <!-- MONEDA -->
                                    <div class="col-12 col-md-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-money-bill-wave mr-1 my-text-color"></i>Moneda</label>
                                        <select class="form-select" id="moneda" name="moneda" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione la moneda</div>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- --------------------------------------------------------- -->
                    <!-- DATOS DEL COMPROBANTE MODIFICADO-->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-6">

                        <div class="card card-gray shadow">

                            <div class="card-header">
                                <h3 class="card-title fs-6">COMPROBANTE DE PAGO A MODIFICAR</h3>
                                <div class="card-tools m-0">

                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove">
                                        <i class="fas fa-times"></i>
                                    </button>

                                </div> <!-- ./ end card-tools -->
                            </div> <!-- ./ end card-header -->

                            <div class="card-body py-2">

                                <div class="row">


                                    <!-- TIPO COMPROBANTE -->
                                    <div class="col-12 col-md-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color">
                                            <i class="fas fa-file-contract mr-1 my-text-color"></i>Tipo de Comprobante
                                        </label>
                                        <select class="form-select" id="tipo_comprobante_modificado" name="tipo_comprobante_modificado" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>


                                    <!-- SERIE -->
                                    <div class="col-12 col-md-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Serie</label>
                                        <select class="form-select" id="serie_modificado" name="serie_modificado" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Serie del Comprobante</div>
                                    </div>

                                    <!-- CORRELATIVO -->
                                    <div class="col-12 col-md-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Correlativo</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="correlativo_modificado" name="correlativo_modificado" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                    </div>

                                    <!-- TIPO NOTA DE CREDITO -->
                                    <div class="col-12 col-md-12 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-money-bill-wave mr-1 my-text-color"></i>Motivo Nota de Crédito</label>
                                        <select class="form-select" id="motivo_nota_credito" name="motivo_nota_credito" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el motivo</div>
                                    </div>

                                    <!-- DESCRIPCION -->
                                    <div class="col-12 col-md-8 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Descripción</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="descripcion_nota_credito" name="descripcion_nota_credito" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la descripción</div>
                                    </div>

                                    <div class="col-12 col-md-4 mb-2 d-flex align-items-end">
                                        <a class="btn btn-sm btn-success  fw-bold  w-100" id="btnRecuperarVenta" style="position: relative;">
                                            <span class="text-button">OBTENER VENTA</span>
                                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                                <i class="fas fa-search fs-5 text-white m-0 p-0"></i>
                                            </span>
                                        </a>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- --------------------------------------------------------- -->
                    <!-- LISTADO DE PRODUCTOS -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-8">

                        <div class="card card-gray shadow">

                            <div class="card-header">
                                <h4 class="card-title fs-6">LISTADO DE PRODUCTOS</h4>
                            </div> <!-- ./ end card-header -->

                            <div class="card-body py-2">

                                <div class="row">

                                    <div class="d-block col-12 d-lg-none mb-3">
                                        <div class="col-12 text-center px-2 rounded-3">
                                            <div class="btn fw-bold fs-3  text-warning my-bg w-100" id="totalVenta">S/0.00</div>
                                        </div>
                                    </div>

                                    <!-- INPUT PARA INGRESO DEL CODIGO DE BARRAS O DESCRIPCION DEL PRODUCTO -->
                                    <div class="col-12 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-cart-plus mr-1 my-text-color"></i>Digite el Producto a vender</label>
                                        <input type="text" placeholder="Ingrese el código de barras o el nombre del producto" style="border-radius: 20px;" class="form-control form-control-sm" id="producto" name="producto" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                    </div>

                                    <!-- LISTADO QUE CONTIENE LOS PRODUCTOS QUE SE VAN AGREGANDO PARA LA COMPRA -->
                                    <div class="col-md-12 mt-2">

                                        <table id="tbl_ListadoProductos" class="display nowrap table-striped w-100 shadow ">
                                            <thead class="bg-main text-left fs-6">
                                                <tr>
                                                    <th>ITEM</th>
                                                    <th>CÓDIGO</th>
                                                    <th>DESCRIPCIÓN</th>
                                                    <th>ID TIPO IGV</th>
                                                    <th>TIPO IGV</th>
                                                    <th>UND/MEDIDA</th>
                                                    <th>VALOR</th>
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

                    <!-- --------------------------------------------------------- -->
                    <!-- RESUMEN DE LA VENTA -->
                    <!-- --------------------------------------------------------- -->
                    <div class="col-12 col-lg-4">

                        <div class="row">

                            <div class="col-12">
                                <!-- --------------------------------------------------------- -->
                                <!-- RESUMEN DE LA VENTA -->
                                <!-- --------------------------------------------------------- -->
                                <div class="card card-gray shadow w-lg-100 float-right">

                                    <div class="card-header">
                                        <h3 class="card-title fs-6">RESUMEN</h3>
                                    </div> <!-- ./ end card-header -->

                                    <div class="card-body py-2">

                                        <div class="row fw-bold">

                                            <div class="col-12 col-md-12">
                                                <span>OP. GRAVADAS</span>
                                                <span class="float-right" id="resumen_opes_gravadas">S/
                                                    0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>OP. INAFECTAS</span>
                                                <span class="float-right" id="resumen_opes_inafectas">S/
                                                    0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>OP. EXONERADAS</span>
                                                <span class="float-right" id="resumen_opes_exoneradas">S/
                                                    0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>SUBTOTAL</span>
                                                <span class="float-right" id="resumen_subtotal">S/ 0.00</span>
                                            </div>
                                            <div class="col-12 col-md-12">
                                                <span>IGV</span>
                                                <span class="float-right" id="resumen_total_igv">S/ 0.00</span>
                                                <hr class="m-1" />
                                            </div>

                                            <div class="col-12 col-md-12 fs-4 my-color">
                                                <span>TOTAL</span>
                                                <span class="float-right " id="resumen_total_venta">S/
                                                    0.00</span>
                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </div>

                            <div class="col-12 text-center my-1">

                                <div class="row">
                                    <div class="col-6">
                                        <a class="btn btn-sm btn-danger  fw-bold w-100 " id="btnCancelarVenta" style="position: relative;">
                                            <span class="text-button">CANCELAR</span>
                                            <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                            </span>
                                        </a>
                                    </div>
                                    <div class="col-6">
                                        <a class="btn btn-sm btn-success  fw-bold  w-100" id="btnGuardarComprobante" style="position: relative;">
                                            <span class="text-button">VENDER</span>
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

            </form>

        </div>

    </div>

</div>

<div class="loading">Loading</div>

<script>
    //Variables Globales
    var itemProducto = 1;
    $(document).ready(function() {

        fnc_MostrarLoader()

        /*===================================================================*/
        // I N I C I A L I Z A R   F O R M U L A R I O 
        /*===================================================================*/
        fnc_InicializarFormulario();

        $('#serie').on('change', function(e) {
            fnc_ObtenerCorrelativo($("#serie").val())
        })

        $('#tipo_comprobante_modificado').on('change', function(e) {
            CargarSelect(null, $("#serie_modificado"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_serie_comprobante', $('#tipo_comprobante_modificado').val());
        })

        $("#btnRecuperarVenta").on('click', function() {
            fnc_RecuperarVenta();
        })

        $("#btnGuardarComprobante").on('click', function() {
            fnc_GuardarVenta();
        })

        fnc_OcultarLoader();
    })

    function fnc_MostrarLoader() {
        $(".loading").removeClass('d-none');
        $(".loading").addClass('d-block');
    }

    function fnc_OcultarLoader() {
        $(".loading").removeClass('d-block');
        $(".loading").addClass('d-none')
    }

    function fnc_InicializarFormulario() {

        CargarSelects();
        fnc_CargarDataTableListadoProductos();
        // fnc_ObtenerCorrelativo($("#serie").val());
        // fnc_CargarPluginDateTime();
        // fnc_CargarAutocompleteProductos()

        // fnc_CargarDataTableListadoProductos();


        // //Datos del Comprobante
        // $("#tipo_comprobante").attr("readonly", true);        
        // $("#nro_documento").val('')
        // $("#nombre_cliente_razon_social").val('')
        // $("#direccion").val('')
        // $("#telefono").val('')

        // //Datos de la Venta
        // $("#forma_pago").attr("readonly", true);
        // $("#producto").val('')

        // $("#totalVenta").html('')
        // $("#totalVenta").html('S/ 0.00')
        // // $("#forma_pago").val('')
        // $("#total_recibido").val('')
        // $("#vuelto").val('')

        // //Datos del Resumen
        // $("#resumen_opes_gravadas").html('S/ 0.00')
        // $("#resumen_opes_inafectas").html('S/ 0.00')
        // $("#resumen_opes_exoneradas").html('S/ 0.00')
        // $("#resumen_subtotal").html('S/ 0.00')
        // $("#resumen_total_igv").html('S/ 0.00')
        // $("#resumen_total_venta").html('S/ 0.00')

        // $(".needs-validation-venta").removeClass("was-validated");
    }

    /*===================================================================*/
    // C A R G A R   D R O P D O W N'S
    /*===================================================================*/
    function CargarSelects() {

        // EMPRESA EMISORA
        CargarSelect(1, $("#empresa_emisora"), "--Seleccionar--", "ajax/empresas.ajax.php", 'obtener_empresas_select');

        // TIPO DE COMPROBANTE
        CargarSelect('07', $("#tipo_comprobante"), "--Seleccionar--", "ajax/series.ajax.php", 'obtener_tipo_comprobante');
        CargarSelect(null, $("#tipo_comprobante_modificado"), "--Seleccionar--", "ajax/series.ajax.php", 'obtener_tipo_comprobante_nota_credito');

        // SERIE DEL COMPROBANTE
        CargarSelect(null, $("#serie"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_serie_comprobante', $('#tipo_comprobante option:selected').val());

        //MONEDA
        CargarSelect('PEN', $("#moneda"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_moneda');

        CargarSelect(null, $("#motivo_nota_credito"), "--Seleccionar--", "ajax/series.ajax.php", 'obtener_motivo_nota_credito');
    }

    /*===================================================================*/
    // O B T E N E R   C O R R E L A T I V O
    /*===================================================================*/
    function fnc_ObtenerCorrelativo(id_serie) {
        var formData = new FormData();
        formData.append('accion', 'obtener_correlativo_serie');
        formData.append('id_serie', id_serie);

        response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);
        $("#correlativo").val(response["correlativo"])
    }

    function fnc_RecuperarVenta() {

        var formData = new FormData();
        formData.append('accion', 'obtener_detalle_venta')
        formData.append('id_serie', $("#serie_modificado").val())
        formData.append('correlativo', $("#correlativo_modificado").val());

        response = SolicitudAjax('ajax/ventas.ajax.php', 'POST', formData);
        console.log("🚀 ~ file: venta_nota_credito.php:520 ~ fnc_RecuperarVenta ~ response:", response)

        for (let index = 0; index < response.length; index++) {
            const producto = response[index];
            // console.log("🚀 ~ file: venta_nota_credito.php:524 ~ fnc_RecuperarVenta ~ element:", element)

            $('#tbl_ListadoProductos').DataTable().row.add({
                'id': index,
                'codigo_producto': producto.codigo_producto,
                'descripcion': producto.descripcion,
                'id_tipo_igv': producto.id_tipo_afectacion_igv,
                'tipo_igv': producto.tipo_afectacion_igv,
                'unidad_medida': producto.unidad_medida,
                'precio': '<input type="number" style="width:80px;" codigoProducto = "' + producto.codigo_producto + '" class="form-control form-control-sm text-center iptPrecio rounded-pill p-0 m-0" value="' + producto.precio_unitario_con_igv + '">',
                'cantidad': '<input type="number" style="width:80px;" codigoProducto = "' + producto.codigo_producto + '" class="form-control form-control-sm text-center iptCantidad rounded-pill p-0 m-0" value="' + producto.cantidad + '">',
                'cantidad_final': producto.cantidad,
                'subtotal': parseFloat(producto.precio_unitario_sin_igv * producto.cantidad).toFixed(2),
                'igv': parseFloat((producto.precio_unitario_sin_igv * producto.cantidad * producto.porcentaje_igv)).toFixed(2),
                'importe': parseFloat((producto.precio_unitario_sin_igv * producto.cantidad) * producto.factor_igv).toFixed(2),
                'acciones': "<center>" +
                    "<span class='btnEliminarproducto text-danger px-1'style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar producto'> " +
                    "<i class='fas fa-trash fs-5'> </i> " +
                    "</span>" +
                    "</center>"
            }).draw();

        }


    }

    /*===================================================================*/
    // C A R G A R   D A T A T A B L E   D E   P R O D U C T O S   A   V E N D ER
    /*===================================================================*/
    function fnc_CargarDataTableListadoProductos() {

        if ($.fn.DataTable.isDataTable('#tbl_ListadoProductos')) {
            $('#tbl_ListadoProductos').DataTable().destroy();
            $('#tbl_ListadoProductos tbody').empty();
        }

        $('#tbl_ListadoProductos').DataTable({
            searching: false,
            paging: false,
            info: false,
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
                targets: [0, 1, 3, 4, 5, 8],
                visible: false
            }],
            scrollX: true,
            // autoWidth: true,
            scrollY: "50vh",
            "order": [
                [0, 'desc']
            ],
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });

    }

    /*===================================================================*/
    //G U A R D A R   V E N T A
    /*===================================================================*/
    function fnc_GuardarVenta() {

        // var detalle_productos = $("#tbl_ListadoProductos").DataTable().rows().data().toArray();
        // console.log("🚀 ~ file: venta_nota_credito.php:633 ~ fnc_GuardarVenta ~ detalle_productos:", detalle_productos)
        
        var productos = [];
        var arr = {};   
        
        

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);

            var data = row.data();
            console.log("🚀 ~ file: venta_nota_credito.php:642 ~ $ ~ data:", data)

            precio = parseFloat($.parseHTML(data['precio'])[0]['value'])
            cantidad = parseFloat($.parseHTML(data['cantidad'])[0]['value'])
            
            arr['codigo_producto'] = data["codigo_producto"];
            arr['id_tipo_igv'] = data["id_tipo_igv"];
            arr['cantidad'] = cantidad;
            arr['precio'] = precio;
            productos.push(arr);

        

        });

        console.log(productos);
    }
</script>