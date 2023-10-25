<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">ADMINISTRAR CLIENTES</h2>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Administrar Clientes</li>
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

                        <!-- TAB LISTADO DE CLIENTES -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="listado-clientes-tab" data-toggle="pill" href="#listado-clientes" role="tab" aria-controls="listado-clientes" aria-selected="true"><i class="fas fa-list"></i> Listado de Clientes</a>
                        </li>

                        <!-- TAB REGISTRO DE CLIENTES -->
                        <li class="nav-item">
                            <a class="nav-link my-0" id="registrar-clientes-tab" data-toggle="pill" href="#registrar-clientes" role="tab" aria-controls="registrar-clientes" aria-selected="false"><i class="fas fa-file-signature"></i> Registrar</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE SERIES -->
                        <div class="tab-pane fade active show" id="listado-clientes" role="tabpanel" aria-labelledby="listado-clientes-tab">

                            <div class="row">

                                <!--LISTADO DE CATEGORIAS -->
                                <div class="col-md-12">
                                    <table id="tbl_clientes" class="table table-striped w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th> </th> <!-- 0 -->
                                            <th></th>
                                            <th>id</th>
                                            <th>Id Tipo Doc.</th>
                                            <th>Tipo Doc.</th>
                                            <th>Nro Doc.</th>
                                            <th>Nombres y Apellidos / Razón Social</th>
                                            <th>Direccion</th>
                                            <th>Telefono</th>
                                            <th>Estado</th><!-- 10 -->
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT REGISTRO DE SERIES -->
                        <div class="tab-pane fade" id="registrar-clientes" role="tabpanel" aria-labelledby="registrar-clientes-tab">

                            <form id="frm-datos-clientes" class="needs-validation-clientes" novalidate>

                                <div class="row">

                                    <div class="col-3 mb-2">

                                        <input type="hidden" name="id_cliente" id="id_cliente" value="0">

                                        <!-- <div class="form-floating mb-2">
                                            <select class="form-select select2" id="tipo_documento" name="tipo_documento" aria-label="Floating label select example" required>
                                            </select>
                                            <label for="tipo_documento">Tipo Documento</label>
                                            <div class="invalid-feedback">Seleccione el Tipo de Documento</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card-alt mr-1 my-text-color"></i> Tipo Documento <strong class="text-danger fw-bold">*</strong></label>
                                        <select class="form-select" id="tipo_documento" name="tipo_documento" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el Tipo de Documento</div>

                                    </div>

                                    <div class="col-3 mb-2">

                                        <!-- <div class="form-floating mb-2" style="position: relative;">
                                            <input type="text" id="nro_documento" class="form-control" name="nro_documento" onchange="validateJS(event, 'nro_documento')"  required>
                                            <label for="nro_documento">Nro Documento</label>
                                            <div class="invalid-feedback">Ingrese el Nro de Documento</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i>Nro Documento <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nro_documento" onchange="validateJS(event, 'nro_documento')" name="nro_documento" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el Nro de Documento</div>

                                    </div>

                                    <div class="col-6 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <input type="text" id="nombre_cliente_razon_social" class="form-control text-uppercase" name="nombre_cliente_razon_social" required>
                                            <label for="nombre_cliente_razon_social">Nombre del Cliente / Razón Social</label>
                                            <div class="invalid-feedback">Ingrese el Nombre/Razón Social del Cliente</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-user-tie mr-1 my-text-color"></i>Nombre del Cliente / Razón Social <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="nombre_cliente_razon_social" name="nombre_cliente_razon_social" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el Nombre/Razón Social del Cliente</div>

                                    </div>

                                    <div class="col-7 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <input type="text" id="direccion" class="form-control text-uppercase" name="direccion" required>
                                            <label for="direccion">Dirección</label>
                                            <div class="invalid-feedback">Ingrese la dirección del Cliente</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-map-marker-alt mr-1 my-text-color"></i>Dirección <strong class="text-danger fw-bold">*</strong></label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="direccion" name="direccion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la dirección del Cliente</div>

                                    </div>

                                    <div class="col-2 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <input type="text" id="telefono" class="form-control" name="telefono">
                                            <label for="telefono">Teléfono</label>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-phone-alt mr-1 my-text-color"></i>Teléfono</label>
                                        <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="telefono" name="telefono" aria-label="Small" aria-describedby="inputGroup-sizing-sm">

                                    </div>

                                    <!-- ESTADO -->
                                    <div class="col-3 mb-2">
                                        <!-- <div class="form-floating mb-2">
                                            <select class="form-select select2" id="estado" name="estado" aria-label="Floating label select example" required>
                                                <option value="" disabled>--Seleccione un estado--</option>
                                                <option value="1" selected>ACTIVO</option>
                                                <option value="0">INACTIVO</option>
                                            </select>
                                            <label for="estado">Estado</label>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-toggle-on mr-1 my-text-color"></i>Estado <strong class="text-danger fw-bold">*</strong></label>
                                        <select class="form-select" id="estado" name="estado" aria-label="Floating label select example" required>
                                            <option value="" disabled>--Seleccione un estado--</option>
                                            <option value="1" selected>ACTIVO</option>
                                            <option value="0">INACTIVO</option>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el estado</div>
                                    </div>


                                    <div class="col-12 mb-2 mt-2">
                                        <!-- <div class="float-right">
                                            <a class="btn btn-outline-danger mx-1" id="btnCancelarCliente">CANCELAR</a>
                                            <a class="btn btn-outline-success mx-1" id="btnRegistrarCliente">GUARDAR CLIENTE</a>
                                        </div> -->

                                        <div class="row">
                                            <div class="offset-6 col-6 text-right">
                                                <a class="btn btn-sm btn-danger  fw-bold w-25" id="btnCancelarCliente" style="position: relative;">
                                                    <span class="text-button">CANCELAR</span>
                                                    <span class="btn fw-bold icon-btn-danger d-flex align-items-center">
                                                        <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                    </span>
                                                </a>

                                                <a class="btn btn-sm btn-success  fw-bold w-25" id="btnRegistrarCliente" style="position: relative;">
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
        fnc_CargarDatatableClientes();

        $("#btnRegistrarCliente").on('click', function() {
            fnc_GuardarDatosCliente();
        });

        $("#tipo_documento").change(function() {
            $("#nro_documento").val('');
            $("#nro_documento").prop('disabled', false);
            $("#nro_documento").attr('tipo_documento', $("#tipo_documento").val())
        });

        $('#tbl_clientes tbody').on('click', '.btnEditarCliente', function() {
            fnc_IrFormularioActualizarCliente($(this));
        });

        $("#btnCancelarCliente").on('click', function() {
            fnc_LimpiarFomulario();
        });

        $("#registrar-clientes-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        $("#listado-clientes-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

    })

    function CargarSelects() {
        CargarSelect(null, $("#tipo_documento"), "--Seleccione Tipo Documento--", "ajax/ventas.ajax.php", 'obtener_tipo_documento', null, 0);
        $('.select2').select2()
    }

    function fnc_CargarDatatableClientes() {

        if ($.fn.DataTable.isDataTable('#tbl_clientes')) {
            $('#tbl_clientes').DataTable().destroy();
            $('#tbl_clientes tbody').empty();
        }

        $("#tbl_clientes").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE CLIENTES';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/clientes.ajax.php',
                data: {
                    'accion': 'obtener_clientes'
                },
                type: 'POST'
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
                    targets: 9,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[9] != 'ACTIVO') {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        }
                    }
                },
                {
                    targets: 1,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                        $(td).html("<span class='btnEditarCliente text-primary px-1' style='cursor:pointer;'>" +
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

    function fnc_GuardarDatosCliente() {

        let accion = '';
        form_clientes_validate = validarFormulario('needs-validation-clientes');

        //INICIO DE LAS VALIDACIONES
        if (!form_clientes_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de guardar los datos del Cliente?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si!',
            cancelButtonText: 'No',
        }).then((result) => {

            if (result.isConfirmed) {

                if ($("#id_cliente").val() > 0) accion = 'actualizar_cliente'
                else accion = 'registrar_cliente'

                var formData = new FormData();

                formData.append('accion', accion);
                formData.append('datos_cliente', $("#frm-datos-clientes").serialize());

                response = SolicitudAjax('ajax/clientes.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response['tipo_msj'],
                    title: response['msj'],
                    showConfirmButton: true
                });

                $("#tbl_clientes").DataTable().ajax.reload();
                fnc_LimpiarFomulario();

            }

        })
    }

    function fnc_IrFormularioActualizarCliente(fila_actualizar) {

        if (fila_actualizar.parents('tr').hasClass('selected')) {
            fnc_LimpiarFomulario();
        } else {

            // $("#listado-clientes-tab").prop('disabled', true)

            //ACTIVAR PANE REGISTRO DE PROVEEDORES:
            $("#registrar-clientes-tab").addClass('active')
            $("#registrar-clientes-tab").attr('aria-selected', true)
            $("#registrar-clientes").addClass('active show')

            //DESACTIVAR PANE LISTADO DE PROVEEDORES:
            $("#listado-clientes-tab").removeClass('active')
            $("#listado-clientes-tab").attr('aria-selected', false)
            $("#listado-clientes").removeClass('active show');

            // $("#registrar-proveedores-tab").html('Actualizar Proveedor')
            $("#registrar-clientes-tab").html('<i class="fas fa-sync-alt"></i> Actualizar Cliente')

            var data = (fila_actualizar.parents('tr').hasClass('child')) ?
                $("#tbl_clientes").DataTable().row(fila_actualizar.parents().prev('tr')).data() :
                $("#tbl_clientes").DataTable().row(fila_actualizar.parents('tr')).data();


            $("#id_cliente").val(data['2']);
            $("#tipo_documento").select2("val", (data['3']));
            $("#nro_documento").val(data['5']);
            $("#nro_documento").prop('disabled', false);
            $("#nro_documento").attr('id_cliente', data['2'])
            $("#nombre_cliente_razon_social").val(data['6']);
            $("#direccion").val(data['7']);
            $("#telefono").val(data['8']);
            if (data['9'] == "ACTIVO") $("#estado").select2("val", "1")
            else $("#estado").select2("val", "0");


        }

    }

    function fnc_LimpiarFomulario() {

        //LIMPIAR MENSAJES DE VALIDACION
        $(".needs-validation-clientes").removeClass("was-validated");
        $(".form-floating").removeClass("was-validated");

        CargarSelects();
        $("#id_cliente").val('');
        $("#nro_documento").val('');
        $("#nro_documento").prop('disabled', true);
        $("#nro_documento").removeAttr('tipo_documento')
        $("#nro_documento").attr('id_cliente', -1)
        $("#nombre_cliente_razon_social").val('');
        $("#direccion").val('');
        $("#telefono").val('');
        $("#listado-clientes-tab").prop('disabled', false)

        $("#listado-clientes-tab").addClass('active')
        $("#listado-clientes-tab").attr('aria-selected', true)
        $("#listado-clientes").addClass('active show')

        //DESACTIVAR PANE LISTADO DE PROVEEDORES:
        $("#registrar-clientes-tab").removeClass('active')
        $("#registrar-clientes-tab").attr('aria-selected', false)
        $("#registrar-clientes").removeClass('active show')

        $("#registrar-clientes-tab").html('<i class="fas fa-file-signature"></i> Registrar')


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