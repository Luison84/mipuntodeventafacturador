<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">CARGA MASIVA DE PRODUCTOS</h2>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Carga Masiva de Productos</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content">
    <div class="container-fluid">
        <!-- FILA PARA INPUT FILE -->
        <div class="row">
            <div class="col-lg-12">
                <div class="card card-gray shadow">
                    <div class="card-header">
                        <h3 class="card-title">Seleccionar Archivo de Carga (Excel):</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div> <!-- ./ end card-tools -->
                    </div> <!-- ./ end card-header -->
                    <div class="card-body">
                        <form method="post" enctype="multipart/form-data" id="form_carga_productos">
                            <div class="row">
                                <div class="col-lg-10">
                                    <input type="file" name="fileProductos" id="fileProductos" class="form-control" accept=".xls, .xlsx">
                                </div>
                                <div class="col-lg-2">
                                    <button class="btn btn-sm btn-success w-100" id="btnCargar" style="position: relative;">
                                        <span class="text-button fw-bold">INICIAR CARGA</span>
                                        <span class="btn fw-bold icon-btn-success">
                                            <i class="fas fa-save fs-5"></i>
                                        </span>
                                    </button>

                                    <!-- <a class="btn btn-success w-100 fw-bold" id="btnCargar" style="position: relative;">
                                        <span class="text-button">INICIAR</span>
                                        <span class="btn fw-bold icon-btn-success">
                                            <i class="fas fa-save fs-5"></i>
                                        </span>
                                    </a> -->
                                </div>
                            </div>
                        </form>

                    </div> <!-- ./ end card-body -->
                </div>
            </div>
        </div>

        <!-- FILA PARA IMAGEN DEL GIF -->
        <div class="row mx-0">
            <div class="col-lg-12 mx-0 text-center d-none" id="img_carga">
                <img src="vistas/assets/imagenes/loading.gif" >
            </div>
        </div>
    </div><!-- /.container-fluid -->
</div>
<!-- /.content -->

<script>
    $(document).ready(function() {

        $("#form_carga_productos").on('submit', function(e) {

            e.preventDefault();

            /*===================================================================*/
            //VALIDAR QUE SE SELECCIONE UN ARCHIVO
            /*===================================================================*/
            if ($("#fileProductos").get(0).files.length == 0) {
                Swal.fire({
                    position: 'center',
                    icon: 'warning',
                    title: 'Debe seleccionar un archivo (Excel).',
                    showConfirmButton: false,
                    timer: 2500
                })
            } else {

                /*===================================================================*/
                //VALIDAR QUE EL ARCHIVO SELECCIONADO SEA EN EXTENSION XLS O XLSX
                /*===================================================================*/
                var extensiones_permitidas = [".xls", ".xlsx"];
                var input_file_productos = $("#fileProductos");
                var exp_reg = new RegExp("([a-zA-Z0-9\s_\\-.\:])+(" + extensiones_permitidas.join('|') + ")$");

                if (!exp_reg.test(input_file_productos.val().toLowerCase())) {
                    Swal.fire({
                        position: 'center',
                        icon: 'warning',
                        title: 'Debe seleccionar un archivo con extensión .xls o .xlsx.',
                        showConfirmButton: false,
                        timer: 2500
                    })

                    return false;
                }

                var formData = new FormData($(form_carga_productos)[0]);
                formData.append('accion', 'carga_masiva_productos')

                $("#btnCargar").prop("disabled", true);
                $("#img_carga").removeClass("d-none");
                $("#img_carga").addClass("d-block");
                $("#img_carga").css("z-index","50");
                $("#img_carga").attr("style", "height:200px");
                $("#img_carga").attr("style", "width:200px");

                response = SolicitudAjax("ajax/productos.ajax.php", "POST", formData);

                // mensajeToast(response["tipo_msj"], response["msj"])

                $("#btnCargar").prop("disabled", false);
                $("#img_carga").removeClass("d-block");
                $("#img_carga").addClass("d-none");
                
                $("#fileProductos").val('');


                Swal.fire({
                    position: 'center',
                    icon: response["tipo_msj"],
                    title: response["msj"],
                    showConfirmButton: false,
                    timer: 2500
                })

               
            }
        })

    })
</script>