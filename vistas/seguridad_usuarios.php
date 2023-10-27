<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">ADMINISTRAR USUARIOS</h2>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Administrar Usuarios</li>
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

                        <!-- TAB LISTADO DE USUARIOS -->
                        <li class="nav-item">
                            <a class="nav-link active my-0" id="listado-usuarios-tab" data-toggle="pill" href="#listado-usuarios" role="tab" aria-controls="listado-usuarios" aria-selected="true"><i class="fas fa-list"></i> Listado de Usuarios</a>
                        </li>

                        <!-- TAB REGISTRO DE USUARIOS -->
                        <li class="nav-item">
                            <a class="nav-link my-0" id="registrar-usuarios-tab" data-toggle="pill" href="#registrar-usuarios" role="tab" aria-controls="registrar-usuarios" aria-selected="false"><i class="fas fa-file-signature"></i> Registro de Usuario</a>
                        </li>
                    </ul>

                </div>

                <div class="card-body">

                    <div class="tab-content" id="custom-tabs-four-tabContent">

                        <!-- TAB CONTENT LISTADO DE USUARIOS -->
                        <div class="tab-pane fade active show" id="listado-usuarios" role="tabpanel" aria-labelledby="listado-usuarios-tab">

                            <div class="row">

                                <!--LISTADO DE USUARIOS -->
                                <div class="col-md-12">
                                    <table id="tbl_usuarios" class="table table-striped w-100 shadow border border-secondary">
                                        <thead class="bg-main text-left">
                                            <th> </th> <!-- 0 -->
                                            <th></th>
                                            <th>id</th>
                                            <th>Nombres</th>
                                            <th>Apellidos</th>
                                            <th>Usuario</th>
                                            <th>Id. Perfil</th>
                                            <th>Perfil</th>
                                            <th>Id. Caja</th>
                                            <th>Caja</th>
                                            <th>Estado</th><!-- 10 -->
                                        </thead>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <!-- TAB CONTENT REGISTRO DE USUARIOS -->
                        <div class="tab-pane fade" id="registrar-usuarios" role="tabpanel" aria-labelledby="registrar-usuarios-tab">

                            <form id="frm-datos-usuarios" class="needs-validation-usuarios" novalidate>

                                <div class="row">

                                    <!-- NOMBRES -->
                                    <div class="col-4 mb-2">
                                        <input type="hidden" name="id_usuario" id="id_usuario" value="0">
                                        <!-- <div class="form-floating mb-2" style="position: relative;">
                                            <input type="text" id="nombres" class="form-control text-uppercase" name="nombres" required>
                                            <label for="nombres">Nombres</label>
                                            <div class="invalid-feedback">Ingrese el nombre del usuario</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-user-alt mr-1 my-text-color"></i>Nombres</label>
                                        <input type="text" style="border-radius: 20px;" placeholder="Ingrese los nombres del usuario" class="form-control form-control-sm " id="nombres" name="nombres" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el nombre del usuario</div>
                                    </div>

                                    <!-- APELLIDOS -->
                                    <div class="col-4 mb-2">

                                        <!-- <div class="form-floating mb-2"> -->
                                        <!-- <input type="text" id="apellidos" class="form-control " name="apellidos" required>
                                            <label for="apellidos">Apellidos</label> -->
                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-user-alt mr-1 my-text-color"></i>Apellidos</label>
                                        <input type="text" style="border-radius: 20px;" placeholder="Ingrese los apellidos del usuario" class="form-control form-control-sm " id="apellidos" name="apellidos" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese el apellidos del usuario</div>
                                        <!-- </div> -->

                                    </div>

                                    <!-- USUARIO DEL SISTEMA -->
                                    <div class="col-4 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <input type="text" id="usuario" class="form-control" name="usuario" onchange="validateJS(event, 'usuario_sistema')" required>
                                            <label for="usuario">Usuario del Sistema</label>
                                            <div class="invalid-feedback">Ingrese el usuario</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card mr-1 my-text-color"></i>Usuario del Sistema</label>
                                        <input type="text" style="border-radius: 20px;" placeholder="Ingrese el usuario del sistema" class="form-control form-control-sm" id="usuario" name="usuario" aria-label="Small" id_usuario="0" aria-describedby="inputGroup-sizing-sm" onchange="validateJS(event, 'usuario_sistema')" required>
                                        <div class="invalid-feedback">Ingrese usuario del sistema</div>
                                    </div>

                                    <!-- PASSWORD -->
                                    <div class="col-3 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <input type="password" id="password" class="form-control" name="password" required>
                                            <label for="password">Contraseña</label>
                                            <div class="invalid-feedback">Ingrese la contraseña</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-lock mr-1 my-text-color"></i>Contraseña</label>
                                        <input type="password" style="border-radius: 20px;" placeholder="Ingrese el password" class="form-control form-control-sm" id="password" name="password" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la contraseña</div>

                                    </div>

                                    <!-- CONFIRMAR PASSWORD -->
                                    <div class="col-3 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <input type="password" id="confirmar_password" class="form-control" name="confirmar_password" required>
                                            <label for="confirmar_password">Confirmar Contraseña</label>
                                            <div class="invalid-feedback">Ingrese la confirmación</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-lock mr-1 my-text-color"></i>Confirmar Contraseña</label>
                                        <input type="password" style="border-radius: 20px;" placeholder="Ingrese confirmacion de password" class="form-control form-control-sm" id="confirmar_password" name="confirmar_password" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                        <div class="invalid-feedback">Ingrese la confirmación</div>

                                    </div>

                                    <!-- PERFIL -->
                                    <div class="col-3 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <select class="form-select select2" id="perfil" name="perfil" aria-label="Floating label select example" required>
                                            </select>
                                            <label for="perfil">Perfil</label>
                                            <div class="invalid-feedback">Seleccione el Perfil</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-id-card-alt mr-1 my-text-color"></i>Perfil</label>
                                        <select class="form-select" id="perfil" name="perfil" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione el Perfil</div>
                                    </div>

                                    <!-- CAJA -->
                                    <div class="col-3 mb-2">

                                        <!-- <div class="form-floating mb-2">
                                            <select class="form-select select2" id="caja" name="caja" aria-label="Floating label select example" required>
                                            </select>
                                            <label for="caja">Caja</label>
                                            <div class="invalid-feedback">Seleccione la caja</div>
                                        </div> -->

                                        <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-cash-register mr-1 my-text-color"></i>Caja</label>
                                        <select class="form-select" id="caja" name="caja" aria-label="Floating label select example" required>
                                        </select>
                                        <div class="invalid-feedback">Seleccione la caja</div>

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
                                            <!-- <a class="btn btn-outline-danger mx-1" id="btnCancelarUsuario">CANCELAR</a>
                                            <a class="btn btn-outline-success mx-1" id="btnRegistrarUsuario">GUARDAR USUARIO</a> -->

                                            <a class="btn btn-sm btn-danger  fw-bold " id="btnCancelarUsuario" style="position: relative; width: 160px;">
                                                <span class="text-button">CANCELAR</span>
                                                <span class="btn fw-bold icon-btn-danger ">
                                                    <i class="fas fa-times fs-5 text-white m-0 p-0"></i>
                                                </span>
                                            </a>

                                            <a class="btn btn-sm btn-success  fw-bold " id="btnRegistrarUsuario" style="position: relative; width: 160px;">
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
        fnc_CargarDatatableUsuarios();


        $("#confirmar_password").change(function() {
            if ($("#confirmar_password").val() != $("#password").val()) {

                $("#confirmar_password").parent().addClass("was-validated")
                $("#confirmar_password").parent().children(".invalid-feedback").html("Las contraseñas no coinciden");
                $("#confirmar_password").val("") //limpiar el valor para que se muestre el mensaje de validación
                return;
            }
        })

        $("#password").change(function() {

            if ($("#password").val().length < 6) {
                $("#password").parent().addClass("was-validated")
                $("#password").parent().children(".invalid-feedback").html("Mínimo 6 caracteres");
                $("#password").val("") //limpiar el valor para que se muestre el mensaje de validación
                return;
            }
        })


        $("#btnCancelarUsuario").on('click', function() {
            fnc_LimpiarFomulario();
        });

        $("#registrar-usuarios-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        $("#listado-usuarios-tab").on('click', function() {
            fnc_LimpiarFomulario();
        })

        $("#btnRegistrarUsuario").on('click', function() {
            fnc_GuardarDatosUsuario();
        });

        $('#tbl_usuarios tbody').on('click', '.btnEditarUsuario', function() {
            fnc_IrFormularioActualizarUsuario($(this));
        });

    })

    function CargarSelects() {
        CargarSelect(null, $("#perfil"), "--Seleccione Perfil--", "ajax/perfiles.ajax.php", 'listar_perfiles_select', null, 0);
        CargarSelect(null, $("#caja"), "--Seleccione Caja--", "ajax/cajas.ajax.php", 'listar_cajas_select', null, 0);
        // $('.select2').select2()
    }

    function fnc_CargarDatatableUsuarios() {

        if ($.fn.DataTable.isDataTable('#tbl_usuarios')) {
            $('#tbl_usuarios').DataTable().destroy();
            $('#tbl_usuarios tbody').empty();
        }

        $("#tbl_usuarios").DataTable({
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE USUARIOS';
                    return printTitle
                }
            }, 'pageLength'],
            pageLength: 10,
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/usuarios.ajax.php',
                data: {
                    'accion': 'obtener_usuarios'
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
                    targets: [6, 8],
                    visible: false
                },
                {
                    targets: 10,
                    createdCell: function(td, cellData, rowData, row, col) {
                        if (rowData[10] != 'ACTIVO') {
                            $(td).parent().css('background', '#F2D7D5')
                            $(td).parent().css('color', 'black')
                        }
                    }
                },
                {
                    targets: 1,
                    orderable: false,
                    createdCell: function(td, cellData, rowData, row, col) {
                        $(td).html("<span class='btnEditarUsuario text-primary px-1' style='cursor:pointer;'>" +
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

    function fnc_GuardarDatosUsuario() {

        let accion = '';
        form_usuarios_validate = validarFormulario('needs-validation-usuarios');

        //INICIO DE LAS VALIDACIONES
        if (!form_usuarios_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro(a) de guardar los datos del Usuario?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si!',
            cancelButtonText: 'No',
        }).then((result) => {

            if (result.isConfirmed) {

                if ($("#id_usuario").val() > 0) accion = 'actualizar_usuario'
                else accion = 'registrar_usuario'

                var formData = new FormData();

                formData.append('accion', accion);
                formData.append('datos_usuario', $("#frm-datos-usuarios").serialize());

                response = SolicitudAjax('ajax/usuarios.ajax.php', 'POST', formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response['tipo_msj'],
                    title: response['msj'],
                    showConfirmButton: true,
                    timer: 2000
                });

                $("#tbl_usuarios").DataTable().ajax.reload();
                fnc_LimpiarFomulario();

            }

        })
    }

    function fnc_IrFormularioActualizarUsuario(fila_actualizar) {

        if (fila_actualizar.parents('tr').hasClass('selected')) {
            fnc_LimpiarFomulario();
        } else {


            //ACTIVAR PANE REGISTRO DE PROVEEDORES:
            $("#registrar-usuarios-tab").addClass('active')
            $("#registrar-usuarios-tab").attr('aria-selected', true)
            $("#registrar-usuarios").addClass('active show')

            //DESACTIVAR PANE LISTADO DE PROVEEDORES:
            $("#listado-usuarios-tab").removeClass('active')
            $("#listado-usuarios-tab").attr('aria-selected', false)
            $("#listado-usuarios").removeClass('active show');

            // $("#registrar-proveedores-tab").html('Actualizar Proveedor')
            $("#registrar-usuarios-tab").html('<i class="fas fa-sync-alt"></i> Actualizar Usuario')

            var data = (fila_actualizar.parents('tr').hasClass('child')) ?
                $("#tbl_usuarios").DataTable().row(fila_actualizar.parents().prev('tr')).data() :
                $("#tbl_usuarios").DataTable().row(fila_actualizar.parents('tr')).data();

            // CUANDO ES ACTUALIZA NO ES OBLIGATORIO ENVIAR LA CONTRASEÑA
            $("#password").removeAttr('required')
            $("#password").prop('disabled', true)
            $("#confirmar_password").removeAttr('required')
            $("#confirmar_password").prop('disabled', true)

            $("#id_usuario").val(data['2']);
            $("#nombres").val(data['3']);
            $("#apellidos").val(data['4']);
            $("#usuario").val(data['5']);
            $("#usuario").attr('id_usuario', data['2'])
            $("#perfil").val(data['6']);
            $("#caja").val((data['8']));
            if (data['10'] == "ACTIVO") $("#estado").select2("val", "1")
            else $("#estado").select2("val", "0");


        }

    }

    function fnc_LimpiarFomulario() {

        //LIMPIAR MENSAJES DE VALIDACION
        $(".needs-validation-usuarios").removeClass("was-validated");
        $(".form-floating").removeClass("was-validated");

        CargarSelects();
        $("#id_usuario").val('');
        $("#nombres").val('');
        $("#apellidos").val('');
        $("#usuario").val('')
        $("#usuario").attr('id_usuario', -1)

        $("#password").val('')
        $("#password").prop('required', true)
        $("#password").prop('disabled', false)

        $("#confirmar_password").val('')
        $("#confirmar_password").prop('required', true)
        $("#confirmar_password").prop('disabled', false)


        $("#listado-usuarios-tab").prop('disabled', false)

        $("#listado-usuarios-tab").addClass('active')
        $("#listado-usuarios-tab").attr('aria-selected', true)
        $("#listado-usuarios").addClass('active show')

        //DESACTIVAR PANE LISTADO DE PROVEEDORES:
        $("#registrar-usuarios-tab").removeClass('active')
        $("#registrar-usuarios-tab").attr('aria-selected', false)
        $("#registrar-usuarios").removeClass('active show')

        $("#registrar-usuarios-tab").html('<i class="fas fa-file-signature"></i> Registrar')


    }

    // function ajustarHeadersDataTables(element) {

    //     var observer = window.ResizeObserver ? new ResizeObserver(function(entries) {
    //         entries.forEach(function(entry) {
    //             $(entry.target).DataTable().columns.adjust();
    //         });
    //     }) : null;

    //     // Function to add a datatable to the ResizeObserver entries array
    //     resizeHandler = function($table) {
    //         if (observer)
    //             observer.observe($table[0]);
    //     };

    //     // Initiate additional resize handling on datatable
    //     resizeHandler(element);

    // }
</script>