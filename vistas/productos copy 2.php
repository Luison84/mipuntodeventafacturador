<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">INVENTARIO / PRODUCTOS</h2>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Inicio</a></li>
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

                <div class="card card-gray shadow">
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
                    <div class="card-body">

                        <div class="row">

                            <div class="d-none d-md-flex col-md-12 ">

                                <div style="width: 20%;" class="form-floating mx-1">
                                    <input type="text" id="iptCodigoBarras" class="form-control" data-index="2">
                                    <label for="iptCodigoBarras">Código de Barras</label>
                                </div>

                                <div style="width: 20%;" class="form-floating mx-1">
                                    <select class="form-select" id="selCategorias" data-index="3" aria-label="Floating label select example">
                                    </select>
                                    <label for="floatingSelect">Categorías</label>
                                </div>

                                <div style="width: 20%;" class="form-floating mx-1">
                                    <input type="text" id="iptProducto" class="form-control" data-index="6">
                                    <label for="iptProducto">Producto</label>
                                </div>

                                <div style="width: 20%;" class="form-floating mx-1">
                                    <input type="text" id="iptPrecioVentaDesde" class="form-control">
                                    <label for="iptPrecioVentaDesde">P. Venta Desde</label>
                                </div>

                                <div style="width: 20%;" class="form-floating mx-1">
                                    <input type="text" id="iptPrecioVentaHasta" class="form-control">
                                    <label for="iptPrecioVentaHasta">P. Venta Hasta</label>
                                </div>
                            </div>

                        </div>
                    </div> <!-- ./ end card-body -->
                </div>

            </div>

        </div>

        <!-- row para listado de productos/inventario -->
        <div class="row">
            <div class="col-lg-12">
                <table id="tbl_productos" class="table table-striped w-100 shadow border border-secondary">
                    <thead class="bg-gray">
                        <tr style="font-size: 15px;">
                            <th> </th> <!-- 0 -->
                            <th class="text-cetner">Opciones</th> <!-- 1 -->
                            <th>Codigo</th> <!-- 2 -->
                            <th>Id Categoria</th> <!-- 3 -->
                            <th>Imagen</th> <!-- 4 -->
                            <th>Categoría</th> <!-- 5 -->
                            <th>Producto</th> <!-- 6 -->
                            <th>P. Compra</th> <!-- 7 -->
                            <th>P. Venta</th> <!-- 8 -->
                            <th>P. Venta Mayor</th> <!-- 9 -->
                            <th>P. Venta Oferta</th> <!-- 10 -->
                            <th>Stock</th> <!-- 11 -->
                            <th>Min. Stock</th> <!-- 12 -->
                            <th>Ventas</th> <!-- 13 -->
                            <th>Costo Total</th> <!-- 14 -->
                            <th>Fecha Creación</th> <!-- 15 -->
                            <th>Fecha Actualización</th> <!-- 16 -->
                            <th>Estado</th> <!-- 17 -->
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
<div class="modal fade" id="mdlGestionarProducto" role="dialog">

    <div class="modal-dialog modal-lg" role="document">

        <!-- contenido del modal -->
        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header bg-gray py-1">

                <h5 class="modal-title">Agregar Producto</h5>

                <button type="button" class="btn btn-outline-primary text-white border-0 fs-5" data-bs-dismiss="modal" id="btnCerrarModal">
                    <i class="far fa-times-circle"></i>
                </button>

            </div>

            <!-- cuerpo del modal -->
            <div class="modal-body">

                <form id="frm-datos-producto" class="needs-validation" novalidate>

                    <!-- Abrimos una fila -->
                    <div class="row">

                        <!-- CODIGO DE BARRAS -->
                        <div class="col-12 col-lg-6">

                            <div class="form-floating mb-2">

                                <input type="text" id="iptCodigoReg" class="form-control" name="iptCodigoReg" data-index="1" required>
                                <label for="iptCodigoReg">Código de Barras</label>

                                <!-- <div class="invalid-feedback">Ingrese el codigo de barras</div> -->

                            </div>

                        </div>

                        <!-- CATEGORIAS -->
                        <div class="col-12 col-lg-6">

                            <div class="form-floating mb-2">

                                <select class="form-select" id="selCategoriaReg" name="selCategoriaReg" data-index="1" aria-label="Floating label select example" required>
                                </select>
                                <label for="selCategoriaReg">Categorías</label>

                                <!-- <div class="invalid-feedback">Seleccione la categoría</div> -->

                            </div>

                        </div>

                        <!-- IMAGEN -->
                        <div class="col-12">
                            <div class="form-group mb-2">
                                <input type="file" class="form-control form-control-sm" id="iptImagen" name="iptImagen" accept="image/*" onchange="previewFile(this)">
                            </div>
                        </div>

                        <!-- PREVIEW IMAGEN -->
                        <div class="col-12 col-lg-5">
                            <div style="width: 100%; height: 190px;">
                                <img id="previewImg" src="vistas/assets/imagenes/no_image.jpg" class="border border-secondary" style="object-fit: contain; width: 100%; height: 100%;" alt="">
                            </div>
                        </div>

                        <div class="col-lg-7">

                            <div class="row">

                                <!-- DESCRIPCION DEL PRODUCTO -->
                                <div class="col-12">

                                    <div class="form-floating mb-2">

                                        <input type="text" class="form-control text-uppercase" id="iptDescripcionReg" name="iptDescripcionReg" required>
                                        <label for="iptDescripcionReg">Descripción</label>

                                        <div class="invalid-feedback">Ingrese la descripción</div>

                                    </div>

                                </div>

                                <!-- PRECIO DE VENTA (INC. IGV) -->
                                <div class="col-12 col-lg-6">

                                    <div class="form-floating mb-2">

                                        <input type="number" min="0" class="form-control form-control-sm" id="precio_venta" name="precio_venta" step="0.01" required>
                                        <label for="precio_venta">Precio Venta</label>
                                        <!-- <div class="invalid-feedback">Ingrese el precio de venta</div> -->
                                    </div>

                                </div>

                                <!-- PRECIO DE VENTA (SIN. IGV) -->
                                <div class="col-12 col-lg-6">

                                    <div class="form-floating mb-2">

                                        <input type="number" min="0" class="form-control form-control-sm" id="iptPrecioVentaReg" name="iptPrecioVentaReg" step="0.01" required>
                                        <label for="iptPrecioVentaReg">Precio Venta</label>
                                        <!-- <div class="invalid-feedback">Ingrese el precio de venta</div> -->
                                    </div>

                                </div>

                                <!-- PRECIO DE VENTA x MAYOR (INC. IGV) -->
                                <div class="col-12 col-lg-6">

                                    <div class="form-floating mb-2">

                                        <input type="number" min="0" class="form-control form-control-sm" id="iptPrecioVentaMayorReg" name="iptPrecioVentaMayorReg" step="0.01">
                                        <label for="iptPrecioVentaMayorReg">Precio Venta x Mayor</label>

                                    </div>

                                </div>
                                
                                <!-- PRECIO DE VENTA x MAYOR (SIN. IGV) -->
                                
                                
                                <!-- PRECIO VENTA EN OFERTA (INC. IGV) -->
                                <div class="col-12 col-lg-6">

                                    <div class="form-floating mb-2">

                                        <input type="number" min="0" class="form-control form-control-sm" id="iptPrecioVentaOfertaReg" name="iptPrecioVentaOfertaReg" step="0.01">
                                        <label for="iptPrecioVentaOfertaReg">Precio Venta Oferta</label>

                                    </div>

                                </div>

                                <!-- PRECIO VENTA EN OFERTA (SIN. IGV) -->


                                <!-- MINIMO STOCK -->
                                <div class="col-12 col-lg-6">

                                    <div class="form-floating mb-2">

                                        <input type="number" min="0" class="form-control form-control-sm" id="iptMinimoStockReg" name="iptMinimoStockReg">
                                        <label for="iptStockReg">Mínimo Stock</label>

                                    </div>

                                </div>
                            </div>

                        </div>

                        <!-- BOTONERA -->
                        <div class="col-12 text-right">
                            
                            <a type="button" class="btn btn-danger mt-1 mx-1" style="width:170px;" data-bs-dismiss="modal" id="btnCancelarRegistro">Cancelar</a>
                            <a style="width:170px;" class="btn btn-primary mt-1 mx-1" id="btnGuardarProducto">Guardar Producto</a>
                            
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

        fnc_cargarSelectCategorias();
        fnc_CargarDataTableInventario();

        /*===================================================================*/
        // C R I T E R I O S   D E   B U S Q U E D A  (CODIGO, CATEGORIA Y PRODUCTO)
        /*===================================================================*/
        // BUSQUEDA POR CODIGO DE BARRAS
        $("#iptCodigoBarras").keyup(function() {
            $("#tbl_productos").DataTable().column($(this).data('index')).search(this.value).draw();
        })

        // BUSQUEDA POR CATEGORIAS
        $("#selCategorias").change(function() {

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

                var col_venta = parseFloat(data[8]);

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
            $("#selCategorias").val('0')
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
            fnc_limpiarFormulario();
        })


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

        // $('#tbl_productos tbody').on('click', '.btnEliminarProducto', function() {
        //     fnc_eliminarProducto($("#tbl_productos").DataTable().row($(this).parents('tr')).data()[1]);
        // })


    });


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
            responsive: {
                details: {
                    type: 'column'
                }
            },
            columnDefs: [{
                    targets: 0,
                    orderable: false,
                    className: 'control'
                },
                {
                    targets: [3],
                    visible: false
                },
                {
                    targets: 11,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (parseFloat(rowData['stock_producto']) <= parseFloat(rowData['minimo_stock_producto'])) {
                            $(td).parent().css('background', '#FF5733')
                            $(td).parent().css('color', '#ffffff')
                        }
                    }
                },
                {
                    targets: 4,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData['imagen_producto']) {
                            $(td).html('<img src="vistas/assets/imagenes/productos/' + rowData['imagen_producto'] + '" class="border text-center border-secondary zoom" style="object-fit: cover; width: 60px; height: 60px; transition: transform .2s;" alt="">')
                        } else {
                            $(td).html('<img src="vistas/assets/imagenes/no_image.jpg" class="border text-center border-secondary" style="object-fit: cover; width: 60px; height: 60px;" alt="">')
                        }
                    }
                },
                {
                    targets: 1,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        $(td).html("<span class='btnEditarProducto text-primary px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-pencil-alt fs-5'></i>" +
                            "</span>")

                        if(parseInt(rowData['precio_compra_producto']) > 0){
                            $(td).append( "<span class='btnAumentarStock text-success px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-plus-circle fs-5'></i>" +
                            "</span>" +
                            "<span class='btnDisminuirStock text-warning px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-minus-circle fs-5'></i>" +
                            "</span>" );
                        }
                        if (parseInt(rowData[17]) == 0) {
                            $(td).append("<span class='btnActivarProducto text-danger px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Activar Producto'>" +
                                "<i class='fas fa-toggle-off fs-5 text-danger'> </i> " +
                                "</span>")
                        } else {
                            $(td).append("<span class='btnDesactivarProducto text-danger px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Desactivar Producto'>" +
                                "<i class='fas fa-toggle-on fs-5 text-success'> </i> " +
                                "</span>")
                        }
                    }
                }

            ],
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

        $("#mdlGestionarProducto").modal('show');

        var data = (fila_actualizar.parents('tr').hasClass('child')) ?
            $("#tbl_productos").DataTable().row(fila_actualizar.parents().prev('tr')).data() :
            $("#tbl_productos").DataTable().row(fila_actualizar.parents('tr')).data();

        $("#iptCodigoReg").prop('readonly', true);

        $("#iptCodigoReg").val(data["codigo_producto"]);
        $("#selCategoriaReg").val(data['id_categoria_producto']);
        $("#previewImg").attr("src", 'vistas/assets/imagenes/productos/' + (data['imagen_producto'] ? data['imagen_producto'] : 'no_image.jpg'));
        $("#iptDescripcionReg").val(data['descripcion_producto']);
        $("#iptPrecioVentaReg").val(data['precio_venta_producto']);
        $("#iptPrecioVentaMayorReg").val(data['precio_mayor_producto']);
        $("#iptPrecioVentaOfertaReg").val(data['precio_oferta_producto']);
        $("#iptMinimoStockReg").val(data['minimo_stock_producto'].replace(' Und(s)', '').replace(' Kg(s)', ''));
    }

    function fnc_registrarProducto() {

        var formData = new FormData();

        formData.append('detalle_producto', $("#frm-datos-producto").serialize());
        formData.append('accion', accion)

        var imagen_valida = true;

        var forms = document.getElementsByClassName('needs-validation');

        var validation = Array.prototype.filter.call(forms, function(form) {

            if (form.checkValidity() === true) {

                var file = $("#iptImagen").val();

                if (file) {

                    var ext = file.substring(file.lastIndexOf("."));

                    if (ext != ".jpg" && ext != ".png" && ext != ".gif" && ext != ".jpeg" && ext != ".webp") {
                        mensajeToast('error', "La extensión " + ext + " no es una imagen válida");
                        imagen_valida = false;
                    }

                    if (!imagen_valida) {
                        return;
                    }

                    const inputImage = document.querySelector('#iptImagen');
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

                        mensajeToast(response["tipo_msj"], response["msj"])

                        if (response["tipo_msj"] == "success") {
                            $("#tbl_productos").DataTable().ajax.reload();
                            fnc_limpiarFormulario();
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
        $("#stock_Producto").html(data['descripcion_producto']) //NOMBRE DEL PRODUCTO DEL DATATABLE
        $("#stock_Stock").html(data['stock_producto']) //STOCK ACTUAL DEL PRODUCTO DEL DATATABLE

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
        $("#stock_Producto").html(data['descripcion_producto']) //NOMBRE DEL PRODUCTO DEL DATATABLE
        $("#stock_Stock").html(data['stock_producto']) //STOCK ACTUAL DEL PRODUCTO DEL DATATABLE

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
    function fnc_limpiarFormulario() {

        $("#mdlGestionarProducto").modal('hide');

        $("#iptCodigoReg").prop('readonly', false);
        $("#iptCodigoReg").val("");
        $("#selCategoriaReg").val(0);
        $("#iptDescripcionReg").val("");
        $("#iptPrecioCompraReg").val("");
        $("#iptPrecioVentaReg").val("");
        $("#iptPrecioVentaMayorReg").val("");
        $("#iptPrecioVentaOfertaReg").val("");
        $("#iptStockReg").val("");
        $("#iptMinimoStockReg").val("");

        $("#iptImagen").val('');
        $("#previewImg").attr("src", "vistas/assets/imagenes/no_image.jpg");
    }

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

        CargarSelect(null, $("#selCategoriaReg"), "--Seleccione una categoría--", "ajax/categorias.ajax.php", 'listar_categorias');

        var datos = new FormData();
        datos.append('accion', 'listar_categorias');

        $.ajax({
            async: false,
            url: "ajax/categorias.ajax.php",
            type: 'POST',
            data: datos,
            cache: false,
            contentType: false,
            processData: false,
            dataType: 'json',

            success: function(respuesta) {

                $("#selCategorias").html('');

                var options = '<option selected value="0">Todas las categorías</option>';


                for (let index = 0; index < respuesta.length; index++) {
                    options = options + '<option value=' + respuesta[index][0] + '>' + respuesta[index][1] + '</option>';
                }

                $("#selCategorias").append(options);


            }
        });

    }
</script>