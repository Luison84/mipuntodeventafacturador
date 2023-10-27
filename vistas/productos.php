<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">INVENTARIO / PRODUCTOS</h2>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Inventario / Productos</li>
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

            <div class="col-lg-12">

                <div class="card card-gray shadow collapsed-card">
                    <div class="card-header">
                        <h3 class="card-title">CRITERIOS DE BÚSQUEDA</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-plus"></i>
                            </button>
                            <button type="button" class="btn btn-tool text-warning" id="btnLimpiarBusqueda">
                                <i class="fas fa-times"></i>
                            </button>
                        </div> <!-- ./ end card-tools -->
                    </div> <!-- ./ end card-header -->
                    <div class="card-body py-2">

                        <div class="row">

                            <div class="col-12 col-lg-3 mb-2">

                                <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Código del Producto</label>
                                <input data-index="1" type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="iptCodigoBarras" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                            </div>

                            <div class="col-12 col-lg-3 mb-2">
                                <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-layer-group mr-1 my-text-color"></i> Categorías</label>
                                <select data-index="2" class="form-select" id="id_categoria_busqueda" aria-label="Floating label select example" required>
                                </select>
                            </div>

                            <div class="col-12 col-lg-6 mb-2">
                                <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-gifts mr-1 my-text-color"></i>Producto</label>
                                <input data-index="4" type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="iptProducto" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                            </div>

                            <div class="col-12 col-lg-3 mb-2">
                                <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i> P. Venta Desde</label>
                                <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="iptPrecioVentaDesde" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                            </div>

                            <div class="col-12 col-lg-3 mb-2">
                                <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i> P. Venta Hasta</label>
                                <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="iptPrecioVentaHasta" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                            </div>

                        </div>

                    </div> <!-- ./ end card-body -->

                </div>

            </div>

        </div>

        <!-- row para listado de productos/inventario -->
        <div class="row">
            <div class="col-lg-12">
                <table id="tbl_productos" class="table w-100 shadow border border-secondary">
                    <thead class="bg-main">
                        <tr style="font-size: 15px;">
                            <!-- <th> </th> 0 -->
                            <th class="text-cetner">Op.</th> <!-- 1 -->

                            <th>Codigo</th> <!-- 2 -->

                            <th>Id Categoria</th> <!-- 3 -->



                            <th>Categoría</th> <!-- 5 -->

                            <th>Producto</th> <!-- 6 -->
                            <th>Imagen</th> <!-- 4 -->
                            <th>Id Tipo Afec. IGV</th> <!-- 7 -->
                            <th>Tipo Afec. IGV</th> <!-- 8 -->

                            <th>Id Unidad Medida</th> <!-- 9 -->
                            <th>Unidad Medida</th> <!-- 10 -->

                            <th>Costo Unit.</th> <!-- 11 -->

                            <th>Precio C/IGV</th> <!-- 12 -->
                            <th>Precio S/IGV</th> <!-- 13 -->
                            <th>Precio Mayor C/IGV</th> <!-- 14 -->
                            <th>Precio Mayor S/IGV</th> <!-- 15 -->
                            <th>Precio Oferta C/IGV</th> <!-- 16 -->
                            <th>Precio Oferta S/IGV</th> <!-- 17 -->

                            <th>Stock</th> <!-- 18 -->
                            <th>Min. Stock</th> <!-- 19 -->

                            <th>Ventas</th> <!-- 20 -->

                            <th>Costo Total</th> <!-- 21 -->

                            <th>Fecha Creación</th> <!-- 22 -->
                            <th>Fecha Actualización</th> <!-- 23 -->

                            <th>Estado</th> <!-- 24 -->
                        </tr>
                    </thead>
                    <tbody class="text-small">
                    </tbody>
                </table>
            </div>
        </div>

    </div><!-- /.container-fluid -->

</div>
<!-- /.content -->

<!-- =============================================================================================================================
VENTA MODAL PARA REGISTRAR O ACTUALIZAR UN PRODUCTO 
===============================================================================================================================-->
<div class="modal fade" id="mdlGestionarProducto" role="dialog" tabindex="-1">

    <div class="modal-dialog modal-lg" role="document">

        <!-- contenido del modal -->
        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header bg-gray py-1">

                <h5 class="modal-title text-white text-lg">Registro de Producto</h5>

                <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times text-sm m-0 p-0"></i>
                </button>

            </div>

            <!-- cuerpo del modal -->
            <div class="modal-body">

                <form id="frm-datos-producto" class="needs-validation" novalidate>

                    <!-- Abrimos una fila -->
                    <div class="row">

                        <input type="hidden" name="impuesto_producto" id="impuesto_producto">

                        <!-- CODIGO DE BARRAS -->
                        <div class="col-12 col-lg-6 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color form-label"><i class="fas fa-barcode mr-1 my-text-color"></i>Código del Producto</label>
                            <input type="text" placeholder="Ingrese el código del producto" class="form-control form-control-sm" id="codigo_producto" name="codigo_producto" onchange="validateJS(event, 'codigo_producto')" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                            <div class="invalid-feedback">Ingrese el código del producto</div>
                        </div>

                        <!-- CATEGORIAS -->
                        <div class="col-12 col-lg-6 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-layer-group mr-1 my-text-color"></i>Categoría</label>
                            <select class="form-select" id="id_categoria" name="id_categoria" aria-label="Floating label select example" required>
                            </select>
                            <div class="invalid-feedback">Seleccione la categoría</div>
                        </div>

                        <!-- DESCRIPCION DEL PRODUCTO -->
                        <div class="col-12 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-gifts mr-1 my-text-color"></i>Descripción</label>
                            <input type="text" placeholder="Ingrese la descripción del producto" class="form-control form-control-sm" id="descripcion" name="descripcion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                            <div class="invalid-feedback">Ingrese descripción del producto</div>
                        </div>

                        <!-- TIPO AFECTACIÓN -->
                        <div class="col-12 col-lg-6 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-invoice-dollar mr-1 my-text-color"></i>Tipo Afectación</label>
                            <select class="form-select" id="id_tipo_afectacion_igv" name="id_tipo_afectacion_igv" aria-label="Floating label select example" required>
                            </select>
                            <div class="invalid-feedback">Seleccione el Tipo de Afectación</div>
                        </div>

                        <!-- IMPUESTO -->
                        <div class="col-12 col-lg-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-percentage mr-1 my-text-color"></i>IGV (%)</label>
                            <input type="text" class="form-control form-control-sm" id="impuesto" name="impuesto" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                        </div>

                        <!-- UNIDAD MEDIDA -->
                        <div class="col-12 col-lg-4">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-ruler mr-1 my-text-color"></i>Unidad/Medida</label>
                            <select class="form-select" id="id_unidad_medida" name="id_unidad_medida" aria-label="Floating label select example" required>
                            </select>
                            <div class="invalid-feedback">Seleccione la Unidad de Medida</div>
                        </div>

                        <!-- IMAGEN -->
                        <div class="col-12 mb-2">
                            <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-image mr-1 my-text-color"></i>Seleccione una imagen</label>
                            <!-- <input type="file" class="form-control form-control-sm" id="imagen" name="imagen" accept="image/*" onchange="previewFile(this)"> -->
                            <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" onchange="previewFile(this)">
                        </div>

                        <!-- PREVIEW IMAGEN -->
                        <div class="col-12 col-lg-5">
                            <div style="width: 100%; height: 255px;">
                                <img id="previewImg" src="vistas/assets/imagenes/no_image.jpg" class="border border-secondary" style="object-fit: fill; width: 100%; height: 100%;" alt="">
                            </div>
                        </div>

                        <div class="col-lg-7">

                            <div class="row">

                                <!-- PRECIO DE VENTA (INC. IGV) -->
                                <div class="col-12 col-lg-6 mb-2">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Precio (con IGV)</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese Precio con IGV" class="form-control form-control-sm" id="precio_unitario_con_igv" name="precio_unitario_con_igv" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                </div>

                                <!-- PRECIO DE VENTA (SIN. IGV) -->
                                <div class="col-12 col-lg-6 mb-2">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Precio (sin IGV)</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese Precio sin IGV" class="form-control form-control-sm" id="precio_unitario_sin_igv" name="precio_unitario_sin_igv" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                                </div>

                                <!-- PRECIO DE VENTA x MAYOR (INC. IGV) -->
                                <div class="col-12 col-lg-6 mb-2">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Precio x Mayor (con IGV)</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese Precio x Mayor con IGV" class="form-control form-control-sm" id="precio_unitario_mayor_con_igv" name="precio_unitario_mayor_con_igv" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                </div>

                                <!-- PRECIO DE VENTA x MAYOR (SIN. IGV) -->
                                <div class="col-12 col-lg-6 mb-2">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Precio x Mayor (sin IGV)</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese Precio x Mayor sin IGV" class="form-control form-control-sm" id="precio_unitario_mayor_sin_igv" name="precio_unitario_mayor_sin_igv" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                                </div>

                                <!-- PRECIO VENTA EN OFERTA (INC. IGV) -->
                                <div class="col-12 col-lg-6 mb-2">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Precio Oferta (con IGV)</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese precio oferta con IGV" class="form-control form-control-sm" id="precio_unitario_oferta_con_igv" name="precio_unitario_oferta_con_igv" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                </div>

                                <!-- PRECIO VENTA EN OFERTA (SIN. IGV) -->
                                <div class="col-12 col-lg-6 mb-2">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Precio Oferta (sin IGV)</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese precio oferta sin IGV" class="form-control form-control-sm" id="precio_unitario_oferta_sin_igv" name="precio_unitario_oferta_sin_igv" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                                </div>

                                <!-- MINIMO STOCK -->
                                <div class="col-12 col-lg-12">
                                    <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-dollar-sign mr-1 my-text-color"></i>Stock Mínimo</label>
                                    <input type="number" min="0" step="0.01" value="0.00" placeholder="Ingrese precio oferta con IGV" class="form-control form-control-sm" id="minimo_stock" name="minimo_stock" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                </div>

                            </div>

                        </div>

                        <!-- BOTONERA -->
                        <div class="col-12 text-right">
                            <a class="btn btn-sm btn-danger  fw-bold " id="btnCancelarRegistro" style="position: relative; width: 160px;">
                                <span class="text-button">CANCELAR</span>
                                <span class="btn fw-bold icon-btn-danger ">
                                    <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                </span>
                            </a>

                            <a class="btn btn-sm btn-success  fw-bold " id="btnGuardarProducto" style="position: relative; width: 160px;">
                                <span class="text-button">GUARDAR</span>
                                <span class="btn fw-bold icon-btn-success ">
                                    <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                                </span>
                            </a>
                        </div>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>
<!-- /. End -->

<!-- =============================================================================================================================
VENTA MODAL PARA AUMENTAR O DISMINUIR EL STOCK DEL PRODUCTO
===============================================================================================================================-->
<div class="modal fade" id="mdlGestionarStock" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header bg-gray py-2">
                <h6 class="modal-title" id="titulo_modal_stock">Adicionar Stock</h6>
                <button type="button" class="btn-close text-white fs-6" data-bs-dismiss="modal" aria-label="Close" id="btnCerrarModalStock">
                </button>
            </div>

            <div class="modal-body">

                <div class="row">

                    <div class="col-12 mb-3">
                        <label for="" class="form-label text-primary d-block">Codigo: <span id="stock_codigoProducto" class="text-secondary"></span></label>
                        <label for="" class="form-label text-primary d-block">Producto: <span id="stock_Producto" class="text-secondary"></span></label>
                        <label for="" class="form-label text-primary d-block">Stock: <span id="stock_Stock" class="text-secondary"></span></label>
                    </div>

                    <div class="col-12">
                        <div class="form-group mb-2">
                            <label class="" for="iptStockSumar">
                                <i class="fas fa-plus-circle fs-6"></i> <span class="small" id="titulo_modal_label">Agregar al Stock</span>
                            </label>
                            <input type="number" min="0" class="form-control form-control-sm" id="iptStockSumar" placeholder="Ingrese cantidad a agregar al Stock">
                        </div>
                    </div>

                    <div class="col-12">
                        <label for="" class="form-label text-danger">Nuevo Stock: <span id="stock_NuevoStock" class="text-secondary"></span></label><br>
                    </div>

                </div>

            </div>

            <div class="modal-footer">
                <a class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="btnCancelarRegistroStock">Cancelar</a>
                <a class="btn btn-primary btn-sm" id="btnGuardarNuevorStock">Guardar</a>
            </div>

        </div>
    </div>
</div>
<!-- /. End -->

<script>
    var accion;
    var operacion_stock = ''; // permitar definir si vamos a sumar o restar al stock (1: sumar, 2:restar)

    $(document).ready(function() {

        fnc_InicializarFormulario();

        /*===================================================================*/
        // C R I T E R I O S   D E   B U S Q U E D A  (CODIGO, CATEGORIA Y PRODUCTO)
        /*===================================================================*/
        // BUSQUEDA POR CODIGO DE BARRAS
        $("#iptCodigoBarras").keyup(function() {
            $("#tbl_productos").DataTable().column($(this).data('index')).search(this.value).draw();
        })

        // BUSQUEDA POR CATEGORIAS
        $("#id_categoria_busqueda").change(function() {

            if (this.value != 0) {
                $('#tbl_productos').DataTable().column($(this).data('index')).search('^' + this.value + '$', true, false).draw();
            } else {
                $('#tbl_productos').DataTable().column($(this).data('index')).search("").draw();
            }

        })

        // BUSQUEDA POR DESCRIPCION DE PRODUCTO
        $("#iptProducto").keyup(function() {
            $("#tbl_productos").DataTable().column($(this).data('index')).search(this.value).draw();
        })

        // BUSQUEDA POR RANGO DE PRECIOS
        $("#iptPrecioVentaDesde, #iptPrecioVentaHasta").keyup(function() {
            $("#tbl_productos").DataTable().draw();
        })

        $.fn.dataTable.ext.search.push(

            function(settings, data, dataIndex) {

                var precioDesde = parseFloat($("#iptPrecioVentaDesde").val());
                var precioHasta = parseFloat($("#iptPrecioVentaHasta").val());

                var col_venta = parseFloat(data[11]);

                if ((isNaN(precioDesde) && isNaN(precioHasta)) ||
                    (isNaN(precioDesde) && col_venta <= precioHasta) ||
                    (precioDesde <= col_venta && isNaN(precioHasta)) ||
                    (precioDesde <= col_venta && col_venta <= precioHasta)) {
                    return true;
                }

                return false;
            }
        )

        // LIMPIAR CRITERIOS DE BUSQUEDA
        $("#btnLimpiarBusqueda").on('click', function() {

            $("#iptCodigoBarras").val('')
            CargarSelect(null, $("#id_categoria_busqueda"), "--Todas las categorías--", "ajax/categorias.ajax.php", 'obtener_categorias', null, 1);
            $("#iptProducto").val('')
            $("#iptPrecioVentaDesde").val('')
            $("#iptPrecioVentaHasta").val('')

            $("#tbl_productos").DataTable().search('').columns().search('').draw();
        })

        // LIMPIAR INPUT DE INGRESO DE STOCK AL CERRAR LA VENTANA MODAL
        $("#btnCancelarRegistroStock, #btnCerrarModalStock").on('click', function() {
            $("#iptStockSumar").val("")
        })

        /*===================================================================*/
        // R E G I S T R O   Y   A C T U A L I Z A C I O N   D E   P R O D U C T O S
        /*===================================================================*/
        $("#btnGuardarProducto").on('click', function() {
            fnc_registrarProducto();
        });

        $('#tbl_productos tbody').on('click', '.btnEditarProducto', function() {
            fnc_ModalActualizarProducto($(this));
        })

        $("#btnCancelarRegistro, #btnCerrarModal").on('click', function() {
            fnc_InicializarFormulario();
        })

        $("#precio_unitario_con_igv").on("keyup", function() {

            if ($("#impuesto").val() == '') {
                mensajeToast('warning', 'Seleccione el Tipo de Afectación')
                $("#precio_unitario_con_igv").val('')
                return;
            }

            precio_unitario_con_igv = parseFloat($("#precio_unitario_con_igv").val());
            precio_unitario_sin_igv = parseFloat(precio_unitario_con_igv / (1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
            $("#precio_unitario_sin_igv").val(precio_unitario_sin_igv)
        });

        $("#precio_unitario_mayor_con_igv").on("keyup", function() {

            if ($("#impuesto").val() == '') {
                mensajeToast('warning', 'Seleccione el Tipo de Afectación')
                $("#precio_unitario_con_igv").val('')
                return;
            }

            precio_unitario_mayor_con_igv = parseFloat($("#precio_unitario_mayor_con_igv").val());
            precio_unitario_mayor_sin_igv = parseFloat(precio_unitario_mayor_con_igv / (1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
            $("#precio_unitario_mayor_sin_igv").val(precio_unitario_mayor_sin_igv)
        });

        $("#precio_unitario_oferta_con_igv").on("keyup", function() {

            if ($("#impuesto").val() == '') {
                mensajeToast('warning', 'Seleccione el Tipo de Afectación')
                $("#precio_unitario_con_igv").val('')
                return;
            }

            precio_unitario_oferta_con_igv = parseFloat($("#precio_unitario_oferta_con_igv").val());
            precio_unitario_oferta_sin_igv = parseFloat(precio_unitario_oferta_con_igv / (1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
            $("#precio_unitario_oferta_sin_igv").val(precio_unitario_oferta_sin_igv)
        });

        $('#id_tipo_afectacion_igv').on('change', function(e) {

            $("#impuesto").val('');
            $("#impuesto_producto").val('');

            var formData = new FormData();
            formData.append('accion', 'obtener_impuesto_tipo_operacion')
            formData.append('id_tipo_afectacion', $('#id_tipo_afectacion_igv').val());
            response = SolicitudAjax('ajax/productos.ajax.php', 'POST', formData);

            if (response) {
                $("#impuesto").val(response['impuesto'])
                $("#impuesto_producto").val(response['impuesto']);

                precio_unitario_sin_igv = parseFloat($("#precio_unitario_con_igv").val() / (1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
                $("#precio_unitario_sin_igv").val(precio_unitario_sin_igv);


                precio_unitario_mayor_sin_igv = parseFloat($("#precio_unitario_mayor_con_igv").val() / (1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
                $("#precio_unitario_mayor_sin_igv").val(precio_unitario_mayor_sin_igv);

                precio_unitario_oferta_sin_igv = parseFloat($("#precio_unitario_oferta_con_igv").val() / (1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
                $("#precio_unitario_oferta_sin_igv").val(precio_unitario_oferta_sin_igv);
            }

            // $("#precio_unitario_con_igv").val('');
            // $("#precio_unitario_mayor_con_igv").val('');
            // $("#precio_unitario_oferta_con_igv").val('');
            // $("#precio_unitario_sin_igv").val('');
            // $("#precio_unitario_mayor_sin_igv").val('');
            // $("#precio_unitario_oferta_sin_igv").val('');

        });


        /* ======================================================================================
        A U M E N T A R /  D I S M I N U I R   S T O C K   A L   P R O D U C T O
        =========================================================================================*/
        $('#tbl_productos tbody').on('click', '.btnAumentarStock', function() {
            fnc_ModalAumentarStock($("#tbl_productos").DataTable().row($(this).parents('tr')).data());
        })

        $('#tbl_productos tbody').on('click', '.btnDisminuirStock', function() {
            fnc_ModalDisminuirStock($("#tbl_productos").DataTable().row($(this).parents('tr')).data());
        })

        // CALCULAR NUEVO STOCK (AUMENTAR O DISMINUIR)
        $("#iptStockSumar").keyup(function() {
            fnc_CalcularNuevoStock();
        })

        $("#btnGuardarNuevorStock").on('click', function() {
            fnc_ActualizarStock();
        })

        /* ======================================================================================
        E L I M I N A R   P R O D U C T O
        =========================================================================================*/
        // DESACTIVAR UN PRODUCTO
        $('#tbl_productos tbody').on('click', '.btnDesactivarProducto', function() {
            fnc_DesactivarProducto($('#tbl_productos').DataTable().row($(this).parents('tr')).data());
        })

        // ACTIVAR UN PRODUCTO
        $('#tbl_productos tbody').on('click', '.btnActivarProducto', function() {
            fnc_ActivarProducto($('#tbl_productos').DataTable().row($(this).parents('tr')).data());
        })


    });


    function fnc_InicializarFormulario() {

        fnc_CargarPluginDateTime();
        fnc_cargarSelectCategorias();
        fnc_CargarDataTableInventario();

        $("#mdlGestionarProducto").modal('hide');

        $("#codigo_producto").prop('readonly', false);

        $("#codigo_producto").val('');
        $("#id_categoria").val('');
        $("#descripcion").val('');
        $("#id_tipo_afectacion_igv").val('');
        $("#impuesto").val('');
        $("#id_unidad_medida").val('');
        $("#precio_unitario_con_igv").val('');
        $("#precio_unitario_sin_igv").val('');
        $("#precio_unitario_mayor_con_igv").val('');
        $("#precio_unitario_mayor_sin_igv").val('');
        $("#precio_unitario_oferta_con_igv").val('');
        $("#precio_unitario_oferta_sin_igv").val('');
        $("#minimo_stock").val('');

        $("#iptImagen").val('');
        $("#previewImg").attr("src", "vistas/assets/imagenes/no_image.jpg");

        fnc_cargarSelectCategorias();
    }

    /*===================================================================*/
    // P L U G I N   D A T E T I M E P I C K E R
    /*===================================================================*/
    function fnc_CargarPluginDateTime() {
        $('#iptFechaIngresoFE').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.lang('es', {
                months: 'Enero_Febrero_Marzo_Abril_Mayo_Junio_Julio_Agosto_Septiembre_Octubre_Noviembre_Diciembre'.split('_'),
                monthsShort: 'Enero._Feb._Mar_Abr._May_Jun_Jul._Ago_Sept._Oct._Nov._Dec.'.split('_'),
                weekdays: 'Domingo_Lunes_Martes_Miercoles_Jueves_Viernes_Sabado'.split('_'),
                weekdaysShort: 'Dom._Lun._Mar._Mier._Jue._Vier._Sab.'.split('_'),
                weekdaysMin: 'Do_Lu_Ma_Mi_Ju_Vi_Sa'.split('_')
            })
        });
    }

    /*===================================================================*/
    // C O N S U L T A   D E   P R O D U C T O S  (DATATABLE)
    /*===================================================================*/
    function fnc_CargarDataTableInventario() {

        if ($.fn.DataTable.isDataTable('#tbl_productos')) {
            $('#tbl_productos').DataTable().destroy();
            $('#tbl_productos tbody').empty();
        }

        $("#tbl_productos").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                    text: '<i class="fas fa-sync-alt"></i>',
                    className: 'bg-secondary',
                    action: function(e, dt, node, config) {
                        fnc_CargarDataTableInventario();
                    }
                },
                {
                    text: 'Agregar Producto',
                    className: 'addNewRecord',
                    action: function(e, dt, node, config) {
                        $("#codigo_producto").prop('readonly', false);
                        $(".titulo-modal-productos").html("Registrar Producto")
                        $("#mdlGestionarProducto").modal('show');

                        accion = 'registrar_producto'; //registrar
                        $(".needs-validation").removeClass("was-validated");
                    }
                },
                {
                    extend: 'excel',
                    title: function() {
                        var printTitle = 'LISTADO DE PRODUCTOS';
                        return printTitle
                    }
                },
                {
                    extend: 'print',
                    title: function() {
                        var printTitle = 'LISTADO DE PRODUCTOS';
                        return printTitle
                    }
                }, 'pageLength'
            ],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            ajax: {
                url: "ajax/productos.ajax.php",
                dataSrc: '',
                type: "POST",
                data: {
                    'accion': 'listar_productos' //1: LISTAR PRODUCTOS
                },
            },
            // responsive: {
            //     details: {
            //         type: 'column'
            //     }
            // },

            columnDefs: [
                // {
                //     targets: 0,
                //     orderable: false,
                //     className: 'control'
                // },
                {
                    "className": "dt-center",
                    "targets": "_all"
                },
                {
                    targets: [2, 6, 8, 22, 21],
                    visible: false
                },
                {
                    targets: 17,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (parseFloat(rowData['stock']) <= parseFloat(rowData['minimo_stock'])) {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        }
                    }
                },
                {
                    targets: 5,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData['imagen'] != 'no_image.jpg') {

                            $(td).html('<img src="vistas/assets/imagenes/productos/' + rowData['imagen'] + '" class="zoom rounded-pill border text-center border-secondary" style="object-fit: cover; width: 40px; height: 40px; transition: transform .5s;overflow:hidden" alt="">')
                            $(td).css('overflow', 'hidden')
                        } else {
                            $(td).html('<img src="vistas/assets/imagenes/no_image.jpg" class="rounded-pill border text-center border-secondary" style="object-fit: cover; width: 40px; height: 40px;" alt="">')
                        }

                        // if (rowData['imagen'] != 'no_image.jpg') {
                        //     $(td).html('<img src="vistas/assets/imagenes/productos/' + rowData['imagen'] + '" class="rounded-pill border text-center border-secondary" style="object-fit: cover; width: 40px; height: 40px;" alt="">')
                        // } else {
                        //     $(td).html('<img src="vistas/assets/imagenes/no_image.jpg" class="rounded-pill border text-center border-secondary" style="object-fit: cover; width: 40px; height: 40px;" alt="">')
                        // }
                    }
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                        // $(td).html("<span class='btnEditarProducto text-primary px-1' style='cursor:pointer;'>" +
                        //     "<i class='fas fa-pencil-alt fs-6'></i>" +
                        //     "</span>")

                        // if (parseInt(rowData['costo_unitario']) > 0) {
                        //     $(td).append("<span class='btnAumentarStock text-success px-1' style='cursor:pointer;'>" +
                        //         "<i class='fas fa-plus-circle fs-6'></i>" +
                        //         "</span>" +
                        //         "<span class='btnDisminuirStock text-warning px-1' style='cursor:pointer;'>" +
                        //         "<i class='fas fa-minus-circle fs-6'></i>" +
                        //         "</span>");
                        // }
                        // if (rowData['estado'] == 'INACTIVO') {

                        //     $(td).append("<span class='btnActivarProducto text-danger px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Activar Producto'>" +
                        //         "<i class='fas fa-toggle-off fs-6 text-danger'> </i> " +
                        //         "</span>")
                        // } else {
                        //     $(td).append("<span class='btnDesactivarProducto text-danger px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Desactivar Producto'>" +
                        //         "<i class='fas fa-toggle-on fs-6 text-success'> </i> " +
                        //         "</span>")
                        // }
                        $(td).html(`
                                    <div class="btn-group" >
                                        <button class="btn btn-sm dropdown-toggle p-0 m-0 my-text-color fs-5" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-cogs"></i>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item btnEditarProducto" style='cursor:pointer;'><i class='fas fa-pencil-alt fs-6 text-primary mr-2'></i> <span class='my-color'>Editar</span>
                                            </a>
                                        </div>
                                    </div>
                        `)


                        if (parseInt(rowData['costo_unitario']) > 0) {
                            $(td).html(`
                                    <div class="btn-group" >
                                        <button class="btn btn-sm dropdown-toggle p-0 m-0 my-text-color fs-5" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-cogs"></i>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item btnEditarProducto" style='cursor:pointer;'><i class='fas fa-pencil-alt fs-6 text-primary mr-2'></i> <span class='my-color'>Editar</span></a>                                            

                                            <a class="dropdown-item btnAumentarStock" style='cursor:pointer;'><i class='fas fa-plus-circle fs-6 mr-2 text-success'></i> <span class='my-color'>Aumentar Stock</span></a>                                            

                                            <a class="dropdown-item btnDisminuirStock" style='cursor:pointer;'><i class='fas fa-minus-circle fs-6 mr-2 text-warning'></i> <span class='my-color'>Disminuir Stock</span></a>
                                        </div>
                                    </div>`)
                        }

                        if (rowData['estado'] == 'INACTIVO') {
                            $(td).html(`
                                    <div class="btn-group" >
                                        <button class="btn btn-sm dropdown-toggle p-0 m-0 my-text-color fs-5" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-cogs"></i>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item btnEditarProducto" style='cursor:pointer;'><i class='fas fa-pencil-alt fs-6 text-primary mr-2'></i> <span class='my-color'>Editar</span></a>                                            
                                            <a class="dropdown-item btnAumentarStock" style='cursor:pointer;'><i class='fas fa-plus-circle fs-6 mr-2 text-success'></i> <span class='my-color'>Aumentar Stock</span></a>                                            
                                            <a class="dropdown-item btnDisminuirStock" style='cursor:pointer;'><i class='fas fa-minus-circle fs-6 mr-2 text-warning'></i> <span class='my-color'>Disminuir Stock</span></a>                                            
                                            <a class="dropdown-item btnActivarProducto" style='cursor:pointer;'><i class='fas fa-toggle-off fs-6 text-danger mr-2'> </i> <span class='my-color'>Activar</span></a>
                                        </div>
                                    </div>`)
                        } else {
                            $(td).html(`
                                    <div class="btn-group" >
                                        <button class="btn btn-sm dropdown-toggle p-0 m-0 my-text-color fs-5" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-cogs"></i>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item btnEditarProducto" style='cursor:pointer;'><i class='fas fa-pencil-alt fs-6 text-primary mr-2'></i> <span class='my-color'>Editar</span></a>                                            
                                            <a class="dropdown-item btnAumentarStock" style='cursor:pointer;'><i class='fas fa-plus-circle fs-6 mr-2 text-success'></i> <span class='my-color'>Aumentar Stock</span></a>                                            
                                            <a class="dropdown-item btnDisminuirStock" style='cursor:pointer;'><i class='fas fa-minus-circle fs-6 mr-2 text-warning'></i> <span class='my-color'>Disminuir Stock</span></a>                                            
                                            <a class="dropdown-item btnDesactivarProducto" style='cursor:pointer;'><i class='fas fa-toggle-on fs-6 text-success mr-2'> </i> <span class='my-color'>Desactivar</span></a>
                                        </div>
                                    </div>`)
                        }

                    }
                }

            ],
            scrollX: true,
            // autoWidth: true,
            scrollY: "50vh",
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });

    }


    /*===================================================================*/
    // R E G I S T R O   Y   A C T U A L I Z A C I O N   D E   P R O D U C T O S
    /*===================================================================*/
    function fnc_ModalActualizarProducto(fila_actualizar) {
        accion = 'actualizar_producto'; //seteamos la accion para editar
        $(".titulo-modal-productos").html("Editar Producto")
        $("#mdlGestionarProducto").modal('show');

        var data = (fila_actualizar.parents('tr').hasClass('child')) ?
            $("#tbl_productos").DataTable().row(fila_actualizar.parents().prev('tr')).data() :
            $("#tbl_productos").DataTable().row(fila_actualizar.parents('tr')).data();

        $("#codigo_producto").prop('readonly', true);

        $("#codigo_producto").val(data["codigo_producto"]);
        $("#id_categoria").val(data['id_categoria']).change();
        $("#descripcion").val(data['producto']);
        $("#id_tipo_afectacion_igv").val(data['id_tipo_afectacion_igv']).change();

        var formData = new FormData();
        formData.append('accion', 'obtener_impuesto_tipo_operacion')
        formData.append('id_tipo_afectacion', $('#id_tipo_afectacion_igv').val());
        response = SolicitudAjax('ajax/productos.ajax.php', 'POST', formData);

        if (response) {
            $("#impuesto").val(response['impuesto'] + ' %')
            $("#impuesto_producto").val(response['impuesto']);
        }
        $("#id_unidad_medida").val(data['id_unidad_medida']).change();
        $("#previewImg").attr("src", 'vistas/assets/imagenes/productos/' + (data['imagen'] ? data['imagen'] : 'no_image.jpg'));
        $("#precio_unitario_con_igv").val(data['precio_unitario_con_igv']);
        $("#precio_unitario_sin_igv").val(data['precio_unitario_sin_igv']);
        $("#precio_unitario_mayor_con_igv").val(data['precio_unitario_mayor_con_igv']);
        $("#precio_unitario_mayor_sin_igv").val(data['precio_unitario_mayor_sin_igv']);
        $("#precio_unitario_oferta_con_igv").val(data['precio_unitario_oferta_con_igv']);
        $("#precio_unitario_oferta_sin_igv").val(data['precio_unitario_oferta_sin_igv']);
        $("#minimo_stock").val(data['minimo_stock']);
    }

    function fnc_registrarProducto() {


        var formData = new FormData();

        formData.append('detalle_producto', $("#frm-datos-producto").serialize());
        formData.append('accion', accion)

        var imagen_valida = true;

        var forms = document.getElementsByClassName('needs-validation');

        var validation = Array.prototype.filter.call(forms, function(form) {

            if (form.checkValidity() === true) {

                var file = $("#imagen").val();

                if (file) {

                    var ext = file.substring(file.lastIndexOf("."));

                    if (ext != ".jpg" && ext != ".png" && ext != ".gif" && ext != ".jpeg" && ext != ".webp") {
                        mensajeToast('error', "La extensión " + ext + " no es una imagen válida");
                        imagen_valida = false;
                    }

                    if (!imagen_valida) {
                        return;
                    }

                    const inputImage = document.querySelector('#imagen');
                    formData.append('archivo[]', inputImage.files[0])
                }

                Swal.fire({
                    title: 'Está seguro de registrar el producto?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Si, deseo registrarlo!',
                    cancelButtonText: 'Cancelar',
                }).then((result) => {

                    if (result.isConfirmed) {

                        response = SolicitudAjax("ajax/productos.ajax.php", "POST", formData);

                        // mensajeToast(response["tipo_msj"], response["msj"])
                        Swal.fire({
                            position: 'top-center',
                            icon: response["tipo_msj"],
                            title: response["msj"],
                            showConfirmButton: true,
                            timer: 2000
                        })

                        if (response["tipo_msj"] == "success") {
                            $("#tbl_productos").DataTable().ajax.reload();
                            fnc_InicializarFormulario();
                        }

                    }
                })
            } else {
                mensajeToast('warning', 'Complete los campos obligatorios.!')
            }

            form.classList.add('was-validated');

        });

    }


    /* ======================================================================================
    E L I M I N A R   P R O D U C T O
    =========================================================================================*/
    function fnc_eliminarProducto(codigo_producto) {

        Swal.fire({
            title: 'Está seguro de eliminar el producto?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo eliminarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {
                var formData = new FormData();

                formData.append('accion', 'eliminar_producto')
                formData.append('codigo_producto', codigo_producto);

                response = SolicitudAjax("ajax/productos.ajax.php", "POST", formData);
                mensajeToast(response["tipo_msj"], response["msj"]);
                $("#tbl_productos").DataTable().ajax.reload();
            }

        });


    }

    function fnc_DesactivarProducto(data) {

        var codigo_producto = data['codigo_producto'];
        Swal.fire({
            title: 'Está seguro de desactivar el Producto: ' + data['descripcion_producto'] + '?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Aceptar!',
            cancelButtonText: 'Cancelar!',
        }).then((result) => {
            if (result.isConfirmed) {

                if (result.isConfirmed) {

                    var datos = new FormData();

                    datos.append('accion', 'desactivar_producto');
                    datos.append('codigo_producto', codigo_producto);

                    response = SolicitudAjax('ajax/productos.ajax.php', 'POST', datos)

                    mensajeToast(response["tipo_msj"], response["msj"])
                    $('#tbl_productos').DataTable().ajax.reload(null, false);

                }

            }
        })
    }

    function fnc_ActivarProducto(data) {

        var codigo_producto = data['codigo_producto'];

        Swal.fire({
            title: 'Está seguro de activar el Producto: ' + data['descripcion_producto'] + '?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Aceptar!',
            cancelButtonText: 'Cancelar!',
        }).then((result) => {
            if (result.isConfirmed) {

                if (result.isConfirmed) {

                    var datos = new FormData();

                    datos.append('accion', 'activar_producto');
                    datos.append('codigo_producto', codigo_producto);

                    response = SolicitudAjax('ajax/productos.ajax.php', 'POST', datos)

                    mensajeToast(response["tipo_msj"], response["msj"])
                    $('#tbl_productos').DataTable().ajax.reload(null, false);

                }

            }
        })
    }


    /* ======================================================================================
    A U M E N T A R /  D I S M I N U I R   S T O C K   A L   P R O D U C T O
    =========================================================================================*/
    function fnc_ModalAumentarStock(data) {

        operacion_stock = 'aumentar_stock'; //sumar stock
        accion = 3;

        $("#mdlGestionarStock").modal('show'); //MOSTRAR VENTANA MODAL

        $("#titulo_modal_stock").html('Aumentar Stock'); // CAMBIAR EL TITULO DE LA VENTANA MODAL
        $("#titulo_modal_label").html('Agregar al Stock'); // CAMBIAR EL TEXTO DEL LABEL DEL INPUT PARA INGRESO DE STOCK
        $("#iptStockSumar").attr("placeholder", "Ingrese cantidad a agregar al Stock"); //CAMBIAR EL PLACEHOLDER 

        $("#stock_codigoProducto").html(data['codigo_producto']) //CODIGO DEL PRODUCTO DEL DATATABLE
        $("#stock_Producto").html(data['producto']) //NOMBRE DEL PRODUCTO DEL DATATABLE
        $("#stock_Stock").html(data['stock']) //STOCK ACTUAL DEL PRODUCTO DEL DATATABLE

        $("#stock_NuevoStock").html(parseFloat($("#stock_Stock").html()));
    }

    function fnc_ModalDisminuirStock(data) {

        operacion_stock = 'disminuir_stock'; //restar stock
        accion = 3;
        $("#mdlGestionarStock").modal('show'); //MOSTRAR VENTANA MODAL

        $("#titulo_modal_stock").html('Disminuir Stock'); // CAMBIAR EL TITULO DE LA VENTANA MODAL
        $("#titulo_modal_label").html('Disminuir al Stock'); // CAMBIAR EL TEXTO DEL LABEL DEL INPUT PARA INGRESO DE STOCK
        $("#iptStockSumar").attr("placeholder", "Ingrese cantidad a disminuir al Stock"); //CAMBIAR EL PLACEHOLDER 

        $("#stock_codigoProducto").html(data['codigo_producto']) //CODIGO DEL PRODUCTO DEL DATATABLE
        $("#stock_Producto").html(data['producto']) //NOMBRE DEL PRODUCTO DEL DATATABLE
        $("#stock_Stock").html(data['stock']) //STOCK ACTUAL DEL PRODUCTO DEL DATATABLE

        $("#stock_NuevoStock").html(parseFloat($("#stock_Stock").html()));

    }

    function fnc_CalcularNuevoStock() {
        if (operacion_stock == 'aumentar_stock') {

            if ($("#iptStockSumar").val() != "" && $("#iptStockSumar").val() > 0) {

                var stockActual = parseFloat($("#stock_Stock").html());
                var cantidadAgregar = parseFloat($("#iptStockSumar").val());

                $("#stock_NuevoStock").html(stockActual + cantidadAgregar);

            } else {

                mensajeToast('error', 'Ingrese un valor mayor a 0');

                $("#iptStockSumar").val("")
                $("#stock_NuevoStock").html(parseFloat($("#stock_Stock").html()));

            }

        } else {

            if ($("#iptStockSumar").val() != "" && $("#iptStockSumar").val() > 0) {

                var stockActual = parseFloat($("#stock_Stock").html());
                var cantidadAgregar = parseFloat($("#iptStockSumar").val());

                $("#stock_NuevoStock").html(stockActual - cantidadAgregar);

                if (parseInt($("#stock_NuevoStock").html()) < 0) {

                    mensajeToast('error', 'La cantidad a disminuir no puede ser mayor al stock actual (Nuevo stock < 0)');

                    $("#iptStockSumar").val("");
                    $("#iptStockSumar").focus();
                    $("#stock_NuevoStock").html(parseFloat($("#stock_Stock").html()));
                }
            } else {

                mensajeToast('error', 'Ingrese un valor mayor a 0');

                $("#iptStockSumar").val("")
                $("#stock_NuevoStock").html(parseFloat($("#stock_Stock").html()));
            }
        }
    }

    // CALCULA LA UTILIDAD
    function calcularUtilidad() {

        var iptPrecioCompraReg = $("#iptPrecioCompraReg").val();
        var iptPrecioVentaReg = $("#iptPrecioVentaReg").val();
        var Utilidad = iptPrecioVentaReg - iptPrecioCompraReg;

    }

    function fnc_ActualizarStock() {

        if ($("#iptStockSumar").val() != "" && $("#iptStockSumar").val() > 0) {

            var nuevoStock = parseFloat($("#stock_NuevoStock").html()),
                codigo_producto = $("#stock_codigoProducto").html();

            var datos = new FormData();

            datos.append('accion', 'aumentar_disminuir_stock');
            datos.append('nuevoStock', nuevoStock);
            datos.append('codigo_producto', codigo_producto);
            datos.append('tipo_movimiento', operacion_stock);

            //Solicitud para verificar el Stock del Producto
            response = SolicitudAjax("ajax/productos.ajax.php", "POST", datos);

            if (response["tipo_msj"] == "success") {
                $("#stock_NuevoStock").html("");
                $("#iptStockSumar").val("");

                $("#mdlGestionarStock").modal('hide');

                $("#tbl_productos").DataTable().ajax.reload();
                mensajeToast(response["tipo_msj"], response["msj"])
            }


        } else {
            mensajeToast('error', 'Debe ingresar la cantidad a aumentar');
            return false;
        }
    }


    /* ======================================================================================
    G E N E R A L E S
    =========================================================================================*/
    // LIMPIAR INPUTS DEL FORMULARIO DE REGISTRO


    // PREVISUALIZAR LA IMAGEN
    function previewFile(input) {

        var file = $("input[type=file]").get(0).files[0];

        if (file) {
            var reader = new FileReader();

            reader.onload = function() {
                $("#previewImg").attr("src", reader.result);
            }

            reader.readAsDataURL(file);
        }
    }

    // CARGAR SELECT DE CATEGORIAS
    function fnc_cargarSelectCategorias() {
        CargarSelect(null, $("#id_categoria_busqueda"), "--Todas las categorías--", "ajax/categorias.ajax.php", 'obtener_categorias', null, 1);
        CargarSelect(null, $("#id_categoria"), "--Seleccione una categoría--", "ajax/categorias.ajax.php", 'obtener_categorias');
        CargarSelect(null, $("#id_tipo_afectacion_igv"), "--Seleccione Tipo de Afectación IGV--", "ajax/productos.ajax.php", 'listar_tipo_afectacion');
        CargarSelect(null, $("#id_unidad_medida"), "--Seleccione una Unidad/Medida--", "ajax/productos.ajax.php", 'listar_unidad_medida');
    }

    function dropmenuPostion() {
        // hold onto the drop down menu                                             
        var dropdownMenu;

        $(window).on('show.bs.dropdown', function(e) {
            // grab the menu
            dropdownMenu = $(e.target).find('.dropdown-menu');
            // detach it and append it to the body
            $('body').append(dropdownMenu.detach());

            // grab the new offset position
            var eOffset = $(e.target).offset();

            // make sure to place it where it would normally go (this
            // could be
            // improved)
            dropdownMenu.css({
                'display': 'block',
                'top': eOffset.top + $(e.target).outerHeight(),
                'left': eOffset.left,
                'min-width': '80px'
            });
        });

        // and when you hide it, reattach the drop down, and hide it
        // normally
        $(window).on('hide.bs.dropdown', function(e) {
            $(e.target).append(dropdownMenu.detach());
            dropdownMenu.hide();
        });

        // // and when you show it, move it to the body                                     
        // $(window).on('show.bs.dropdown', function(e) {

        //     // grab the menu        
        //     dropdownMenu = $(e.target).find('.dropdown-menu');

        //     // detach it and append it to the body
        //     $('body').append(dropdownMenu.detach());

        //     // grab the new offset position
        //     var eOffset = $(e.target).offset();

        //     // make sure to place it where it would normally go (this could be improved)
        //     dropdownMenu.css({
        //         'display': 'block',
        //         'top': eOffset.top + $(e.target).outerHeight(),
        //         'left': eOffset.left - 50
        //     });
        // });

        // // and when you hide it, reattach the drop down, and hide it normally                                                   
        // $(window).on('hide.bs.dropdown', function(e) {
        //     $(e.target).append(dropdownMenu.detach());
        //     dropdownMenu.hide();
        // });
    }
</script>