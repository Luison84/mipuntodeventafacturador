<!-- Content Header (Page header) -->
<div class="content-header">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">ADMINISTRAR EMPRESAS</h2>

            </div><!-- /.col -->

            <div class="col-sm-6  d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>

                    <li class="breadcrumb-item active">Administrar Empresas</li>

                </ol>

            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container-fluid -->

</div><!-- /.content-header -->

<div class="content">

    <div class="row">

        <div class="col-12 ">

            <div class="card card-primary card-outline card-outline-tabs">

                <div class="card-header p-0 border-bottom-0">

                    <ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">

                        <!-- TAB LISTADO DE SERIES -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="listado-empresas-tab" data-toggle="pill" href="#listado-empresas" role="tab" aria-controls="listado-empresas" aria-selected="true"><i class="fas fa-list"></i> Listado</a>
                        </li>

                        <!-- TAB REGISTRO DE SERIES -->
                        <li class="nav-item">
                            <a class="nav-link my-0" id="registrar-empresas-tab" data-toggle="pill" href="#registrar-empresas" role="tab" aria-controls="registrar-empresas" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE SERIES -->
                        <div class="tab-pane fade active show" id="listado-empresas" role="tabpanel" aria-labelledby="listado-empresas-tab">

                            <div class="row">

                                <!--LISTADO DE CATEGORIAS -->
                                <div class="col-md-12">
                                    <table id="tbl_empresas" class="table table-striped w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th></th>
                                            <th>ID</th>
                                            <th>Razon Social</th>
                                            <th>Nombre Comercial</th>
                                            <th>Id Tipo Doc.</th>
                                            <th>Tipo Doc.</th>
                                            <th>RUC</th>
                                            <th>Dirección</th>
                                            <th>Simb. Mon.</th>
                                            <th>Email</th>
                                            <th>Télefono</th>
                                            <th>Provincia</th>
                                            <th>Departamento</th>
                                            <th>Distrito</th>
                                            <th>Ubigeo</th>
                                            <th>Usuario_sol</th>
                                            <th>Clave_sol</th>
                                            <th>Estado</th> <!-- 18 -->
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT REGISTRO DE SERIES -->
                        <div class="tab-pane fade" id="registrar-empresas" role="tabpanel" aria-labelledby="registrar-empresas-tab">

                            <form id="frm-datos-empresas" class="needs-validation-empresas" novalidate>

                                <div class="row">

                                    <div class="col-12 col-lg-3 mb-2">
                                        <input type="hidden" name="id_empresa" id="id_empresa" value="0">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-contract mr-1 my-text-color"></i>Tipo Documento <strong class="text-danger">*</strong></label>
                                        <select class="form-select" id="tipo_documento" name="tipo_documento" aria-label="Floating label select example" required readonly>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el Tipo de Documento</div>
                                    </div>

                                    <div class="col-12 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Nro Documento <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nro_documento" name="nro_documento" onchange="validateJS(event, 'ruc_empresa')" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el Nro de Documento</div>
                                    </div>

                                    <div class="col-12 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Razón Social <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="razon_social" name="razon_social" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Razón Social</div>
                                    </div>

                                    <div class="col-12 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Nombre Comercial <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nombre_comercial" name="nombre_comercial" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Nombre Comercial</div>
                                    </div>

                                    <div class="col-12 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Dirección <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="direccion" name="direccion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Dirección</div>

                                    </div>

                                    <!-- EMAIL -->
                                    <div class="col-12 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Email</label>
                                        <input type="email" style="border-radius: 20px;" class="form-control form-control-sm" id="email" name="email" aria-label="Small" aria-describedby="inputGroup-sizing-sm">

                                    </div>

                                    <!-- TELEFONO -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Teléfono</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="telefono" name="telefono" aria-label="Small" aria-describedby="inputGroup-sizing-sm">

                                    </div>

                                    <!-- PROVINCIA -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Provincia <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="provincia" name="provincia" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Provincia</div>

                                    </div>

                                    <!-- DEPARTAMENTO -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Departamento <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="departamento" name="departamento" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Departamento</div>

                                    </div>

                                    <!-- DISTRITO -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Distrito <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="distrito" name="distrito" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Distrito</div>

                                    </div>

                                    <!-- UBIGEO -->
                                    <div class="col-12 col-lg-1 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Ubigeo <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" onchange="validateJS(event, 'ubigeo')" id="ubigeo" name="ubigeo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Ubigeo</div>

                                    </div>

                                    <!-- RUTA CERTIFICADO -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Ruta Certificado</label>
                                        <input type="text" value="../fe/certificado/" style="border-radius: 20px;" class="form-control form-control-sm" id="ruta_certificado" name="ruta_certificado" aria-label="Small" aria-describedby="inputGroup-sizing-sm" readonly>
                                    </div>

                                    <!-- SELECCIONAR CERTIFICADO DIGITAL -->
                                    <div class="col-12 col-lg-4 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-image mr-1 my-text-color"></i>Seleccione el Certificado Digital <strong class="text-danger">*</strong> </label>
                                        <input type="file" class="form-control" id="certificado" name="certificado" accept=".pfx">
                                        <div class="invalid-feedback">Seleccione Certificado</div>
                                    </div>

                                    <!-- CLAVE CERTIFICADO DIGITAL -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Clave Certificado <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="clave_certificado" name="clave_certificado" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
                                        <div class="invalid-feedback">Ingrese clave</div>
                                    </div>


                                    <!-- USUARIO SOL -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Usuario SOL <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="usuario_sol" name="usuario_sol" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Usuario SOL</div>
                                    </div>

                                    <!-- CLAVE SOL -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-list-ol mr-1 my-text-color"></i>Clave SOL <strong class="text-danger">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="clave_sol" name="clave_sol" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese Clave SOL</div>
                                    </div>

                                    <!-- ESTADO -->
                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-toggle-on mr-1 my-text-color"></i>Estado <strong class="text-danger">*</strong></label>
                                        <select class="form-select" id="estado" name="estado" aria-label="Floating label select example" required>
                                            <option value="" disabled>--Seleccione un estado--</option>
                                            <option value="1" selected>ACTIVO</option>
                                            <option value="0">INACTIVO</option>
                                        </select>
                                        <div class="invalid-feedback">Seleccion Estado</div>
                                    </div>

                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-image mr-1 my-text-color"></i>Empresa Principal?</label>
                                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-start my-0 ">
                                            <div class="icheck-warning d-inline mx-2">
                                                <input type="radio" id="rb-venta-envio" value="1" name="rb_generar_venta" checked="">
                                                <label for="rb-venta-envio">
                                                    Si
                                                </label>
                                            </div>
                                            <div class="icheck-success d-inline mx-2">
                                                <input type="radio" id="rb-venta" value="2" name="rb_generar_venta">
                                                <label for="rb-venta">
                                                    No
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-image mr-1 my-text-color"></i>Empresa Fact/Bol Defecto?</label>
                                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-start my-0 ">
                                            <div class="icheck-warning d-inline mx-2">
                                                <input type="radio" id="rb-venta-envio" value="1" name="rb_generar_venta" checked="">
                                                <label for="rb-venta-envio">
                                                    Si
                                                </label>
                                            </div>
                                            <div class="icheck-success d-inline mx-2">
                                                <input type="radio" id="rb-venta" value="2" name="rb_generar_venta">
                                                <label for="rb-venta">
                                                    No
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- <div class="col-12 col-lg-2 text-center mb-2">
                                        <div class="form-group clearfix w-100 d-flex justify-content-start justify-content-lg-center my-0 ">
                                            <div class="icheck-success d-inline mx-2">
                                                <input type="radio" id="rb-venta" value="2" name="rb_generar_venta">
                                                <label for="rb-venta">
                                                    No
                                                </label>
                                            </div>
                                        </div>
                                    </div> -->

                                    <!-- IMAGEN -->
                                    <div class="col-12 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-image mr-1 my-text-color"></i>Seleccione logo</label>
                                        <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" onchange="previewFile(this)">
                                    </div>

                                    <!-- PREVIEW IMAGEN -->
                                    <div class="col-12 col-lg-12">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-image mr-1 my-text-color"></i>Vista previa logo</label>
                                        <div style="width: 155px; height: 155px;">
                                            <img id="previewImg" src="vistas/assets/imagenes/no_image.jpg" class="border border-secondary" style="object-fit: fill; width: 100%; height: 100%;" alt="">
                                        </div>
                                    </div>

                                    <!-- CANCELAR - GUARDAR -->
                                    <div class="col-12 mt-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <a class="btn btn-sm btn-danger fw-bold w-lg-25 w-100" id="btnCancelarEmpresa" style="position: relative;">
                                                    <span class="text-button">CANCELAR</span>
                                                    <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                        <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                    </span>
                                                </a>
                                            </div>
                                            <div class="col-6 text-left">
                                                <a class="btn btn-sm btn-success  fw-bold w-lg-25 w-100" id="btnRegistrarEmpresa" style="position: relative;">
                                                    <span class="text-button">GUARDAR</span>
                                                    <span class="btn fw-bold icon-btn-success d-flex align-items-center">
                                                        <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </form>

                        </div>

                    </div>

                </div>

                <!-- /.card -->
            </div>

        </div>

    </div>

</div>

<script>
    $(document).ready(function() {

        CargarSelects();
        fnc_CargarDatatableEmpresas();

        $("#btnRegistrarEmpresa").on('click', function() {
            fnc_GuardarDatosEmpresa();
        });

        $('#tbl_empresas tbody').on('click', '.btnEditarEmpresa', function() {
            fnc_ModalActualizarEmpresa($(this));
        })

        $("#btnCancelarEmpresa").on('click', function() {
            fnc_LimpiarFomulario();
        });

        $("#registrar-empresas-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        $("#email").change(function() {
            var pattern = /^[^0-9][.a-zA-Z0-9_]+([.][.a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/;

            if (!pattern.test($("#email").val())) {
                mensajeToast('warning', 'Formato de email inválido');
                $("#email").val('');
                $("#email").focus();
                return;
            }
        })

        $("#listado-empresas-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

    })

    function CargarSelects() {
        CargarSelect('6', $("#tipo_documento"), "--Seleccione Tipo Documento--", "ajax/ventas.ajax.php", 'obtener_tipo_documento', null, 0);
    }

    function fnc_CargarDatatableEmpresas() {

        if ($.fn.DataTable.isDataTable('#tbl_empresas')) {
            $('#tbl_empresas').DataTable().destroy();
            $('#tbl_empresas tbody').empty();
        }

        $("#tbl_empresas").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE EMPRESAS';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/empresas.ajax.php',
                data: {
                    'accion': 'obtener_empresas'
                },
                type: 'POST'
            },
            // responsive: {
            //     details: {
            //         type: 'column'
            //     }
            // },
            scrollX: true,
            scrollY: "63vh",
            columnDefs: [{
                    targets: 0,
                    orderable: false,
                    className: 'control'
                },
                {
                    targets: 4,
                    visible: false
                },
                {
                    targets: 17,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[17] != 'ACTIVO') {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        }
                    }
                },
                {
                    targets: 0,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                        $(td).html("<span class='btnEditarEmpresa text-primary px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-pencil-alt fs-6'></i>" +
                            "</span>")
                    }
                }

            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })
    }

    function fnc_GuardarDatosEmpresa() {

        let accion = '';
        var certificado_valido = true;

        form_empresas_validate = validarFormulario('needs-validation-empresas');

        var formData = new FormData();

        //INICIO DE LAS VALIDACIONES
        if (!form_empresas_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de guardar los datos de la Empresa?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si!',
            cancelButtonText: 'No',
        }).then((result) => {

            if (result.isConfirmed) {

                var file = $("#certificado").val();

                if (file) {

                    var ext = file.substring(file.lastIndexOf("."));

                    if (ext != ".pfx") {
                        mensajeToast('error', "La extensión " + ext + " no es un certificado válido");
                        certificado_valido = false;
                    }

                    if (!certificado_valido) {
                        return;
                    }

                    const inputCertificado = document.querySelector('#certificado');
                    formData.append('archivo[]', inputCertificado.files[0])
                }

                if ($("#id_empresa").val() > 0) accion = 'actualizar_empresa'
                else accion = 'registrar_empresa'

                formData.append('accion', accion);
                formData.append('datos_empresa', $("#frm-datos-empresas").serialize());

                response = SolicitudAjax('ajax/empresas.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response['tipo_msj'],
                    title: response['msj'],
                    showConfirmButton: true,
                    timer: 2000
                });

                $("#tbl_empresas").DataTable().ajax.reload();
                fnc_LimpiarFomulario();
            }

        })
    }

    function fnc_ModalActualizarEmpresa(fila_actualizar) {

        if (fila_actualizar.parents('tr').hasClass('selected')) {
            fnc_LimpiarFomulario();
        } else {

            // $("#listado-empresas-tab").prop('disabled', true)

            //ACTIVAR PANE REGISTRO DE PROVEEDORES:
            $("#registrar-empresas-tab").addClass('active')
            $("#registrar-empresas-tab").attr('aria-selected', true)
            $("#registrar-empresas").addClass('active show')

            //DESACTIVAR PANE LISTADO DE PROVEEDORES:
            $("#listado-empresas-tab").removeClass('active')
            $("#listado-empresas-tab").attr('aria-selected', false)
            $("#listado-empresas").removeClass('active show');

            // $("#registrar-proveedores-tab").html('Actualizar Proveedor')
            $("#registrar-empresas-tab").html('<i class="fas fa-sync-alt"></i> Actualizar')

            var data = (fila_actualizar.parents('tr').hasClass('child')) ?
                $("#tbl_empresas").DataTable().row(fila_actualizar.parents().prev('tr')).data() :
                $("#tbl_empresas").DataTable().row(fila_actualizar.parents('tr')).data();

            var datos = new FormData();
            datos.append('accion', 'obtener_datos_empresa_x_id');
            datos.append('id_empresa', data['1']);

            response = SolicitudAjax('ajax/empresas.ajax.php', 'POST', datos);


            $("#id_empresa").val(response.id_empresa);
            $("#tipo_documento").val(response.tipo_documento);
            $("#nro_documento").val(response.ruc);
            $("#razon_social").val(response.razon_social)
            $("#nombre_comercial").val(response.nombre_comercial)
            $("#direccion").val(response.direccion)
            $("#email").val(response.email)
            $("#telefono").val(response.telefono)
            $("#provincia").val(response.provincia)
            $("#departamento").val(response.departamento)
            $("#distrito").val(response.distrito)
            $("#ubigeo").val(response.ubigeo)



            const fileInput = document.querySelector('input[type="file"]');

            // Create a new File object
            const myFile = new File(['Certificado Digital'], response.certificado_digital, {
                type: 'text/plain',
                lastModified: new Date(),
            });

            // Now let's create a DataTransfer to get a FileList
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(myFile);
            fileInput.files = dataTransfer.files;


            $("#clave_certificado").val(response.clave_certificado)
            $("#usuario_sol").val(response.usuario_sol)
            $("#clave_sol").val(response.clave_sol)
            $("#estado").val(response.estado)
        }

    }

    function fnc_LimpiarFomulario() {

        //LIMPIAR MENSAJES DE VALIDACION
        $(".needs-validation-empresas").removeClass("was-validated");
        $(".form-floating").removeClass("was-validated");


        $("#id_empresa").val('');
        CargarSelects();
        $("#nro_documento").val('');
        $("#nro_documento").attr('id_empresa', -1)
        $("#razon_social").val('')
        $("#nombre_comercial").val('')
        $("#direccion").val('')
        $("#email").val('')
        $("#telefono").val('')
        $("#provincia").val('')
        $("#departamento").val('')
        $("#distrito").val('')
        $("#ubigeo").val('')
        $("#certificado").val('');
        $("#clave_certificado").val('')
        $("#usuario_sol").val('')
        $("#clave_sol").val('')
        $("#estado").val('1')

        $("#listado-empresas-tab").prop('disabled', false)

        $("#listado-empresas-tab").addClass('active')
        $("#listado-empresas-tab").attr('aria-selected', true)
        $("#listado-empresas").addClass('active show')

        //DESACTIVAR PANE LISTADO DE PROVEEDORES:
        $("#registrar-empresas-tab").removeClass('active')
        $("#registrar-empresas-tab").attr('aria-selected', false)
        $("#registrar-empresas").removeClass('active show')

        $("#registrar-empresas-tab").html('<i class="fas fa-file-signature"></i> Registrar')


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

    // PREVISUALIZAR LA IMAGEN
    function previewFile(input) {

        var file = $("#imagen").get(0).files[0];

        if (file) {
            var reader = new FileReader();

            reader.onload = function() {
                $("#previewImg").attr("src", reader.result);
            }

            reader.readAsDataURL(file);
        }
    }
</script>