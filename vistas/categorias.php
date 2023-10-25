<div class="content-header">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <h2 class="m-0 fw-bold">ADMINISTRAR CATEGORÍAS</h2>
            </div>
            <div class="col-md-6">
                <ol class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item">Productos</li>
                    <li class="breadcrumb-item active">Categorías</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<div class="content pb-2">

    <div class="row p-0 m-0">


        <!--LISTADO DE CATEGORIAS -->
        <div class="col-12 col-lg-8">
            <div class="card card-gray shadow">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-list"></i> Listado de Categorias</h3>
                </div>
                <div class="card-body">
                    <table id="tbl_categorias" class="table table-striped w-100 shadow border border-secondary">
                        <thead class="bg-gray text-left">
                            <th>id</th>
                            <th>Categoría</th>
                            <!-- <th>Medida</th> -->
                            <th>Estado</th>
                            <th>F. Creación</th>

                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <!--FORMULARIO PARA REGISTRO Y EDICION -->
        <div class="d-none d-lg-block col-lg-4">
            <div class="card card-gray shadow">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-edit"></i> Registro de Categorías</h3>
                </div>
                <div class="card-body">

                    <form class="needs-validation-categorias" novalidate>

                        <div class="row">

                            <div class="col-md-12">

                                <!-- <div class="form-floating mb-2">

                                    <input type="text" id="descripcion" class="form-control" name="descripcion" required>
                                    <label for="descripcion">Categoria</label>
                                    <div class="invalid-feedback">Ingrese la categoría</div>
                                </div> -->
                                <label class="mb-0 ml-1 text-sm my-text-color"><i class="fas fa-layer-group mr-1 my-text-color"></i>Categorpia</label>
                                <input type="text" style="border-radius: 20px;" class="form-control form-control-sm" id="descripcion" name="descripcion" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
                                <div class="invalid-feedback">Ingrese la categoría</div>
                            </div>

                            <div class="col-md-12 mt-3 text-center">

                                <!-- <div class="form-group m-0 mt-2">
                                    <a style="cursor:pointer;" class="btn btn-primary btn-sm w-100" id="btnRegistrarCategoria">Registrar Categoría
                                    </a>
                                </div> -->

                                <a class="btn btn-sm btn-success  fw-bold " id="btnRegistrarCategoria" style="position: relative; width: 50%;">
                                    <span class="text-button">GUARDAR</span>
                                    <span class="btn fw-bold icon-btn-success d-flex align-items-center">
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

</div>

<script>
    var flag_accion = 'registrar_categoria';

    //variables para registrar o editar la categoria
    var idCategoria = 0;
    var categoria = "";
    var medida = "";

    $(document).ready(function() {

        fnc_CargarDatatableCategorias();

        $("#btnRegistrarCategoria").on('click', function() {
            fnc_guardarCategoria();
        })
    })

    function fnc_CargarDatatableCategorias() {

        if ($.fn.DataTable.isDataTable('#tbl_categorias')) {
            $('#tbl_categorias').DataTable().destroy();
            $('#tbl_categorias tbody').empty();
        }

        $("#tbl_categorias").DataTable({
            // bFilter: false,
            // bPaginate: false,
            dom: 'Bfrtip',
            buttons: [{
                extend: 'excel',
                title: function() {
                    var printTitle = 'LISTADO DE CATEGORÍAS';
                    return printTitle
                }
            }, 'pageLength'],
            processing: true,
            serverSide: true,
            order: [],
            ajax: {
                url: 'ajax/categorias.ajax.php',
                data: {
                    'accion': 'listar_categorias'
                },
                type: 'POST'
            },
            columnDefs: [{
                    targets: 2,
                    createdCell: function(td, cellData, rowData, row, col) {

                        if (rowData[2] == 'ACTIVO') {
                            $(td).html('<span class="bg-success px-2 py-1 rounded-pill fw-bold"> ' + rowData[2] + ' </span>')
                        }

                        if (rowData[2] == 'INACTIVO') {
                            $(td).html('<span class="bg-danger px-2 py-1 rounded-pill fw-bold"> ' + rowData[2] + ' </span>')
                        }

                    }
                },


            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
            }
        })

        $("#tbl_categorias").on('draw.dt', function() {
            $("#tbl_categorias").Tabledit({
                url: 'ajax/actions_editable/actions_categorias.php',
                dataType: 'json',
                columns: {
                    identifier: [0, 'id'],
                    editable: [
                        [1, 'descripcion']
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
                        class: 'btn btn-sm mx-1 p-0  data-bs-toggle="tooltip" data-bs-placement="top" title="Activar/Desactivar Categoría"',
                        html: '<i class="fas fa-toggle-on text-danger fs-5"></i>',
                        action: 'delete'
                    },
                    save: {
                        class: 'btn btn-sm btn-success p-0 px-1 rounded-pill',
                        html: '<i class="fas fa-check "></i>'
                    },
                    restore: {
                        class: 'btn btn-sm btn-warning',
                        html: 'Restore',
                        action: 'restore'
                    },
                    confirm: {
                        class: 'btn btn-sm btn-danger p-0 px-1 rounded-pill',
                        html: '<i class="fas fa-check "></i>'
                    }
                },
                onSuccess: function(data, textStatus, jqXHR) {
                    if (data.action == "delete") {
                        mensajeToast("success", "Se actualizó el estado de la Categoría")
                        $("#tbl_categorias").DataTable().ajax.reload();
                    }
                    if (data.action == "edit") {
                        mensajeToast("success", "Se actualizó la Categoría")
                        // fnc_ObtenerEstadoCajaPorDia();
                        $("#tbl_categorias").DataTable().ajax.reload();
                    }
                }
            })
        })

        // $('#tbl_categorias').DataTable({
        //     dom: 'Bfrtip',
        //     buttons: [
        //         'excel', 'print', 'pageLength',
        //     ],
        //     ajax: {
        //         url: 'ajax/categorias.ajax.php',
        //         type: 'POST',
        //         data: {
        //             'accion': 'listar_categorias'
        //         },
        //         dataSrc: ""
        //     },
        //     scrollX: true,
        //     columnDefs: [
        //         {
        //             targets: 1,
        //             render: function(data, type, full, meta) {
        //                 return "<div class='text-wrap width-200'>" + data + "</div>";
        //             }

        //         },
        //         {
        //             targets: 2,
        //             sortable: false,
        //             createdCell: function(td, cellData, rowData, row, col) {

        //                 if (parseInt(rowData[2]) == 0) {
        //                     $(td).html("Und(s)")
        //                 } else {
        //                     $(td).html("Kg(s)")
        //                 }

        //             }
        //         },
        //         {
        //             targets: 5,
        //             sortable: false,
        //             render: function(data, type, full, meta) {
        //                 return "<center>" +
        //                     "<span class='btnEditarCategoria text-primary px-1' style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Editar Categoría'> " +
        //                     "<i class='fas fa-pencil-alt fs-5'></i> " +
        //                     "</span> " +
        //                     "<span class='btnEliminarCategoria text-danger px-1'style='cursor:pointer;' data-bs-toggle='tooltip' data-bs-placement='top' title='Eliminar Categoría'> " +
        //                     "<i class='fas fa-trash fs-5'> </i> " +
        //                     "</span>" +
        //                     "</center>";
        //             }
        //         }
        //     ],
        //     "order": [
        //         [1, 'asc']
        //     ],
        //     lengthMenu: [0, 5, 10, 15, 20, 50],
        //     "pageLength": 15,
        //     "language": {
        //         "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
        //     }
        // });
    }

    function fnc_guardarCategoria() {

        // alert("entro")
        form_categorias_validate = validarFormulario('needs-validation-categorias');

        if (!form_categorias_validate) {
            mensajeToast("error", "complete los datos obligatorios");
            return;
        }

        Swal.fire({
            title: 'Está seguro de registrar la categoría?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Aceptar!',
            cancelButtonText: 'Cancelar!',
        }).then((result) => {

            if (result.isConfirmed) {

                var formData = new FormData();
                formData.append('accion', 'registrar_categoria');
                formData.append("categoria", $("#descripcion").val());

                response = SolicitudAjax("ajax/categorias.ajax.php", "POST", formData);

                Swal.fire({
                    position: 'top-center',
                    icon: response.tipo_msj,
                    title: response.msj,
                    showConfirmButton: true
                })

                $("#descripcion").val("");

                $('#tbl_categorias').DataTable().ajax.reload();
                $(".needs-validation-categorias").removeClass("was-validated");

            }
        })
    }
</script>