<!DOCTYPE html>
<html lang="en">

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
</head>

<!-- <body class="hold-transition login-page" style="background-image: url('vistas/assets/imagenes/fondo_login_2.jpg');  background-repeat: no-repeat;  background-position: 0% 50%; background-size: 100% 110%;"> -->
<body class="hold-transition login-page">
    
    <div class="login-box" >

        <div class="card card-outline card-primary">

            <div class="card-header text-center">

                <h2 class="h2"><b>TUTORIALES PHPERU</b></h2>

            </div><!-- /.card-header -->

            <div class="card-body">

                <form method="post" class="needs-validation-login" autocomplete="off" novalidate>

                    <!-- USUARIO DEL SISTEMA -->
                    <div class="input-group mb-3">

                        <input type="text" class="form-control" placeholder="Usuario del sistema" id="loginUsuario" autocomplete="off" required>

                        <div class="input-group-append">

                            <div class="input-group-text" style="border-radius: 0px !important;">

                                <span class="fas fa-user"></span>

                            </div>

                        </div>

                        <div class="invalid-feedback">Debe ingresar su usuario!</div>

                    </div><!-- /.input-group USUARIO -->

                    <!-- PASSWORD DEL USUARIO DEL SISTEMA -->
                    <div class="input-group mb-3">

                        <input type="password" class="form-control" placeholder="ingrese su password" id="loginPassword" autocomplete="off" required>

                        <div class="input-group-append">

                            <div class="input-group-text" style="border-radius: 0px !important;">

                                <span class="fas fa-lock"></span>

                            </div>

                        </div>

                        <div class="invalid-feedback">Debe ingresar su contraseña!</div>

                    </div><!-- /.input-group PASSWORD -->

                    <div class="row">

                        <div class="col-md-12 text-center">

                            <!-- <a id="btnIniciarSesion" class="btn btn-info w-100">Iniciar Sesión</a> -->
                            <a class="btn btn-info w-100 fw-bold" id="btnIniciarSesion" style="position: relative;">
                                <span class="text-center">INICIAR SESION</span>
                            </a>

                        </div>

                    </div>

                </form>

            </div><!-- /.card-body -->

        </div>

    </div>
    <!-- /.login-box -->

    <!-- jQuery -->
    <script src="vistas/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="vistas/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="vistas/assets/dist/js/adminlte.min.js"></script>


    <script>
        $(document).ready(function() {

            $("#btnIniciarSesion").on('click', function() {
                fnc_login();
            })

            $('#loginPassword').keypress(function(e) {
                var key = e.which;
                if (key == 13) // the enter key code
                {
                    fnc_login();
                }
            });
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