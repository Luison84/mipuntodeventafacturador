<!-- Content Header (Page header) -->
<div class="content-header">

    <div class="container-fluid">

        <div class="row mb-2">

            <div class="col-sm-6">

                <h2 class="m-0 fw-bold">ADMINISTRAR PROVEEDORES</h2>

            </div><!-- /.col -->

            <div class="col-sm-6  d-none d-md-block">

                <ol class="breadcrumb float-sm-right">

                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>

                    <li class="breadcrumb-item active">Administrar Proveedores</li>

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

                        <!-- TAB LISTADO DE PROVEEDORES -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="listado-proveedores-tab" data-toggle="pill" href="#listado-proveedores" role="tab" aria-controls="listado-proveedores" aria-selected="true"><i class="fas fa-list"></i> Listado </a>
                        </li>

                        <!-- TAB REGISTRO DE PROVEEDORES -->
                        <li class="nav-item">
                            <a class="nav-link my-0" id="registrar-proveedores-tab" data-toggle="pill" href="#registrar-proveedores" role="tab" aria-controls="registrar-proveedores" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE PROVEEDORES -->
                        <div class="tab-pane fade active show" id="listado-proveedores" role="tabpanel" aria-labelledby="listado-proveedores-tab">

                            <div class="row">

                                <!--LISTADO DE PROVEEDORES -->
                                <div class="col-md-12">
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

                        <!-- TAB CONTENT REGISTRO DE PROVEEDORES -->
                        <div class="tab-pane fade" id="registrar-proveedores" role="tabpanel" aria-labelledby="registrar-proveedores-tab">

                            <form id="frm-datos-proveedores" class="needs-validation-proveedores" novalidate>

                                <div class="row">

                                    <div class="col-12 col-lg-3 mb-2">

                                        <input type="hidden" name="id_proveedor" id="id_proveedor" value="0">

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card-alt mr-1 my-text-color"></i> Tipo Documento <strong class="text-danger fw-bold">*</strong></label>
                                        <select class="form-select" id="tipo_documento" name="tipo_documento" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el Tipo de Documento</div>

                                    </div>

                                    <div class="col-12 col-lg-3 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i>Nro Documento <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nro_documento" onchange="validateJS(event, 'ruc')" name="nro_documento" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el Nro de Documento</div>
                                    </div>

                                    <div class="col-12 col-lg-6 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-user-tie mr-1 my-text-color"></i>Nombre del Cliente / Razón Social <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nombre_cliente_razon_social" name="nombre_cliente_razon_social" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el Nombre/Razón Social del Proveedor</div>

                                    </div>

                                    <div class="col-12 col-lg-7 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-map-marker-alt mr-1 my-text-color"></i>Dirección <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="direccion" name="direccion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la dirección</div>

                                    </div>

                                    <div class="col-12 col-lg-2 mb-2">
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-phone-alt mr-1 my-text-color"></i>Teléfono</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="telefono" name="telefono" aria-label="Small" aria-describedby="inputGroup-sizing-sm">

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

                                    <div class="col-12 mt-2">
                                        <div class="row">
                                            <div class="col-6 text-right">
                                                <a class="btn btn-sm btn-danger fw-bold w-lg-25 w-100" id="btnCancelarProveedor" style="position: relative;">
                                                    <span class="text-button">CANCELAR</span>
                                                    <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                        <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                    </span>
                                                </a>
                                            </div>

                                            <div class="col-6 text-left">
                                                <a class="btn btn-sm btn-success  fw-bold w-lg-25 w-100" id="btnRegistrarProveedor" style="position: relative;">
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
        fnc_CargarDatatableProveedores();

        $("#btnRegistrarProveedor").on('click', function() {
            fnc_GuardarDatosProveedor();
        });


        $('#tbl_proveedores tbody').on('click', '.btnEditarProducto', function() {
            fnc_ModalActualizarProveedor($(this));
        })

        $("#btnCancelarProveedor").on('click', function() {
            fnc_LimpiarFomulario();
        });

        $("#registrar-proveedores-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        $("#listado-proveedores-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

    })

    function CargarSelects() {
        CargarSelect('6', $("#tipo_documento"), "--Seleccione Tipo Documento--", "ajax/ventas.ajax.php", 'obtener_tipo_documento', null, 0);
    }

    function fnc_CargarDatatableProveedores() {

        if ($.fn.DataTable.isDataTable('#tbl_proveedores')) {
            $('#tbl_proveedores').DataTable().destroy();
            $('#tbl_proveedores tbody').empty();
        }

        $("#tbl_proveedores").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE PRODUCTOS';
                    return printTitle
                }
            }, 'pageLength'],
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
            scrollX: true,
            scrollY: "63vh",
            columnDefs: [
                {
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
                        $(td).html("<span class='btnEditarProducto text-primary px-1' style='cursor:pointer;'>" +
                            "<i class='fas fa-pencil-alt fs-6'></i>" +
                            "</span>")
                    }
                }

            ],
            // scrollX: true,
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })
    }

    function fnc_GuardarDatosProveedor() {

        let accion = '';
        form_proveedores_validate = validarFormulario('needs-validation-proveedores');

        //INICIO DE LAS VALIDACIONES
        if (!form_proveedores_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de guardar los datos del Proveedor?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si!',
            cancelButtonText: 'No',
        }).then((result) => {

            if (result.isConfirmed) {

                if ($("#id_proveedor").val() > 0) accion = 'actualizar_proveedor'
                else accion = 'registrar_proveedor'

                var formData = new FormData();

                formData.append('accion', accion);
                formData.append('datos_proveedor', $("#frm-datos-proveedores").serialize());

                response = SolicitudAjax('ajax/proveedores.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response['tipo_msj'],
                    title: response['msj'],
                    showConfirmButton: true,
                    timer: 2000
                });

                $("#tbl_proveedores").DataTable().ajax.reload();
                fnc_LimpiarFomulario();

            }

        })
    }

    function fnc_ModalActualizarProveedor(fila_actualizar) {

        if (fila_actualizar.parents('tr').hasClass('selected')) {

            fnc_LimpiarFomulario();

        } else {

            // $("#listado-proveedores-tab").prop('disabled', true)

            //ACTIVAR PANE REGISTRO DE PROVEEDORES:
            $("#registrar-proveedores-tab").addClass('active')
            $("#registrar-proveedores-tab").attr('aria-selected', true)
            $("#registrar-proveedores").addClass('active show')

            //DESACTIVAR PANE LISTADO DE PROVEEDORES:
            $("#listado-proveedores-tab").removeClass('active')
            $("#listado-proveedores-tab").attr('aria-selected', false)
            $("#listado-proveedores").removeClass('active show');

            // $("#registrar-proveedores-tab").html('Actualizar Proveedor')
            $("#registrar-proveedores-tab").html('<i class="fas fa-sync-alt"></i> Actualizar Proveedor')

            var data = (fila_actualizar.parents('tr').hasClass('child')) ?
                $("#tbl_proveedores").DataTable().row(fila_actualizar.parents().prev('tr')).data() :
                $("#tbl_proveedores").DataTable().row(fila_actualizar.parents('tr')).data();

            $("#id_proveedor").val(data['2']);
            $("#tipo_documento").val(6);
            $("#nro_documento").val(data['4']);
            $("#nro_documento").attr('id_proveedor', data['2'])
            $("#nombre_cliente_razon_social").val(data['5']);
            $("#direccion").val(data['6']);
            $("#telefono").val(data['7']);
            if (data['8'] == "ACTIVO") $("#estado").val("1")
            else $("#estado").val("0");

        }

    }

    function fnc_LimpiarFomulario() {

        //LIMPIAR MENSAJES DE VALIDACION
        $(".needs-validation-proveedores").removeClass("was-validated");
        $(".form-floating").removeClass("was-validated");

        CargarSelects();
        $("#id_proveedor").val('');
        $("#nro_documento").val('');
        $("#nro_documento").attr('id_proveedor', -1)
        $("#nombre_cliente_razon_social").val('');
        $("#direccion").val('');
        $("#telefono").val('');
        $("#listado-proveedores-tab").prop('disabled', false)

        $("#listado-proveedores-tab").addClass('active')
        $("#listado-proveedores-tab").attr('aria-selected', true)
        $("#listado-proveedores").addClass('active show')

        //DESACTIVAR PANE LISTADO DE PROVEEDORES:
        $("#registrar-proveedores-tab").removeClass('active')
        $("#registrar-proveedores-tab").attr('aria-selected', false)
        $("#registrar-proveedores").removeClass('active show')

        $("#registrar-proveedores-tab").html('<i class="fas fa-file-signature"></i> Registrar')


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
</script>