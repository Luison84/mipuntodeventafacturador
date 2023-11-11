<!-- Content Header (Page header) -->
<div class="content-header pb-1">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">ADMINISTRAR COMPRAS</h2>
            </div><!-- /.col -->
            <div class="col-sm-6  d-none d-md-block">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Administrar Compras</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<div class="content">

    <div class="row">

        <div class="col-12 ">

            <div class="card card-primary card-outline card-outline-tabs">

                <div class="card-header p-0 border-bottom-0">

                    <ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">

                        <!-- TAB LISTADO DE COMPRAS  -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="listado-compras-tab" data-toggle="pill" href="#listado-compras" role="tab" aria-controls="listado-compras" aria-selected="true"><i class="fas fa-list"></i> Listado de Compras</a>
                        </li>

                        <!-- TAB REGISTRO DE COMPRAS -->
                        <li class="nav-item">
                            <a class="nav-link  my-0" id="registrar-compras-tab" data-toggle="pill" href="#registrar-compras" role="tab" aria-controls="registrar-compras" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>

                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT REGISTRO DE COMPRAS -->
                        <div class="tab-pane fade " id="registrar-compras" role="tabpanel" aria-labelledby="registrar-compras-tab">

                            <!-- --------------------------------------------------------- -->
                            <!-- COMPROBANTE DE PAGO -->
                            <!-- --------------------------------------------------------- -->
                            <form id="frm-datos-registro-compras" class="needs-validation-registro-compras" novalidate>

                                <input type="hidden" name="id_compra" id="id_compra" value="0">

                                <div class="row mb-2">

                                    <!-- RUC PROVEEDOR -->
                                    <div class="col-12 col-md-5 col-lg-3 mb-2">
                                        <input type="hidden" name="id_proveedor" id="id_proveedor" value="0">

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i> Nro Documento</label>
                                        <div class="input-group input-group-sm mb-3 ">
                                            <span class="input-group-text btnBuscarProveedor" id="inputGroup-sizing-sm" style="cursor: pointer;"><i class="fas fa-search ml-1 text-white "></i></span>
                                            <input type="text" class="form-control form-control-sm readonly" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="proveedor" name="proveedor" aria-describedby="inputGroup-sizing-sm" required>
                                            <div class="invalid-feedback">Ingrese al Proveedor </div>
                                        </div>
                                    </div>

                                    <!-- RAZON SOCIAL -->
                                    <div class="col-12 col-md-5 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-signature mr-1 my-text-color"></i> Razón Social/Nombre Completo</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="razon_social" name="razon_social" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                                    </div>

                                    <!-- FECHA DE COMPRA -->
                                    <div class="col-12 col-md-4 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i> Fecha Registro</label>
                                        <div class="input-group input-group-sm mb-3 ">
                                            <span class="input-group-text" id="inputGroup-sizing-sm" style="cursor: pointer;" data-toggle="datetimepicker" data-target="#fecha_registro"><i class="fas fa-calendar-alt ml-1 text-white"></i></span>
                                            <input type="text" class="form-control form-control-sm datetimepicker-input" style="border-top-right-radius: 20px;border-bottom-right-radius: 20px;" aria-label="Sizing example input" id="fecha_registro" name="fecha_registro" aria-describedby="inputGroup-sizing-sm" required>
                                            <div class="invalid-feedback">Ingrese Fecha de Registro</div>
                                        </div>
                                    </div>

                                    <!-- TIPO COMPROBANTE -->
                                    <div class="col-12 col-md-4 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-alt mr-1 my-text-color"></i> Comprobante</label>
                                        <select class="form-select" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>

                                    <!-- SERIE -->
                                    <div class="col-12 col-md-4 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Serie</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm text-uppercase" id="serie" name="serie" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la serie</div>
                                    </div>

                                    <!-- CORRELATIVO -->
                                    <div class="col-12 col-md-4 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Correlativo</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" maxlength="8" name="correlativo" id="correlativo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el correlativo</div>
                                    </div>

                                    <!-- MONEDA -->
                                    <div class="col-12 col-md-4 col-lg-3 mb-2">
                                        <input type="hidden" name="simbolo_moneda" id="simbolo_moneda" value="">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-alt mr-1 my-text-color"></i> Moneda</label>
                                        <select class="form-select" id="moneda" name="moneda" aria-label="Floating label select example" required>
                                        </select>
                                    </div>

                                    <!-- BUSCAR PRODUCTO -->
                                    <div class="d-flex align-items-end col-12 col-md-4 col-lg-3 my-lg-3">

                                        <a class="btn btn-sm btn-info w-100 fw-bold btnBuscarProducto" style="position: relative;">
                                            <span class="text-button">BUSCAR PRODUCTOS</span>
                                            <span class="btn fw-bold icon-btn-custom d-flex align-items-center">
                                                <i class="fas fa-search fs-5"></i>
                                            </span>
                                        </a>
                                    </div>

                                    <!-- BOTONES: CANCELAR - GUARDAR -->
                                    <div class="col-12 col-lg-9 text-right mt-3 col-botonera">

                                        <a class="btn btn-sm btn-danger fw-bold" id="btnCancelarCompra" style="position: relative;">
                                            <span class="text-button">CANCELAR</span>
                                            <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                <i class="fas fa-times-circle fs-5"></i>
                                            </span>
                                        </a>


                                        <a class="btn btn-sm btn-success  fw-bold" id="btnGuardarCompra" style="position: relative;">
                                            <span class="text-button">GUARDAR</span>
                                            <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                                <i class="fas fa-save fs-5"></i>
                                            </span>
                                        </a>
                                    </div>

                                </div>

                            </form>

                            <!-- --------------------------------------------------------- -->
                            <!--LISTADO DE PRODUCTOS -->
                            <!-- --------------------------------------------------------- -->
                            <div class="row mb-3">
                                <!--LISTADO DE PRODUCTOS COMPRADOS -->
                                <div class="col-md-12">
                                    <table id="tbl_ListadoProductos" class="table  w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th></th>
                                            <th>Cod Producto</th>
                                            <th>Producto</th>
                                            <th>Cantidad</th>
                                            <th>Cantidad Temp</th>
                                            <th>Costo Unit.</th>
                                            <th>Costo Unit. Temp</th>
                                            <th>Descuento</th>
                                            <th>Descuento Temp</th>
                                            <th>SubTotal</th>
                                            <th>Impuesto</th>
                                            <th>Total</th>
                                            <th>Tipo Afectacion</th>
                                            <th>Factor Igv</th>
                                            <th>% Igv</th>
                                        </thead>
                                    </table>
                                </div>
                            </div>

                            <!-- --------------------------------------------------------- -->
                            <!--RESUMEN DE LA COMPRA -->
                            <!-- --------------------------------------------------------- -->
                            <div class="row">

                                <div class="col-12 offset-md-6 col-md-6 offset-lg-8 col-lg-4">

                                    <div class="card card-gray shadow float-right">

                                        <div class="card-header">
                                            <h3 class="card-title fs-6">RESUMEN</h3>
                                        </div> <!-- ./ end card-header -->

                                        <div class="card-body py-2">

                                            <div class="row fw-bold">

                                                <!-- OP. GRAVADAS -->
                                                <div class="col-12">
                                                    <span>OP. GRAVADAS</span>
                                                    <span class="float-right" id="resumen_opes_gravadas">S/ 0.00</span>
                                                </div>

                                                <!-- OP. INAFECTAS -->
                                                <div class="col-12">
                                                    <span>OP. INAFECTAS</span>
                                                    <span class="float-right" id="resumen_opes_inafectas">S/ 0.00</span>
                                                </div>

                                                <!-- OP. EXONERADAS -->
                                                <div class="col-12">
                                                    <span>OP. EXONERADAS</span>
                                                    <span class="float-right" id="resumen_opes_exoneradas">S/
                                                        0.00</span>
                                                </div>

                                                <!-- SUBTOTAL -->
                                                <div class="col-12">
                                                    <span>SUBTOTAL</span>
                                                    <span class="float-right" id="resumen_subtotal">S/ 0.00</span>
                                                </div>

                                                <!-- IGV -->
                                                <div class="col-12">
                                                    <span>IGV</span>
                                                    <span class="float-right" id="resumen_total_igv">S/ 0.00</span>
                                                </div>

                                                <!-- DESCUENTO -->
                                                <div class="col-12 text-danger">
                                                    <span>DESCUENTO</span>
                                                    <span class="float-right" id="resumen_total_descuento">S/ 0.00</span>
                                                    <hr class="m-1" />
                                                </div>

                                                <!-- TOTAL -->
                                                <div class="col-12 fs-5">
                                                    <span>TOTAL</span>
                                                    <span class="float-right" id="resumen_total_venta">S/ 0.00</span>
                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT LISTADO DE COMPRAS -->
                        <div class="tab-pane fade active show" id="listado-compras" role="tabpanel" aria-labelledby="listado-compras-tab">

                            <div class="row">

                                <!--LISTADO DE BOLETAS -->
                                <div class="col-md-12">
                                    <table id="tbl_compras" class="table w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th></th>
                                            <th>Id</th>
                                            <th>Id Proveedor</th>
                                            <th>Proveedor</th>
                                            <th>Fec. Compra</th>
                                            <th>Id Tipo Comprobante</th>
                                            <th>Comprobante</th>
                                            <th>Serie</th>
                                            <th>Correlativo</th>
                                            <th>Moneda</th>
                                            <th>Ope Gravadas</th>
                                            <th>Ope Exoneradas</th>
                                            <th>Ope Inafectas</th>
                                            <th>Total IGV</th>
                                            <th>Descuento</th>
                                            <th>Total Compra</th>
                                            <th>Estado</th>
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div><!-- /.card -->

        </div>

    </div>

</div>


<!-- =============================================================================================================================
MODAL LISTADO DE PROVEEDORES
===============================================================================================================================-->
<div class="modal fade" id="mdlListadoProveedores" role="dialog" tabindex="-1">

    <div class="modal-dialog modal-xl" role="document">

        <!-- contenido del modal -->
        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header my-bg py-1">

                <h5 class="modal-title text-white text-lg">Listado de Proveedores</h5>

                <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times text-sm m-0 p-0"></i>
                </button>

            </div>

            <!-- cuerpo del modal -->
            <div class="modal-body">

                <div class="row">

                    <div class="col-12">
                        <!--LISTADO DE PROVEEDORES -->
                        <table id="tbl_proveedores" class="table table-striped w-100 shadow border border-secondary">
                            <thead class="bg-main text-left">
                                <th></th>
                                <th>id</th>
                                <th>Tipo Doc.</th>
                                <th>RUC</th>
                                <th>Razón Social</th>
                                <th>Direccion</th>
                                <th>Telefono</th>
                                <th>Estado</th>
                            </thead>
                        </table>
                    </div>

                </div>

            </div>

        </div>

    </div>

</div>
<!-- /. End -->


<!-- =============================================================================================================================
MODAL LISTADO DE PRODUCTOS
===============================================================================================================================-->
<div class="modal fade" id="mdlListadoProductos" role="dialog" tabindex="-1">

    <div class="modal-dialog modal-lg" role="document">

        <!-- contenido del modal -->
        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header my-bg py-1">

                <h5 class="modal-title text-white text-lg">Listado de Productos</h5>

                <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times text-sm m-0 p-0"></i>
                </button>

            </div>

            <!-- cuerpo del modal -->
            <div class="modal-body">

                <div class="row">

                    <div class="col-12">
                        <!--LISTADO DE PRODUCTOS -->
                        <table id="tbl_productos" class="table table-striped w-100 shadow border border-secondary">
                            <thead class="bg-main">
                                <tr style="font-size: 15px;">

                                    <th class="text-cetner">Sel.</th> <!-- 1 -->
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

            </div>

        </div>

    </div>

</div>
<!-- /. End -->


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
MODAL MOSTRAR DETALLE DE COMPRA
===============================================================================================================================-->
<div class="modal fade" id="mdlMostrarCompra" role="dialog" tabindex="-1">

    <div class="modal-dialog modal-xl" role="document">

        <!-- contenido del modal -->
        <div class="modal-content">

            <!-- cabecera del modal -->
            <div class="modal-header my-bg py-1">

                <h5 class="modal-title text-white text-lg">Detalle de la Compra</h5>

                <button type="button" class="btn btn-danger btn-sm text-white text-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times text-sm m-0 p-0"></i>
                </button>

            </div>

            <!-- cuerpo del modal -->
            <div class="modal-body">

                <div class="row mb-2">

                    <!-- RUC PROVEEDOR -->
                    <div class="col-12 col-md-5 col-lg-3 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i> Ruc</label>
                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="mostrar_ruc" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                    </div>

                    <!-- RAZON SOCIAL -->
                    <div class="col-12 col-md-5 col-lg-6 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-signature mr-1 my-text-color"></i> Razón Social</label>
                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="mostrar_razon_social" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                    </div>

                    <!-- FECHA COMPRA -->
                    <div class="col-12 col-md-5 col-lg-3 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-calendar-alt mr-1 my-text-color"></i>Fecha Compra</label>
                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="mostrar_fecha_compra" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                    </div>

                    <!-- COMPROBANTE -->
                    <div class="col-12 col-md-5 col-lg-3 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-alt mr-1 my-text-color"></i> Comprobante</label>
                        <select class="form-select" id="mostrar_comprobante" aria-label="Floating label select example" disabled>
                        </select>
                    </div>

                    <!-- SERIE -->
                    <div class="col-12 col-md-5 col-lg-3 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Serie</label>
                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="mostrar_serie" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                    </div>

                    <!-- CORRELATIVO -->
                    <div class="col-12 col-md-5 col-lg-3 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Correlativo</label>
                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="mostrar_correlativo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                    </div>

                    <!-- MONEDA -->
                    <div class="col-12 col-md-5 col-lg-3 mb-1">
                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-hand-holding-usd mr-1 my-text-color"></i> Moneda</label>
                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="mostrar_moneda" aria-label="Small" aria-describedby="inputGroup-sizing-sm" disabled>
                    </div>

                </div>

                <div class="row mt-3">

                    <!--LISTADO DE PRODUCTOS COMPRADOS -->
                    <div class="col-md-12">
                        <table id="tbl_MostrarListadoProductos" class="table w-100 shadow border border-secondary">
                            <thead class="bg-main text-left">
                                <th>Cod Producto</th>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Costo Unit.</th>
                                <th>Descuento</th>
                                <th>SubTotal</th>
                                <th>Impuesto</th>
                                <th>Total</th>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>


        </div>

    </div>

</div>

<div class="loading">Loading</div>



<script>
    //Variables Globales
    var itemProducto = 1;

    $(document).ready(function() {

        fnc_MostrarLoader()

        if ($(window).width() < 768) {
            $("#btnCancelarCompra").addClass('w-50')
            $("#btnGuardarCompra").addClass('w-50')
            $(".col-botonera").css('display', 'flex')
            $(".col-botonera").css('column-gap', '15px')
        } else {
            $("#btnCancelarCompra").addClass('w-25')
            $("#btnGuardarCompra").addClass('w-25')
        }

        fnc_CargarSelects();
        fnc_cargarSelectsRegistroProducto();
        // fnc_CargarAutocompleteProductos();
        fnc_CargarDataTableListadoProductos();
        fnc_CargarDatatableProveedores();
        fnc_CargarDataTableProductos();

        fnc_CargarDataTableListadoCompras();

        $('#fecha_registro').datetimepicker({
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

        /* ======================================================================================
        EVENTO PARA MODIFICAR LA CANTIDAD DEL PRODUCTOS A COMPRAR
        ======================================================================================*/
        $('#tbl_ListadoProductos tbody').on('change', '.iptCantidad', function() {

            cantidad_actual = $(this)[0]['value'];
            cod_producto_actual = $(this)[0]['attributes']['codigoproducto']['value'];


            $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

                var row = $('#tbl_ListadoProductos').DataTable().row(index);

                var data = row.data();

                if (data['codigo_producto'] == cod_producto_actual) {

                    // cantidad_actual
                    $('#tbl_ListadoProductos').DataTable().cell(index, 4).data(cantidad_actual)

                }
            })

            fnc_ActualizarDatos();

        })

        /* ======================================================================================
        EVENTO PARA MODIFICAR EL COSTO UNITARIO DEL PRODUCTO A COMPRAR
        ======================================================================================*/
        $('#tbl_ListadoProductos tbody').on('change', '.iptCostoUnitario', function() {

            $costo_actual = $(this)[0]['value'];
            $cod_producto_actual = $(this)[0]['attributes']['codigoproducto']['value'];


            $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

                var row = $('#tbl_ListadoProductos').DataTable().row(index);

                var data = row.data();

                if (data['codigo_producto'] == $cod_producto_actual) {

                    $('#tbl_ListadoProductos').DataTable().cell(index, 6).data($costo_actual)

                }
            })

            fnc_ActualizarDatos();

        })

        /* ======================================================================================
        EVENTO PARA MODIFICAR EL DESCUENTO DEL PRODUCTOS A COMPRAR
        ======================================================================================*/
        $('#tbl_ListadoProductos tbody').on('change', '.iptDescuento', function() {

            $descuento_actual = $(this)[0]['value'];
            $cod_producto_actual = $(this)[0]['attributes']['codigoproducto']['value'];

            $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

                var row = $('#tbl_ListadoProductos').DataTable().row(index);

                var data = row.data();

                if (data['codigo_producto'] == $cod_producto_actual) {

                    $('#tbl_ListadoProductos').DataTable().cell(index, 8).data($descuento_actual)

                }
            })

            fnc_ActualizarDatos();

        })

        $(".btnBuscarProveedor").on('click', function() {
            $("#mdlListadoProveedores").modal('show');
        })

        $(".btnBuscarProducto").on('click', function() {
            fnc_CargarDataTableProductos();
            $("#mdlListadoProductos").modal('show');
        })

        $('#tbl_proveedores tbody').on('click', '.btnSeleccionarProveedor', function() {
            fnc_SeleccionarProveedor($("#tbl_proveedores").DataTable().row($(this).parents('tr')).data());
        })

        $('#tbl_productos tbody').on('click', '.btnSeleccionarProducto', function() {
            fnc_SeleccionarProducto($("#tbl_productos").DataTable().row($(this).parents('tr')).data());
        })

        $("#btnGuardarCompra").on('click', function() {
            fnc_GuardarCompra();
        })

        /* ======================================================================================
        EVENTO PARA ELIMINAR UN PRODUCTO DEL LISTADO
        ======================================================================================*/
        $('#tbl_ListadoProductos tbody').on('click', '.btnEliminarproducto', function() {
            $('#tbl_ListadoProductos').DataTable().row($(this).parents('tr')).remove().draw();
            fnc_ActualizarDatos();
        });

        $(".btnAgregarProducto").on('click', function() {
            $("#mdlGestionarProducto").modal('show')
        })

        $("#btnCancelarRegistro, #btnCerrarModal").on('click', function() {
            fnc_LimpiarFormularioRegistroProducto();
        })

        /*===================================================================*/
        // R E G I S T R O   D E   P R O D U C T O S
        /*===================================================================*/
        $("#btnGuardarProducto").on('click', function() {
            fnc_registrarProducto();
        });

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
            precio_unitario_mayor_sin_igv = parseFloat(precio_unitario_mayor_con_igv / (1 + ($(
                "#impuesto_producto").val() / 100))).toFixed(2);
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

                precio_unitario_sin_igv = parseFloat($("#precio_unitario_con_igv").val() / (1 + ($(
                    "#impuesto_producto").val() / 100))).toFixed(2);
                $("#precio_unitario_sin_igv").val(precio_unitario_sin_igv);


                precio_unitario_mayor_sin_igv = parseFloat($("#precio_unitario_mayor_con_igv").val() / (1 +
                    ($("#impuesto_producto").val() / 100))).toFixed(2);
                $("#precio_unitario_mayor_sin_igv").val(precio_unitario_mayor_sin_igv);

                precio_unitario_oferta_sin_igv = parseFloat($("#precio_unitario_oferta_con_igv").val() / (
                    1 + ($("#impuesto_producto").val() / 100))).toFixed(2);
                $("#precio_unitario_oferta_sin_igv").val(precio_unitario_oferta_sin_igv);
            }

        });

        $("#moneda").change(function() {
            fnc_ObtenerSimboloMoneda()
        })

        $("#serie").keypress(function(e) {
            var key = e.keyCode;
            //102 -> F
            //98 -> B

            if ($("#tipo_comprobante").val()) {
                if ($("#serie").val().length < 1) {

                    if ($("#tipo_comprobante").val() == "01") {
                        if (key != 102 && key != 70) {
                            mensajeToast("warning", "La seria de la Factura debe empezar con la letra F")
                            $("#serie").val('')
                            e.preventDefault();
                        }
                    }

                    if ($("#tipo_comprobante").val() == "03") {
                        if (key != 98 && key != 66) {
                            mensajeToast("warning", "La seria de la Boleta debe empezar con la letra B")
                            $("#serie").val('')
                            e.preventDefault();
                        }
                    }
                }
            } else {
                mensajeToast("warning", "Seleccione el Tipo de Comprobante")
                $("#serie").val('')
                e.preventDefault();
            }


        });

        $("#correlativo").keypress(function(e) {

            if (!$("#tipo_comprobante").val()) {
                mensajeToast("warning", "Seleccione el Tipo de Comprobante")
                $("#serie").val('')
                e.preventDefault();
            }


        });

        $("#tipo_comprobante").change(function() {
            $("#serie").val('');
            $("#correlativo").val('');
        })

        $('#tbl_compras tbody').on('click', '.btnConfirmarCompra', function() {
            fnc_ConfirmarCompra($("#tbl_compras").DataTable().row($(this).parents('tr')).data());
        })

        $('#tbl_compras tbody').on('click', '.btnEditarCompra', function() {
            fnc_EditarCompra($("#tbl_compras").DataTable().row($(this).parents('tr')).data());
        });

        $('#tbl_compras tbody').on('click', '.btnMostrarCompra', function() {
            fnc_MostrarCompra($("#tbl_compras").DataTable().row($(this).parents('tr')).data());
        });

        $('#tbl_compras tbody').on('click', '.btnEliminarCompra', function() {
            fnc_EliminarCompra($("#tbl_compras").DataTable().row($(this).parents('tr')).data());
        });

        $('#tbl_compras tbody').on('click', '.btnImprimirCompra', function() {
            fnc_ImprimirCompra($("#tbl_compras").DataTable().row($(this).parents('tr')).data());
        });

        $("#btnCancelarCompra").on('click', function() {
            fnc_LimpiarFomulario();
        });

        $("#listado-compras-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        fnc_OcultarLoader();

    });
    // FIN DE DOCUMENT READY

    function fnc_MostrarLoader() {
        $(".loading").removeClass('d-none');
        $(".loading").addClass('d-block');
    }

    function fnc_OcultarLoader() {
        $(".loading").removeClass('d-block');
        $(".loading").addClass('d-none')
    }

    /*==========================================================================================================================================
    C A R G A R   D A T A T A B L E   P R O V E E D O R E S
    *=========================================================================================================================================*/
    function fnc_CargarDatatableProveedores() {

        if ($.fn.DataTable.isDataTable('#tbl_proveedores')) {
            $('#tbl_proveedores').DataTable().destroy();
            $('#tbl_proveedores tbody').empty();
        }

        $("#tbl_proveedores").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/proveedores.ajax.php',
                data: {
                    'accion': 'obtener_proveedores'
                },
                type: 'POST'
            },
            responsive: {
                details: {
                    type: 'column'
                }
            },
            columnDefs: [{
                    targets: 7,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[7] != 'ACTIVO') {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        }
                    }
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                        $(td).html(
                            "<span class='btnSeleccionarProveedor text-primary px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-check-circle fs-6 text-center text-success'></i>" +
                            "</span>")
                    }
                }

            ],
            order: [
                [0, 'DESC']
            ],
            scrollX: true,
            autoWidth: true,
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        ajustarHeadersDataTables($("#tbl_proveedores"))
    }

    /*===================================================================*/
    // C O N S U L T A   D E   P R O D U C T O S  (DATATABLE)
    /*===================================================================*/
    function fnc_CargarDataTableProductos() {

        if ($.fn.DataTable.isDataTable('#tbl_productos')) {
            $('#tbl_productos').DataTable().destroy();
            $('#tbl_productos tbody').empty();
        }

        $("#tbl_productos").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                    text: 'Agregar Producto',
                    className: 'addNewRecord',
                    action: function(e, dt, node, config) {
                        $("#mdlGestionarProducto").modal('show')
                    }
                },
                'pageLength'
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
            scrollX: true,
            autoWidth: true,
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
                // {
                //     targets: [0, 3, 4, 5, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17, 19, 20, 21, 22, 23],
                //     visible: false
                // },
                {
                    targets: [2, 5, 6, 8, 22, 21],
                    visible: false
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                        $(td).html(
                            "<span class='btnSeleccionarProducto text-primary px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-check-circle fs-6 text-center text-success'></i>" +
                            "</span>")
                    }
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
                // {
                //     targets: 3,
                //     createdCell: function(td, cellData, rowData, row, col) {
                //         if (rowData['imagen'] != 'no_image.jpg') {
                //             $(td).html('<img src="vistas/assets/imagenes/productos/' + rowData['imagen'] +
                //                 '" class="border text-center border-secondary zoom" style="object-fit: cover; width: 40px; height: 40px; transition: transform .2s;" alt="">'
                //             )
                //         } else {
                //             $(td).html(
                //                 '<img src="vistas/assets/imagenes/no_image.jpg" class="border text-center border-secondary" style="object-fit: cover; width: 40px; height: 40px;" alt="">'
                //             )
                //         }
                //     }
                // },


            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        ajustarHeadersDataTables($("#tbl_productos"))

    }

    function fnc_CargarSelects() {
        CargarSelect(null, $("#tipo_comprobante"), "--Seleccionar--", "ajax/series.ajax.php", 'obtener_tipo_comprobante');
        CargarSelect(null, $("#mostrar_comprobante"), "--Seleccionar--", "ajax/series.ajax.php", 'obtener_tipo_comprobante');
        CargarSelect('PEN', $("#moneda"), "--Seleccionar--", "ajax/ventas.ajax.php", 'obtener_moneda');
        fnc_ObtenerSimboloMoneda()
        // $('.select2').select2()
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
    //CARGAR DATATABLE DE PRODUCTOS A COMPRAR
    /*===================================================================*/
    function fnc_CargarDataTableListadoProductos() {

        if ($.fn.DataTable.isDataTable('#tbl_ListadoProductos')) {
            $('#tbl_ListadoProductos').DataTable().destroy();
            $('#tbl_ListadoProductos tbody').empty();
        }

        $('#tbl_ListadoProductos').DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            columnDefs: [{
                    targets: [4, 6, 8, 12, 13, 14],
                    visible: false
                },
                {
                    targets: [0],
                    orderable: false
                }
            ],

            "columns": [{
                    "data": "acciones"
                },
                {
                    "data": "codigo_producto"
                },
                {
                    "data": "producto"
                },
                {
                    "data": "cantidad"
                },
                {
                    "data": "cantidad_temp"
                },
                {
                    "data": "costo_unitario"
                },
                {
                    "data": "costo_unitario_temp"
                },
                {
                    "data": "descuento"
                },
                {
                    "data": "descuento_temp"
                },
                {
                    "data": "subTotal"
                },
                {
                    "data": "impuesto"
                },
                {
                    "data": "total"
                },
                {
                    "data": "tipo_afectacion_igv"
                },
                {
                    "data": "factor_igv"
                },
                {
                    "data": "porcentaje_igv"
                }
            ],
            // "order": [
            //     [1, 'desc']
            // ],

            // fixedColumns: {
            //     left: 2,
            //     right: 1
            // },
            scrollX: true,
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        });

        ajustarHeadersDataTables($("#tbl_ListadoProductos"))
    }



    /*==========================================================================================================================================
    C A R G A R   P R O D U C T O   A L   L I S T A D O   D E   C O M P R A
    *=========================================================================================================================================*/
    function CargarProductos(producto = "") {

        // AUMENTAMOS LA CANTIDAD SI EL PRODUCTO YA EXISTE EN EL LISTADO        
        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);
            var data = row.data();

            if (producto == data['codigo_producto']) {
                mensajeToast("warning", "El producto la fue agregado al listado");
                exit;
            }
        })

        $.ajax({
            url: "ajax/productos.ajax.php",
            method: "POST",
            data: {
                'accion': 'obtener_producto', //BUSCAR PRODUCTOS POR SU CODIGO DE BARRAS
                'codigo_producto': producto
            },
            dataType: 'json',
            success: function(respuesta) {

                /*===================================================================*/
                //SI LA RESPUESTA ES VERDADERO, TRAE ALGUN DATO
                /*===================================================================*/
                if (respuesta) {

                    $('#tbl_ListadoProductos').DataTable().row.add({
                        'acciones': "<center>" +
                            "<span class='btnEliminarproducto text-danger px-1'style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar producto'> " +
                            "<i class='fas fa-trash fs-6'> </i> " +
                            "</span>" +
                            "</center>",
                        'codigo_producto': respuesta['codigo_producto'],
                        'producto': respuesta['descripcion'],
                        'cantidad': '<input min="0" type="number" step="0.01" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : (event.charCode >= 46 && event.charCode <= 57) || event.charCode == 13" style="width:80px; height:28px;" codigoProducto = "' +
                            respuesta['codigo_producto'] +
                            '" class="form-control text-center iptCantidad p-0 m-0 px-2" value="1">',
                        'cantidad_temp': 1,
                        'costo_unitario': '<input min="0" type="number" step="0.01" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : (event.charCode >= 46 && event.charCode <= 57) || event.charCode == 13" style="width:80px; height:28px;" codigoProducto = "' +
                            respuesta['codigo_producto'] +
                            '" class="form-control text-center iptCostoUnitario p-0 m-0 px-2" value="' +
                            respuesta['costo_unitario'] + '">',
                        'costo_unitario_temp': respuesta['costo_unitario'],
                        'descuento': '<input min="0" type="number" step="0.01" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : (event.charCode >= 46 && event.charCode <= 57) || event.charCode == 13" style="width:80px; height:28px;" codigoProducto = "' +
                            respuesta['codigo_producto'] +
                            '" class="form-control text-center iptDescuento p-0 m-0 px-2" value="0">',
                        'descuento_temp': 0,
                        'subTotal': 0,
                        'impuesto': 0,
                        'total': 0,
                        'tipo_afectacion_igv': respuesta["id_tipo_afectacion_igv"],
                        'factor_igv': respuesta["factor_igv"],
                        'porcentaje_igv': respuesta["porcentaje_igv"]


                    }).draw();

                    fnc_ActualizarDatos();
                    mensajeToast("success", "Producto agregado")

                } else {
                    mensajeToast('error', 'EL PRODUCTO NO EXISTE O NO TIENE STOCK');
                }



            }
        });
    }

    /*==========================================================================================================================================
    A C T U A L I Z A R   I M P O R T E S   D E   L A   C O M P R A
    *=========================================================================================================================================*/
    function fnc_ActualizarDatos() {

        $ope_gravadas = 0;
        $ope_exoneradas = 0;
        $ope_inafectas = 0;
        $total_subtotal = 0;
        $total_impuesto = 0;
        $total_descuento = 0.00;
        $total_compra = 0.00;

        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {

            var row = $('#tbl_ListadoProductos').DataTable().row(index);

            var data = row.data();

            // obtener cantidad
            $cantidad = $('#tbl_ListadoProductos').DataTable().cell(index, 4).data()

            //obtener costo unitario
            $costo_unitario = $('#tbl_ListadoProductos').DataTable().cell(index, 6).data()

            //obtener costo unitario
            $descuento = $('#tbl_ListadoProductos').DataTable().cell(index, 8).data()

            $factor_igv = data["factor_igv"]
            $porcentaje_igv = data["porcentaje_igv"]

            $subtotal = (($costo_unitario / $factor_igv) * $cantidad);
            $impuesto = $subtotal * $porcentaje_igv;
            $total = $subtotal + $impuesto - $descuento;

            if (data["tipo_afectacion_igv"] == 10) {
                $ope_gravadas = $ope_gravadas + $subtotal;
            }

            if (data["tipo_afectacion_igv"] == 20) {
                $ope_exoneradas = $ope_exoneradas + $subtotal;
            }

            if (data["tipo_afectacion_igv"] == 30) {
                $ope_inafectas = $ope_inafectas + $subtotal;
            }

            $total_subtotal = $total_subtotal + $subtotal;
            $total_impuesto = $total_impuesto + $impuesto;
            $total_compra = $total_compra + $total;
            $total_descuento = $total_descuento + parseFloat($descuento)

            $('#tbl_ListadoProductos').DataTable().cell(index, 9).data(parseFloat($subtotal).toFixed(2))
            $('#tbl_ListadoProductos').DataTable().cell(index, 10).data(parseFloat($impuesto).toFixed(2))
            $('#tbl_ListadoProductos').DataTable().cell(index, 11).data(parseFloat($total).toFixed(2));

        })

        $("#resumen_opes_gravadas").html($("#simbolo_moneda").val() + ' ' + $ope_gravadas.toFixed(2));
        $("#resumen_opes_exoneradas").html($("#simbolo_moneda").val() + ' ' + $ope_exoneradas.toFixed(2));
        $("#resumen_opes_inafectas").html($("#simbolo_moneda").val() + ' ' + $ope_inafectas.toFixed(2));
        $("#resumen_subtotal").html($("#simbolo_moneda").val() + ' ' + $total_subtotal.toFixed(2));
        $("#resumen_total_igv").html($("#simbolo_moneda").val() + ' ' + $total_impuesto.toFixed(2));
        $("#resumen_total_descuento").html($("#simbolo_moneda").val() + ' ' + $total_descuento.toFixed(2));
        $("#resumen_total_venta").html($("#simbolo_moneda").val() + ' ' + $total_compra.toFixed(2));

    }

    function fnc_SeleccionarProveedor(data) {
        $("#id_proveedor").val(data["1"]);
        $("#proveedor").val(data["3"]);
        $("#razon_social").val(data["4"]);
        $("#mdlListadoProveedores").modal('hide');
    }

    function fnc_SeleccionarProducto(data) {
        CargarProductos(data["codigo_producto"])
    }

    /*==========================================================================================================================================
    G U A R D A R   C O M P R A
    *=========================================================================================================================================*/
    function fnc_GuardarCompra() {

        let count = 0;
        let valores_en_cero = 0;

        // $("#proveedor").prop("readonly", false); 
        form_registro_compras_validate = validarFormulario('needs-validation-registro-compras');

        // INICIO DE LAS VALIDACIONES
        if (!form_registro_compras_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            // $("#proveedor").prop("readonly", true); 
            return;
        }


        $('#tbl_ListadoProductos').DataTable().rows().eq(0).each(function(index) {
            count = count + 1;

            var row = $('#tbl_ListadoProductos').DataTable().row(index);

            var data = row.data();


            if (data['cantidad_temp'] == 0 || data["costo_unitario_temp"] == 0 || data['cantidad_temp'] == '' ||
                data["costo_unitario_temp"] == '') {
                valores_en_cero = 1;
            }
        });

        if (count == 0) {
            mensajeToast("error", "Ingrese los productos de la compra");
            return;
        }

        if (valores_en_cero == 1) {
            mensajeToast("error", "Los valores de cantidad o costo unitario no pueden ser 0");
            return;
        }
        //FIN DE LAS VALIDACIONES

        Swal.fire({
            title: 'Está seguro(a) de registrar la Compra?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarla!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                detalle_productos = $("#tbl_ListadoProductos").DataTable().rows().data().toArray();

                $ope_gravadas = $("#resumen_opes_gravadas").html().replace('S/ ', '').trim();
                $ope_exoneradas = $("#resumen_opes_exoneradas").html().replace('S/ ', '').trim();
                $ope_inafectas = $("#resumen_opes_inafectas").html().replace('S/ ', '').trim();
                $total_igv = $("#resumen_total_igv").html().replace('S/ ', '').trim();
                $total_descuento = $("#resumen_total_descuento").html().replace('S/ ', '').trim();
                $total = $("#resumen_total_venta").html().replace('S/ ', '').trim();

                var formData = new FormData();
                if ($("#id_compra").val() > 0) formData.append('accion', 'actualizar_compra');
                else formData.append('accion', 'registrar_compra');

                formData.append('id_compra', $("#id_compra").val());
                formData.append('datos_compra', $("#frm-datos-registro-compras").serialize());
                formData.append('arr_detalle_productos', JSON.stringify(detalle_productos));
                formData.append('ope_gravadas', $ope_gravadas);
                formData.append('ope_exoneradas', $ope_exoneradas);
                formData.append('ope_inafectas', $ope_inafectas);
                formData.append('total_igv', $total_igv);
                formData.append('total_descuento', $total_descuento);
                formData.append('total', $total);

                response = SolicitudAjax('ajax/compras.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                if (response.tipo_msj == "success") fnc_LimpiarFomulario();

            }

        })
    }

    function ajustarHeadersDataTables(element) {

        var observer = window.ResizeObserver ? new ResizeObserver(function(entries) {
            entries.forEach(function(entry) {
                $(entry.target).DataTable().columns.adjust();
            });
        }) : null;

        // Function to add a datatable to the ResizeObserver entries array
        resizeHandler = function($table) {
            if (observer)
                observer.observe($table[0]);
        };

        // Initiate additional resize handling on datatable
        resizeHandler(element);

    }

    /*==========================================================================================================================================
    R E G I S T R A R   P R O D U C T O   (QUE NO EXISTE)
    *=========================================================================================================================================*/
    function fnc_registrarProducto() {

        var formData = new FormData();

        formData.append('detalle_producto', $("#frm-datos-producto").serialize());
        formData.append('accion', 'registrar_producto')

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

                        Swal.fire({
                            position: 'top-center',
                            icon: response["tipo_msj"],
                            title: response["msj"],
                            showConfirmButton: true,
                            timer: 2000
                        })

                        if (response["tipo_msj"] == "success") {
                            fnc_LimpiarFormularioRegistroProducto();
                        }

                    }
                })
            } else {
                mensajeToast('warning', 'Complete los campos obligatorios.!')
            }

            form.classList.add('was-validated');

        });

    }

    /*==========================================================================================================================================
    C A R G A R   S E L E C T'S   F O R M U L A R I O   R E G I S T R O
    *=========================================================================================================================================*/
    function fnc_cargarSelectsRegistroProducto() {
        CargarSelect(null, $("#id_categoria"), "--Seleccione una categoría--", "ajax/categorias.ajax.php", 'obtener_categorias');
        CargarSelect(null, $("#id_tipo_afectacion_igv"), "--Seleccione Tipo de Afectación IGV--", "ajax/productos.ajax.php", 'listar_tipo_afectacion');
        CargarSelect(null, $("#id_unidad_medida"), "--Seleccione una Unidad/Medida--", "ajax/productos.ajax.php", 'listar_unidad_medida');
        // $('.select2').select2()
    }

    /*==========================================================================================================================================
    L I M P I A R   I N P U T'S   F O R M U L A R I O   R E G I S T R O
    *=========================================================================================================================================*/
    function fnc_LimpiarFormularioRegistroProducto() {

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

        fnc_cargarSelectsRegistroProducto();
        $(".needs-validation").removeClass("was-validated");
        $("#tbl_productos").DataTable().ajax.reload();
    }

    /*==========================================================================================================================================
    O B T E N E R   S I M B O L O   D E   M O N E D A
    *=========================================================================================================================================*/
    function fnc_ObtenerSimboloMoneda() {
        var datos = new FormData();
        datos.append('accion', 'obtener_simbolo_moneda');
        datos.append('moneda', $("#moneda").val());

        response = SolicitudAjax('ajax/compras.ajax.php', 'POST', datos);
        $("#simbolo_moneda").val(response['simbolo'])
        fnc_ActualizarDatos();
    }

    /*==========================================================================================================================================
    L I M P I A R   I N P U T 'S   D E L   F O R M U L A R I O
    *=========================================================================================================================================*/
    function fnc_LimpiarFomulario() {

        //LIMPIAR MENSAJES DE VALIDACION
        $(".needs-validation-registro-compras").removeClass("was-validated");
        $(".form-floating").removeClass("was-validated");

        $("#id_compra").val('')
        $("#id_proveedor").val('');
        $("#proveedor").val('');
        $("#razon_social").val('');
        fnc_CargarSelects()
        $("#serie").val('');
        $("#correlativo").val('');
        fnc_CargarDataTableListadoProductos();
        $(".needs-validation-registro-compras").removeClass("was-validated");

        //Datos del Resumen
        $("#resumen_opes_gravadas").html('S/ 0.00')
        $("#resumen_opes_inafectas").html('S/ 0.00')
        $("#resumen_opes_exoneradas").html('S/ 0.00')
        $("#resumen_subtotal").html('S/ 0.00')
        $("#resumen_total_igv").html('S/ 0.00')
        $("#resumen_total_venta").html('S/ 0.00')

        $("#listado-compras-tab").addClass('active')
        $("#listado-compras-tab").attr('aria-selected', true)
        $("#listado-compras").addClass('active show')

        $("#registrar-compras-tab").removeClass('active')
        $("#registrar-compras-tab").attr('aria-selected', false)
        $("#registrar-compras").removeClass('active show')

        $("#registrar-compras-tab").html('<i class="fas fa-file-signature"></i> Registrar')
        fnc_CargarDataTableListadoCompras();

    }

    /*==========================================================================================================================================
    C A R G A R   D A T A T A B L E   L I S T A D O   D E  C O M P R A S
    *=========================================================================================================================================*/
    function fnc_CargarDataTableListadoCompras() {

        if ($.fn.DataTable.isDataTable('#tbl_compras')) {
            $('#tbl_compras').DataTable().destroy();
            $('#tbl_compras tbody').empty();
        }

        $("#tbl_compras").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE COMPRAS';
                    return printTitle
                }
            }, 'pageLength'],
            // fixedColumns: {
            //     left: 2,
            //     right: 2
            // },
            // scrollCollapse: true,
            autoWidth: true,
            scrollX: true,
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/compras.ajax.php',
                data: {
                    'accion': 'obtener_compras'
                },
                type: 'POST'
            },
            "autoWidth": true,
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },

                {
                    targets: [2, 5],
                    visible: false
                },
                {
                    targets: 16,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[16] == 'CONFIRMADO') {
                            $(td).html('<span class="bg-success px-2 py-1 rounded-pill fw-bold"> ' + rowData[16] + ' </span>')
                        }

                        if (rowData[16] == 'REGISTRADO') {
                            $(td).html('<span class="my-bg px-2 py-1 rounded-pill fw-bold text-white"> ' + rowData[16] + ' </span>')
                        }
                    }
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData["16"] != 'CONFIRMADO') {
                            $(td).html(`<center> 
                                        <span class='btnMostrarCompra px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Ver Detalle de Compra'> 
                                            <i class='fas fa-search fs-5 text-info'></i>
                                        </span>
                                        <span class='btnImprimirCompra px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Imprimir Compra'> 
                                            <i class='fas fa-file-pdf fs-5 text-danger'></i>
                                        </span>
                                        <span class='btnEditarCompra px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Editar Compra'> 
                                            <i class='fas fa-edit fs-5 text-primary'></i>
                                        </span>
                                        <span class='btnEliminarCompra px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar Compra'> 
                                            <i class='fas fa-trash fs-5 text-danger'></i>
                                        </span>
                                        <span class='btnConfirmarCompra  px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Confirmar Compra / Actualizar Stock'> 
                                            <i class='fas fa-check-double fs-5 text-success'></i>
                                        </span>
                                    </center>`);
                        } else {
                            $(td).html(`<center> 
                                        <span class='btnMostrarCompra   px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Editar Compra'> 
                                            <i class='fas fa-eye fs-5 text-info'></i>
                                        </span>
                                        <span class='btnImprimirCompra px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Imprimir Compra'> 
                                            <i class='fas fa-file-pdf fs-5 text-danger'></i>
                                        </span>
                                    </center>`);
                        }

                    }
                },
                // {
                //     targets: 10,
                //     orderable: false,
                //     createdCell: function(td, cellData, rowData, row, col) {

                //         if (rowData[9] == 2) {
                //             $(td).html("<center>" +
                //                 "<i style='cursor:pointer;' class='fas fa-window-close fs-5 text-danger' data-bs-toggle='tooltip' data-bs-placement='top' title='Enviado a Sunat con Error'></i>" +
                //                 "</center>");
                //         } else if (rowData[9] == 1) {
                //             $(td).html("<center>" +
                //                 "<i style='cursor:pointer;' class='fas fa-check-circle fs-5 text-success' data-bs-toggle='tooltip' data-bs-placement='top' title='Enviado a Sunat correctamente'></i>" +
                //                 "</center>");
                //         } else {
                //             $(td).html("<center>" +
                //                 "<i style='cursor:pointer;' class='fas fa-share-square fs-5 text-warning'  data-bs-toggle='tooltip' data-bs-placement='top' title='Pendiente de envio'></i>" +
                //                 "</center>");
                //         }

                //     }
                // }

            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        ajustarHeadersDataTables($("#tbl_compras"))
    }

    /*==========================================================================================================================================
    C A R G A R   D A T O S   P A R A   E D I C I O N
    *=========================================================================================================================================*/
    function fnc_EditarCompra(data) {

        //ACTIVAR PANE REGISTRO DE PROVEEDORES:
        $("#registrar-compras-tab").addClass('active')
        $("#registrar-compras-tab").attr('aria-selected', true)
        $("#registrar-compras").addClass('active show')

        //DESACTIVAR PANE LISTADO DE PROVEEDORES:
        $("#listado-compras-tab").removeClass('active')
        $("#listado-compras-tab").attr('aria-selected', false)
        $("#listado-compras").removeClass('active show');

        $("#registrar-compras-tab").html('<i class="fas fa-sync-alt"></i> Actualizar Compra')

        $("#id_compra").val(data["1"])

        var formDataCompra = new FormData();
        formDataCompra.append('accion', 'obtener_compra_x_id');
        formDataCompra.append('id_compra', data["1"]);

        compra = SolicitudAjax('ajax/compras.ajax.php', 'POST', formDataCompra);

        //SETEAR DATOS DE LA COMPRA
        $("#id_proveedor").val(compra.id_proveedor)
        $("#proveedor").val(compra.ruc)
        $("#razon_social").val(compra.proveedor)
        $("#fecha_registro").val(compra.fecha_compra)
        $("#tipo_comprobante").val(compra.id_tipo_comprobante).trigger('change');
        $("#serie").val(compra.serie)
        $("#correlativo").val(compra.correlativo)
        $("#moneda").val(compra.id_moneda).trigger('change');

        var formDataDetalleCompra = new FormData();
        formDataDetalleCompra.append('accion', 'obtener_detalle_compra_x_id');
        formDataDetalleCompra.append('id_compra', data["1"]);

        detalle_compra = SolicitudAjax('ajax/compras.ajax.php', 'POST', formDataDetalleCompra);

        for (let index = 0; index < detalle_compra.length; index++) {
            const producto = detalle_compra[index];

            $('#tbl_ListadoProductos').DataTable().row.add({
                'acciones': "<center>" +
                    "<span class='btnEliminarproducto text-danger px-1'style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar producto'> " +
                    "<i class='fas fa-trash fs-6'> </i> " +
                    "</span>" +
                    "</center>",
                'codigo_producto': producto.codigo_producto,
                'producto': producto.producto,
                'cantidad': '<input min="0" type="number" step="0.01" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : (event.charCode >= 46 && event.charCode <= 57) || event.charCode == 13" style="width:80px; height:28px;" codigoProducto = "' +
                    producto.codigo_producto +
                    '" class="form-control text-center iptCantidad p-0 m-0 px-2" value="' + producto.cantidad + '">',
                'cantidad_temp': producto.cantidad_temp,
                'costo_unitario': '<input min="0" type="number" step="0.01" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : (event.charCode >= 46 && event.charCode <= 57) || event.charCode == 13" style="width:80px; height:28px;" codigoProducto = "' +
                    producto.codigo_producto +
                    '" class="form-control text-center iptCostoUnitario p-0 m-0 px-2" value="' +
                    producto.costo_unitario + '">',
                'costo_unitario_temp': producto.costo_unitario,
                'descuento': '<input min="0" type="number" step="0.01" onkeypress="return (event.charCode == 8 || event.charCode == 0) ? null : (event.charCode >= 46 && event.charCode <= 57) || event.charCode == 13" style="width:80px; height:28px;" codigoProducto = "' +
                    producto.codigo_producto +
                    '" class="form-control text-center iptDescuento p-0 m-0 px-2" value="' + producto.descuento + '">',
                'descuento_temp': producto.descuento_temp,
                'subTotal': producto.subtotal,
                'impuesto': producto.impuesto,
                'total': producto.total,
                'tipo_afectacion_igv': producto.id_tipo_afectacion_igv,
                'factor_igv': producto.factor_igv,
                'porcentaje_igv': producto.porcentaje_igv


            }).draw();

        }

        fnc_ActualizarDatos();
    }

    function fnc_MostrarCompra(data) {
        $("#mdlMostrarCompra").modal("show")

        var formDataCompra = new FormData();
        formDataCompra.append('accion', 'obtener_compra_x_id');
        formDataCompra.append('id_compra', data["1"]);

        compra = SolicitudAjax('ajax/compras.ajax.php', 'POST', formDataCompra);

        var formDataDetalleCompra = new FormData();
        formDataDetalleCompra.append('accion', 'obtener_detalle_compra_x_id');
        formDataDetalleCompra.append('id_compra', data["1"]);

        detalle_compra = SolicitudAjax('ajax/compras.ajax.php', 'POST', formDataDetalleCompra);

        $("#mostrar_ruc").val(compra["ruc"])
        $("#mostrar_razon_social").val(compra["proveedor"])
        $("#mostrar_fecha_compra").val(compra["fecha_compra"])
        $("#mostrar_comprobante").val(compra["id_tipo_comprobante"])
        $("#mostrar_serie").val(compra["serie"])
        $("#mostrar_correlativo").val(compra["correlativo"])
        $("#mostrar_moneda").val(compra["id_moneda"])

        fnc_CargarDataTableMostrarListadoProductos(data["1"]);

    }

    /*==========================================================================================================================================
    E L I M I N A R   C O M P R A
    *=========================================================================================================================================*/
    function fnc_EliminarCompra(data) {

        Swal.fire({
            title: 'Está seguro(a) de eliminar la Compra?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo eliminarla!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'eliminar_compra');
                formData.append('id_compra', data["1"]);

                response = SolicitudAjax('ajax/compras.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                fnc_CargarDataTableListadoCompras();

            }
        })
    }

    /*==========================================================================================================================================
    C O N F I R M A R   C O M P R A
    *=========================================================================================================================================*/
    function fnc_ConfirmarCompra(data) {

        Swal.fire({
            title: 'Está seguro(a) de confirmar la Compra?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo confirmarla!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'confirmar_compra');
                formData.append('serie', data["7"]);
                formData.append('correlativo', data["8"]);
                formData.append('id_compra', data["1"]);

                response = SolicitudAjax('ajax/compras.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                fnc_CargarDataTableListadoCompras();

            }
        })
    }

    function fnc_CargarDataTableMostrarListadoProductos(id_compra) {

        if ($.fn.DataTable.isDataTable('#tbl_MostrarListadoProductos')) {
            $('#tbl_MostrarListadoProductos').DataTable().destroy();
            $('#tbl_MostrarListadoProductos tbody').empty();
        }

        $("#tbl_MostrarListadoProductos").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: [5, 10, 15, 30, 50, 100],
            pageLength: 10,
            // processing: true,
            // serverSide: true,
            // order: [],
            ajax: {
                url: 'ajax/compras.ajax.php',
                dataSrc: '',
                data: {
                    'accion': 'mostrar_detalle_compra_x_id',
                    'id_compra': id_compra
                },

                type: 'POST'
            },
            order: [
                [0, 'DESC']
            ],
            scrollX: true,
            autoWidth: true,
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        // ajustarHeadersDataTables($("#tbl_proveedores"))
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

    function fnc_ImprimirCompra(data) {

        $id_compra = data[1]

        window.open('https://tutorialesphperu.com/pos//vistas/generar_registro_compra.php?id_compra=' + $id_compra,
            'fullscreen=yes' +
            "resizable=0,"
        );
    }
</script>