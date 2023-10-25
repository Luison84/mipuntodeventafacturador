<!-- Content Header (Page header) -->
<div class="content-header">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">ADMINISTRAR SERIES</h2>

            </div><!-- /.col -->

            <div class="col-sm-6">

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
                            <a class="nav-link active" id="listado-serie-tab" data-toggle="pill" href="#listado-serie" role="tab" aria-controls="listado-serie" aria-selected="true"><i class="fas fa-list"></i> Listado de Series</a>
                        </li>

                        <!-- TAB REGISTRO DE SERIES -->
                        <li class="nav-item">
                            <a class="nav-link" id="registrar-serie-tab" data-toggle="pill" href="#registrar-serie" role="tab" aria-controls="registrar-serie" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE SERIES -->
                        <div class="tab-pane fade active show" id="listado-serie" role="tabpanel" aria-labelledby="listado-serie-tab">

                            <div class="row">

                                <!--LISTADO DE CATEGORIAS -->
                                <div class="col-md-12">
                                    <table id="tbl_series" class="table table-striped w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th>id</th>
                                            <th>Tipo Comprobante</th>
                                            <th>Serie</th>
                                            <th>Correlativo</th>
                                            <th>Estado</th>
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT REGISTRO DE SERIES -->
                        <div class="tab-pane fade" id="registrar-serie" role="tabpanel" aria-labelledby="registrar-serie-tab">

                            <form id="frm-datos-serie" class="needs-validation-serie" novalidate>

                                <!-- COMPROBANTE DE PAGO -->
                                <div class="row">

                                    <!-- TIPO COMPROBANTE -->
                                    <div class="col-3">
                                        <!-- <div class="form-floating mb-2">
                                            <select class="form-select select2" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required>
                                            </select>
                                            <label for="serie">Tipo de Comprobante</label>
                                            <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                        </div> -->
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-file-alt mr-1 my-text-color"></i>Tipo de Comprobante</label>
                                        <select class="form-select" id="tipo_comprobante" name="tipo_comprobante" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione Tipo de Comprobante</div>
                                    </div>

                                    <!-- SERIE -->
                                    <div class="col-3">
                                        <!-- <div class="form-floating mb-2">
                                            <input type="text" id="serie" maxlength="4" class="form-control text-uppercase" name="serie" required>
                                            <label for="serie">Serie</label>
                                            <div class="invalid-feedback">Ingrese la serie</div>
                                        </div> -->
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-cart-plus mr-1 my-text-color"></i>Serie</label>
                                        <input type="text" placeholder="Ingrese la serie" maxlength="4" style="border-radius: 20px;" class="form-control form-control-sm text-uppercase" id="serie" name="serie" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la serie</div>
                                    </div>

                                    <!-- CORRELATIVO -->
                                    <div class="col-3">
                                        <!-- <div class="form-floating mb-2">
                                            <input type="text" id="correlativo" class="form-control" name="correlativo" required>
                                            <label for="correlativo">Correlativo</label>
                                            <div class="invalid-feedback">Ingrese el correlativo</div>
                                        </div> -->
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-cart-plus mr-1 my-text-color"></i>Correlativo</label>
                                        <input type="text" placeholder="Ingrese la serie" style="border-radius: 20px;" class="form-control form-control-sm" id="correlativo" name="correlativo" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el correlativo</div>
                                    </div>

                                    <!-- ESTADO -->
                                    <div class="col-3">
                                        <!-- <div class="form-floating mb-2">
                                            <select class="form-select select2" id="estado" name="estado" aria-label="Floating label select example" required>
                                                <option value="" disabled>--Seleccione un estado--</option>
                                                <option value="1" selected>ACTIVO</option>
                                                <option value="0">INACTIVO</option>
                                            </select>
                                            <label for="estado">Estado</label>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-toggle-on mr-1 my-text-color"></i>Estado</label>
                                        <select class="form-select" id="estado" name="estado" aria-label="Floating label select example" required>
                                            <option value="" disabled>--Seleccione un estado--</option>
                                            <option value="1" selected>ACTIVO</option>
                                            <option value="0">INACTIVO</option>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el estado</div>
                                    </div>

                                    <div class="col-12 mt-2">
                                        <div class="float-right">
                                            <!-- <a class="btn btn-outline-danger mx-1" id="btnCancelarSerie">CANCELAR</a>
                                            <a class="btn btn-outline-success mx-1" id="btnRegistrarSerie">GUARDAR SERIE</a> -->

                                            <a class="btn btn-sm btn-danger  fw-bold " id="btnCancelarSerie" style="position: relative; width: 160px;">
                                                <span class="text-button">CANCELAR</span>
                                                <span class="btn fw-bold icon-btn-danger ">
                                                    <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                </span>
                                            </a>

                                            <a class="btn btn-sm btn-success  fw-bold " id="btnRegistrarSerie" style="position: relative; width: 160px;">
                                                <span class="text-button">GUARDAR</span>
                                                <span class="btn fw-bold icon-btn-success ">
                                                    <i class="fas fa-save fs-5 text-white m-0 p-0"></i>
                                                </span>
                                            </a>
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
        fnc_CargarDatatableSeries();

        $("#btnRegistrarSerie").on('click', function() {
            fnc_RegistrarSerie();
        });

        $("#btnCancelarSerie").on('click', function() {
            fnc_LimpiarFomulario();
        })
        
        $("#registrar-serie-tab").on('click', function(){
            fnc_LimpiarFomulario();
        })


    })

    function CargarSelects() {
        CargarSelect(null, $("#tipo_comprobante"), "--Seleccione Tipo Comprobante--", "ajax/series.ajax.php", 'obtener_tipo_comprobante', null, 0);
        // $('.select2').select2()
    }

    function fnc_CargarDatatableSeries() {

        if ($.fn.DataTable.isDataTable('#tbl_series')) {
            $('#tbl_series').DataTable().destroy();
            $('#tbl_series tbody').empty();
        }

        $("#tbl_series").DataTable({
            dom: 'Bfrtip',
            buttons: ['pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/series.ajax.php',
                data: {
                    'accion': 'obtener_series'
                },
                type: 'POST'
            },
            columnDefs: [{
                    targets: 4,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[4] != 'ACTIVO') {
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

        var datos = new FormData();
        datos.append('accion', 'obtener_tipo_comprobante');

        response = SolicitudAjax('ajax/series.ajax.php', 'POST', datos)

        // OBTENER VALORES PARA INPUT DE TIPO DE COMPROBANTE
        let values = ''
        for (let index = 0; index < response.length; index++) {
            values = values + ' "' + response[index]['codigo'] + ' ": "' + response[index]['descripcion'] + '",';
        }

        $("#tbl_series").on('draw.dt', function() {

            $("#tbl_series").Tabledit({
                url: 'ajax/actions_editable/actions_series.php',
                dataType: 'json',
                inputClass: 'form-control  text-uppercase rounded-pill',
                columns: {
                    identifier: [0, 'id'],
                    editable: [
                        [1, 'descripcion', '{' + values.slice(0, -1) + '}'],
                        [2, 'serie'],
                        [3, 'correlativo'],
                        [4, 'estado', '{ "1" : "ACTIVO", "0" : "INACTIVO"}'],
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
                    console.log("🚀 ~ file: administrar_series.php:304 ~ $ ~ data:", data)
                    if (data.action == "delete") {
                        mensajeToast("success", "Se desactivó la Categoría")
                        $("#tbl_categorias").DataTable().ajax.reload();
                    }
                    if (data.action == "edit") {
                        Swal.fire({
                            position: 'top-center',
                            icon: data.tipo_msj,
                            title: data.msj,
                            showConfirmButton: true
                        })
                        // fnc_ObtenerEstadoCajaPorDia();
                        // fnc_CargarDatatableSeries
                        $("#tbl_series").DataTable().ajax.reload();
                    }
                }
            })
        })
    }

    function fnc_RegistrarSerie() {

        form_comprobante_validate = validarFormulario('needs-validation-serie');

        //INICIO DE LAS VALIDACIONES
        if (!form_comprobante_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de registrar la Serie?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, deseo registrarlo!',
            cancelButtonText: 'Cancelar',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'registrar_serie');
                formData.append('datos_serie', $("#frm-datos-serie").serialize());

                response = SolicitudAjax('ajax/series.ajax.php', 'POST', formData);

                // Swal.fire({
                //     position: 'top-center',
                //     icon: response['tipo_msj'],
                //     title: response['msj'],
                //     showConfirmButton: true,
                //     timer: 2000
                // })

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                fnc_LimpiarFomulario();

            }

        })
    }

    function fnc_LimpiarFomulario() {
        CargarSelects();
        $("#serie").val('')
        $("#correlativo").val('')
        $("#estado").val('1');
        $("#tbl_series").DataTable().ajax.reload();
        $(".needs-validation-serie").removeClass("was-validated");
    }
</script>