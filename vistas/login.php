<html lang="">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MAGA Y TITO | Login</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="vistas/assets/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="vistas/assets/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="vistas/assets/dist/css/adminlte.min.css">

    <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="vistas/assets/dist/css/style_login.css" />


    <style>
        .container,
        .container-lg,
        .container-md,
        .container-sm,
        .container-xl {
            min-width: 100%;
        }
    </style>
</head>
<!-- <body class="hold-transition login-page" style="background-image: url('vistas/assets/imagenes/fondo_login_2.jpg');  background-repeat: no-repeat;  background-position: 0% 50%; background-size: 100% 110%;"> -->

<body>

    <div class="container">

        <div class="forms-container">
            <div class="signin-signup">

                <form class="sign-in-form needs-validation-login" novalidate>
                    <h2 class="title">INICIAR SESION</h2>
                    <div class="input-field">
                        <i class="fas fa-user"></i>
                        <input type="text" placeholder="Usuario" id="loginUsuario" required />
                    </div>
                    <div class="input-field">
                        <i class="fas fa-lock"></i>
                        <input type="password" placeholder="Contraseña" id="loginPassword" required />
                    </div>
                    <a class="btn btn-md w-50" id="btnIniciarSesion">
                        INGRESAR
                    </a>

                    <a style="cursor: pointer;" class="fw-bold text-secondary mt-2" id="btnReestablecerPassword">Reestablecer Contraseña</a>

                </form>

            </div>
        </div>

        <div class="panels-container">

            <div class="panel left-panel">
                <div class="content">
                    <h3>No tienes cuenta ?</h3>
                    <p>
                        Explora las funcionalidades que te ofrece el sistema de punto de venta con Facturación Electrónica
                    </p>

                </div>
                <img src="vistas/assets/dist/img/log.svg" class="image" alt="" />
            </div>
        </div>

    </div>

    <!-- =============================================================================================================================
    VENTA MODAL PARA CAMBIAR PASSWORD
    ===============================================================================================================================-->
    <div class="modal fade" id="modalReestablecerPassword" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header bg-gray py-2">
                    <h6 class="modal-title" id="titulo_modal_stock">Reestablecer Contraseña</h6>
                    <button type="button" class="btn-close text-white fs-6" data-bs-dismiss="modal" aria-label="Close">
                    </button>
                </div>

                <div class="modal-body">

                </div>

                <div class="modal-footer">
                    <a class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="btnCancelarRegistroStock">Cancelar</a>
                    <a class="btn btn-primary btn-sm" id="btnGuardarNuevorStock">Guardar</a>
                </div>

            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="vistas/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="vistas/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="vistas/assets/dist/js/adminlte.min.js"></script>

    <script>
        $(document).ready(function() {

            $("#btnIniciarSesion").on('click', function() {
                // alert("entro")
                fnc_login();
            })

            $('#loginPassword').keypress(function(e) {
                var key = e.which;
                if (key == 13) // the enter key code
                {
                    fnc_login();
                }
            });

            $("#btnReestablecerPassword").on('click', function() {
                $("#modalReestablecerPassword").modal('show');
            })
        })

        function fnc_login() {


            var forms = document.getElementsByClassName('needs-validation-login');

            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {

                if (form.checkValidity() === true) {

                    var formData = new FormData();
                    formData.append('accion', 'login');
                    formData.append('usuario', $("#loginUsuario").val());
                    formData.append('password', $("#loginPassword").val());


                    response = SolicitudAjax("ajax/auth.ajax.php", "POST", formData);


                    if (response["tipo_msj"] == "success") {
                        $("#btnIniciarSesion").addClass('disabled');
                        // Swal.fire({
                        //     position: 'center',
                        //     icon: response["tipo_msj"],
                        //     title: response["msj"],
                        //     showConfirmButton: false,
                        //     timer: 2000
                        // })

                        mensajeToast(response["tipo_msj"], response["msj"]);

                        setInterval(() => {
                            $("#btnIniciarSesion").removeClass('disabled');
                            window.location = "https://tutorialesphperu.com/pos/";
                        }, 1200);


                    } else {
                        mensajeToast(response["tipo_msj"], response["msj"]);
                        $("#btnIniciarSesion").removeClass('disabled');
                    }

                } else {
                    mensajeToast('error', 'Ingrese el usuario y contraseña');

                }

            })



        }

    </script>
</body>

</html>