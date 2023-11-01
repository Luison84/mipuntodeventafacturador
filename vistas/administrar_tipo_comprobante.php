<!-- Content Header (Page header) -->
<div class="content-header">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-8">

                <h2 class="m-0 fw-bold">ADMINISTRAR TIPOS DE COMPROBANTES <sub>SUNAT</sub></h2>

            </div><!-- /.col -->

            <div class="col-sm-4  d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>

                    <li class="breadcrumb-item active">Administrar Series</li>

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
                            <a class="nav-link active" id="listado-comprobantes-tab" data-toggle="pill" href="#listado-comprobantes" role="tab" aria-controls="listado-comprobantes" aria-selected="true"><i class="fas fa-list"></i> Listado</a>
                        </li>

                        <!-- TAB REGISTRO DE SERIES -->
                        <li class="nav-item">
                            <a class="nav-link" id="registrar-comprobantes-tab" data-toggle="pill" href="#registrar-comprobantes" role="tab" aria-controls="registrar-comprobantes" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE SERIES -->
                        <div class="tab-pane fade active show" id="listado-comprobantes" role="tabpanel" aria-labelledby="listado-comprobantes-tab">

                            <div class="row">

                                <!--LISTADO DE CATEGORIAS -->
                                <div class="col-md-12">
                                    <table id="tbl_tipo_comprobante" class="table table-striped w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th>id</th>
                                            <th>Código</th>
                                            <th>Descripcion</th>
                                            <th>Estado</th>
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT REGISTRO DE SERIES -->
                        <div class="tab-pane fade" id="registrar-comprobantes" role="tabpanel" aria-labelledby="registrar-comprobantes-tab">

                            <form id="frm-datos-comprobante" class="needs-validation-comprobante" novalidate>

                                <!-- COMPROBANTE DE PAGO -->
                                <div class="row">

                                    <!-- CODIGO -->
                                    <div class="col-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-barcode mr-1 my-text-color"></i>Código <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="codigo" name="codigo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el Código del comprobante</div>
                                    </div>

                                    <!-- DESCRIPCION -->
                                    <div class="col-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-signature mr-1 my-text-color"></i>Descripción <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="descripcion" name="descripcion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la descripcion del comprobante</div>
                                    </div>

                                    <!-- ESTADO -->
                                    <div class="col-3 mb-2">
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
                                            <div class="offset-6 col-6 text-right">
                                                <a class="btn btn-sm btn-danger  fw-bold w-25" id="btnCancelarComprobante" style="position: relative;">
                                                    <span class="text-button">CANCELAR</span>
                                                    <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                        <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                    </span>
                                                </a>

                                                <a class="btn btn-sm btn-success  fw-bold w-25" id="btnRegistrarComprobante" style="position: relative;">
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

        fnc_CargarDatatableTipoComprobante();

        $("#btnRegistrarComprobante").on('click', function() {
            fnc_RegistrarComprobante();
        });

        $("#btnCancelarComprobante").on('click', function() {
            fnc_LimpiarFomulario();
        });

    })

    function fnc_CargarDatatableTipoComprobante() {

        if ($.fn.DataTable.isDataTable('#tbl_tipo_comprobante')) {
            $('#tbl_tipo_comprobante').DataTable().destroy();
            $('#tbl_tipo_comprobante tbody').empty();
        }

        $("#tbl_tipo_comprobante").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/tipo_comprobante.ajax.php',
                data: {
                    'accion': 'obtener_tipo_comprobante'
                },
                type: 'POST'
            },
            scrollX: true,
            scrollY: "63vh",
            columnDefs: [{
                    targets: 3,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[3] != 'ACTIVO') {
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


        $("#tbl_tipo_comprobante").on('draw.dt', function() {

            $("#tbl_tipo_comprobante").Tabledit({
                url: 'ajax/actions_editable/actions_tipo_comprobante.php',
                dataType: 'json',
                columns: {
                    identifier: [0, 'id'],
                    editable: [
                        [1, 'codigo'],
                        [2, 'descripcion'],
                        [3, 'estado', '{ "1" : "ACTIVO", "0" : "INACTIVO"}'],
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
                        // fnc_ObtenerEstadoCajaPorDia();
                        // fnc_CargarDatatableSeries
                        $("#tbl_tipo_comprobante").DataTable().ajax.reload();
                    }
                }
            })
        })
    }

    function fnc_RegistrarComprobante() {

        form_comprobante_validate = validarFormulario('needs-validation-comprobante');

        //INICIO DE LAS VALIDACIONES
        if (!form_comprobante_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de registrar el Comprobante?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'registrar_comprobante');
                formData.append('datos_comprobante', $("#frm-datos-comprobante").serialize());

                response = SolicitudAjax('ajax/tipo_comprobante.ajax.php', 'POST', formData);

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
        $("#tbl_tipo_comprobante").DataTable().ajax.reload();
        $(".needs-validation-comprobante").removeClass("was-validated");
    }
</script>