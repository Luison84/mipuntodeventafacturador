<!-- Content Header (Page header) -->
<div class="content-header">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">ADMINISTRAR TIPO DOCUMENTO <sub>SUNAT</sub></h2>

            </div><!-- /.col -->

            <div class="col-sm-6  d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>

                    <li class="breadcrumb-item active">Administrar Tipo Documento</li>

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

                        <!-- TAB LISTADO DE TIPOS DE DOCUMENTO -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="listado-tipo-documento-tab" data-toggle="pill" href="#listado-tipo-documento" role="tab" aria-controls="listado-tipo-documento" aria-selected="true"><i class="fas fa-list"></i> Listado </a>
                        </li>

                        <!-- TAB REGISTRO DE TIPO DE DOCUMENTO -->
                        <li class="nav-item">
                            <a class="nav-link my-0" id="registrar-tipo-documento-tab" data-toggle="pill" href="#registrar-tipo-documento" role="tab" aria-controls="registrar-tipo-documento" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE SERIES -->
                        <div class="tab-pane fade active show" id="listado-tipo-documento" role="tabpanel" aria-labelledby="listado-tipo-documento-tab">

                            <div class="row">

                                <!--LISTADO DE CATEGORIAS -->
                                <div class="col-md-12">
                                    <table id="tbl_tipo_documento" class="table table-striped w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th>Código</th>
                                            <th>Descripción</th>
                                            <th>Estado</th>
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT REGISTRO DE SERIES -->
                        <div class="tab-pane fade" id="registrar-tipo-documento" role="tabpanel" aria-labelledby="registrar-tipo-documento-tab">

                            <form id="frm-datos-tipo-documento" class="needs-validation-tipo-documento" novalidate>

                                <div class="row">

                                    <div class="col-12 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Código <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="codigo" name="codigo" onchange="validateJS(event, 'codigo_tipo_documento')" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el código</div>

                                    </div>

                                    <div class="col-12 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-signature mr-1 my-text-color"></i>Descripción <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="descripcion" name="descripcion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la descripción</div>

                                    </div>

                                    <!-- ESTADO -->
                                    <div class="col-12 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-toggle-on mr-1 my-text-color"></i>Estado <strong class="text-danger fw-bold">*</strong></label>
                                        <select class="form-select" id="estado" name="estado" aria-label="Floating label select example" required>
                                            <option value="" disabled>--Seleccione un estado--</option>
                                            <option value="1" selected>ACTIVO</option>
                                            <option value="0">INACTIVO</option>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el estado</div>
                                    </div>


                                    <div class="col-12 mb-2 mt-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <a class="btn btn-sm btn-danger fw-bold w-lg-25 w-100" id="btnCancelarTipoDocumento" style="position: relative;">
                                                    <span class="text-button">CANCELAR</span>
                                                    <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                        <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                    </span>
                                                </a>
                                            </div>
                                            <div class="col-6">
                                                <a class="btn btn-sm btn-success  fw-bold w-lg-25 w-100" id="btnRegistrarTipoDocumento" style="position: relative;">
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

        fnc_CargarDatatableTipoDocumento();
        fnc_LoadDataTableEdit();

        $("#btnRegistrarTipoDocumento").on('click', function() {
            fnc_GuardarTipoDocumento();
        });

        $("#btnCancelarTipoDocumento").on('click', function() {
            fnc_LimpiarFomulario();
        });

        $("#registrar-tipo-documento-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        $("#listado-tipo-documento-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

    })

    function fnc_CargarDatatableTipoDocumento() {

        if ($.fn.DataTable.isDataTable('#tbl_tipo_documento')) {
            $('#tbl_tipo_documento').DataTable().destroy();
            $('#tbl_tipo_documento tbody').empty();
        }

        $("#tbl_tipo_documento").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE TIPOS DE DOCUMENTO';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/tipo_documento.ajax.php',
                data: {
                    'accion': 'obtener_tipo_documento'
                },
                type: 'POST'
            },
            scrollX: true,
            scrollY: "63vh",
            columnDefs: [{
                    "className": "dt-center",
                    "targets": "_all"
                },                
                {
                    targets: 2,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[2] != 'ACTIVO') {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        }
                    }
                },

            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

    }

    function fnc_LoadDataTableEdit() {

        $("#tbl_tipo_documento").on('draw.dt', function() {

            $("#tbl_tipo_documento").Tabledit({
                url: 'ajax/actions_editable/actions_tipo_documento.php',
                dataType: 'json',
                columns: {
                    identifier: [0, 'id'],
                    editable: [
                        [1, 'descripcion'],
                        [2, 'estado', '{ "1" : "ACTIVO", "0" : "INACTIVO"}'],
                    ]
                },
                restoreButton: true,
                buttons: {
                    edit: {
                        class: 'btn btn-sm m-0 p-0 data-bs-toggle="tooltip" data-bs-placement="top" title="Activar/Editar Categoría"',
                        html: '<i class="fas fa-edit text-primary fs-5"></i>',
                        action: 'edit'
                    },
                    delete: {
                        class: 'd-none',
                        html: '',
                        action: 'delete'
                    },
                    save: {
                        class: 'btn btn-sm btn-success p-0 px-2 rounded-pill',
                        html: '<i class="fas fa-check "></i>'
                    },
                    restore: {
                        class: 'btn btn-sm btn-warning',
                        html: 'Deshacer',
                        action: 'restore'
                    },
                    confirm: {
                        class: 'btn btn-sm btn-danger p-0 px-1 rounded-pill',
                        html: '<i class="fas fa-check "></i>'
                    }
                },
                onSuccess: function(data, textStatus, jqXHR) {

                    if (data.action == "edit") {
                        Swal.fire({
                            position: 'top-center',
                            icon: 'success',
                            title: 'Se actualizó el comprobante correctamente',
                            showConfirmButton: true,
                            timer: 2000
                        })
                        fnc_CargarDatatableTipoDocumento();
                    }
                }
            })
        })
    }

    function fnc_GuardarTipoDocumento() {

        form_tipo_documento_validate = validarFormulario('needs-validation-tipo-documento');

        //INICIO DE LAS VALIDACIONES
        if (!form_tipo_documento_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de registrar el Tipo de Documento?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'registrar_tipo_documento');
                formData.append('datos_tipo_documento', $("#frm-datos-tipo-documento").serialize());

                response = SolicitudAjax('ajax/tipo_documento.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response['tipo_msj'],
                    title: response['msj'],
                    showConfirmButton: true,
                    timer: 2000
                })

                fnc_LimpiarFomulario();

            }

        })
    }

    function fnc_LimpiarFomulario() {
        $("#codigo").val('')
        $("#descripcion").val('')
        $("#estado").val('1');

        $(".needs-validation-tipo-documento").removeClass("was-validated");

        $("#listado-tipo-documento-tab").addClass('active')
        $("#listado-tipo-documento-tab").attr('aria-selected', true)
        $("#listado-tipo-documento").addClass('active show')

        //DESACTIVAR PANE LISTADO DE TIPO DE DOCUMENTO
        $("#registrar-tipo-documento-tab").removeClass('active')
        $("#registrar-tipo-documento-tab").attr('aria-selected', false)
        $("#registrar-tipo-documento").removeClass('active show')

        fnc_CargarDatatableTipoDocumento();
    }
</script>