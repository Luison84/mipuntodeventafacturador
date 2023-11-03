<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h2 class="m-0 fw-bold">TABLERO PRINCIPAL</h2>
            </div><!-- /.col -->
            <div class="col-sm-6 d-none d-md-block">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="index.php">Inicio</a></li>
                    <li class="breadcrumb-item active">Tablero Principal</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content">

    <div class="container-fluid">

        <!-- --------------------------------------------------------- -->
        <!-- TARJETAS INFORMATIVAS -->
        <!-- --------------------------------------------------------- -->
        <div class="row">

            <div class="col-6 col-md-4 col-lg-2 px-1">
                <!-- small box -->
                <div class="small-box bg-info">
                    <div class="inner px-1 text-center fw-bold">
                        <h6 id="totalProductos" class="fw-bold"></h6>

                        <p>Productos</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-clipboard"></i>
                    </div>
                    <!-- <a style="cursor:pointer;" class="small-box-footer">Mas Info <i class="fas fa-arrow-circle-right"></i></a> -->
                </div>
            </div>

            <!-- TARJETA TOTAL COMPRAS -->
            <div class="col-6 col-md-4 col-lg-2 px-1">
                <!-- small box -->
                <div class="small-box bg-success">
                    <div class="inner px-1 text-center fw-bold">
                        <h6 id="totalCompras" class="fw-bold"></h6>

                        <p>Costo Inventario</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-cash"></i>
                    </div>
                    <!-- <a style="cursor:pointer;" class="small-box-footer">Mas Info <i class="fas fa-arrow-circle-right"></i></a> -->
                </div>
            </div>

            <!-- TARJETA TOTAL VENTAS -->
            <div class="col-6 col-md-4 col-lg-2 px-1">
                <!-- small box -->
                <div class="small-box bg-warning">
                    <div class="inner px-1 text-center fw-bold">
                        <h6 id="totalVentas" class="fw-bold"></h6>

                        <p>Total Ventas</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-ios-cart"></i>
                    </div>
                    <!-- <a style="cursor:pointer;" class="small-box-footer">Mas Info <i class="fas fa-arrow-circle-right"></i></a> -->
                </div>
            </div>

            <!-- TARJETA TOTAL GANANCIAS -->
            <div class="col-6 col-md-4  col-lg-2 px-1">
                <!-- small box -->
                <div class="small-box bg-danger">
                    <div class="inner px-1 text-center fw-bold">
                        <h6 id="totalGanancias" class="fw-bold"></h6>

                        <p>Total Ganancias</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-ios-pie"></i>
                    </div>
                    <!-- <a style="cursor:pointer;" class="small-box-footer">Mas Info <i class="fas fa-arrow-circle-right"></i></a> -->
                </div>
            </div>

            <!-- TARJETA PRODUCTOS POCO STOCK -->
            <div class="col-6 col-md-4 col-lg-2 px-1">
                <!-- small box -->
                <div class="small-box bg-primary">
                    <div class="inner px-1 text-center fw-bold">
                        <h6 id="totalProductosMinStock" class="fw-bold"></h6>

                        <p>Productos poco stock</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-android-remove-circle"></i>
                    </div>
                    <!-- <a style="cursor:pointer;" class="small-box-footer">Mas Info <i class="fas fa-arrow-circle-right"></i></a> -->
                </div>
            </div>

            <!-- TARJETA TOTAL VENTAS DIA ACTUAL -->
            <div class="col-6 col-md-4 col-lg-2 px-1">
                <!-- small box -->
                <div class="small-box bg-secondary">
                    <div class="inner px-1 text-center fw-bold">
                        <h6 id="totalVentasHoy" class="fw-bold"></h6>

                        <p>Ventas del día</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-android-calendar"></i>
                    </div>
                    <!-- <a style="cursor:pointer;" class="small-box-footer">Mas Info <i class="fas fa-arrow-circle-right"></i></a> -->
                </div>
            </div>


        </div> <!-- ./row Tarjetas Informativas -->

        <!-- --------------------------------------------------------- -->
        <!-- GRÁFICO DE BARRAS Y DUNGHTS -->
        <!-- --------------------------------------------------------- -->
        <div class="row">

            <div class="col-12">

                <div class="card card-gray shadow">

                    <div class="card-header">

                        <h3 class="card-title" id="title-header-ventas-mes"></h3>

                        <div class="card-tools">

                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-tool" data-card-widget="remove">
                                <i class="fas fa-times"></i>
                            </button>

                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body">

                        <div class="chart">

                            <canvas id="barChart" style="min-height: 250px; height: 300px; max-height: 350px; width: 100%;">

                            </canvas>

                        </div>

                    </div> <!-- ./ end card-body -->

                </div>

            </div>


            <div class="col-6">

                <div class="card card-gray shadow">

                    <div class="card-header">

                        <h3 class="card-title"> TOP VENTAS POR CATEGORÍA</h3>

                        <div class="card-tools">

                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-tool" data-card-widget="remove">
                                <i class="fas fa-times"></i>
                            </button>

                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body">

                        <div class="chart">

                            <div id="chartContainer" style="min-height: 250px; height: 300px; max-height: 350px; width: 100%;"></div>

                        </div>

                    </div> <!-- ./ end card-body -->

                </div>

            </div>

            <div class="col-6">

                <div class="card card-gray shadow">

                    <div class="card-header">

                        <h3 class="card-title"> FACTURAS / BOLETAS</h3>

                        <div class="card-tools">

                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-tool" data-card-widget="remove">
                                <i class="fas fa-times"></i>
                            </button>

                        </div> <!-- ./ end card-tools -->

                    </div> <!-- ./ end card-header -->


                    <div class="card-body">

                        <div class="chart">

                            <div id="chartContainer" style="min-height: 250px; height: 300px; max-height: 350px; width: 100%;"></div>

                        </div>

                    </div> <!-- ./ end card-body -->

                </div>

            </div>

        </div><!-- ./row Grafico de barras y doughnut -->



    </div><!-- ./row Grafico de barras y doughnut -->

    <!-- --------------------------------------------------------- -->
    <!-- PRODUCTOS MAS VENDIDOS Y POCO STOCK -->
    <!-- --------------------------------------------------------- -->
    <div class="row">
        <div class="col-lg-6">
            <div class="card card-gray shadow">
                <div class="card-header">
                    <h3 class="card-title">LOS 10 PRODUCTOS MAS VENDIDOS</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>
                    </div> <!-- ./ end card-tools -->
                </div> <!-- ./ end card-header -->
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table" id="tbl_productos_mas_vendidos">
                            <thead>
                                <tr class="text-danger">
                                    <!-- <th>Cod. producto</th> -->
                                    <th>Producto</th>
                                    <th class="text-center">Cantidad</th>
                                    <th class="text-center">Ventas</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div> <!-- ./ end card-body -->
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card card-gray shadow">
                <div class="card-header">
                    <h3 class="card-title">PRODUCTOS CON POCO STOCK</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>
                    </div> <!-- ./ end card-tools -->
                </div> <!-- ./ end card-header -->
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table" id="tbl_productos_poco_stock">
                            <thead>
                                <tr class="text-danger">
                                    <!-- <th>Cod. producto</th> -->
                                    <th>Producto</th>
                                    <th class="text-center">Stock Actual</th>
                                    <th class="text-center">Mín. Stock</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div> <!-- ./ end card-body -->
            </div>
        </div>
    </div>

</div><!-- /.container-fluid -->

</div>
<!-- /.content -->

<script>
    $(document).ready(function() {

        cargarTarjetasInformativas();
        cargarGraficoBarras();
        cargarGraficoDoughnut();
        cargarProductosMasVendidos();
        cargarProductosPocoStock();


        setInterval(() => {
            $.ajax({
                url: "ajax/dashboard.ajax.php",
                method: 'POST',
                data: {
                    'accion': 'datos_dashboard'
                },
                dataType: 'json',
                success: function(respuesta) {

                    $("#totalProductos").html(respuesta[0]['totalProductos']);
                    $("#totalCompras").html(respuesta[0]['totalCompras'])
                    $("#totalVentas").html(respuesta[0]['totalVentas'])
                    $("#totalGanancias").html(respuesta[0]['ganancias'])
                    $("#totalProductosMinStock").html(respuesta[0]['productosPocoStock'])
                    $("#totalVentasHoy").html(respuesta[0]['ventasHoy'])

                    // cargarTarjetasInformativas();
                    // cargarGraficoBarras();
                    // cargarGraficoDoughnut();
                    // cargarProductosMasVendidos();
                    // cargarProductosPocoStock();

                }
            });
        }, 30000);


    })

    /* =======================================================
    SOLICITUD AJAX TARJETAS INFORMATIVAS
    =======================================================*/
    function cargarTarjetasInformativas() {

        $.ajax({
            url: "ajax/dashboard.ajax.php",
            method: 'POST',
            data: {
                'accion': 'datos_dashboard'
            },
            dataType: 'json',
            success: function(respuesta) {
                $("#totalProductos").html(respuesta[0]['totalProductos']);
                $("#totalCompras").html(respuesta[0]['totalCompras'])
                $("#totalVentas").html(respuesta[0]['totalVentas'])
                $("#totalGanancias").html(respuesta[0]['ganancias'])
                $("#totalProductosMinStock").html(respuesta[0]['productosPocoStock'])
                $("#totalVentasHoy").html(respuesta[0]['ventasHoy'])
            }
        });

    }


    /* =======================================================
    SOLICITUD AJAX GRAFICO DE BARRAS DE VENTAS DEL MES
    =======================================================*/
    function cargarGraficoBarras() {

        $.ajax({
            url: "ajax/dashboard.ajax.php",
            method: 'POST',
            data: {
                'accion': 'grafico_barras' //parametro para obtener las ventas del mes
            },
            dataType: 'json',
            success: function(respuesta) {

                var fecha_venta = [];
                var total_venta = [];
                var total_venta_ant = [];

                var mes_actual = new Date();
                var mes_anterior = moment(mes_actual, "DD-MM-YYYY").add(-1, 'months').format('MM/YYYY');

                var total_ventas_mes = 0;

                for (let i = 0; i < respuesta.length; i++) {

                    fecha_venta.push(respuesta[i]['fecha_venta']);
                    total_venta.push(respuesta[i]['total_venta']);
                    total_venta_ant.push(respuesta[i]['total_venta_ant']);
                    total_ventas_mes = parseFloat(total_ventas_mes) + parseFloat(respuesta[i]['total_venta']);

                }

                total_venta.push(0);

                $("#title-header-ventas-mes").html('VENTAS DEL MES: S./ ' + total_ventas_mes.toFixed(2).toString().replace(/\d(?=(\d{3})+\.)/g, "$&,"));

                var barChartCanvas = $("#barChart").get(0).getContext('2d');

                var areaChartData = {
                    labels: fecha_venta,
                    datasets: [{
                        label: 'Mes Anterior - ' + mes_anterior,
                        backgroundColor: 'rgb(255, 140, 0,0.9)',
                        data: total_venta_ant
                    }, {
                        label: 'Mes Actual- ' + +Number(mes_actual.getMonth() + 1) + '/' + mes_actual.getFullYear(),
                        backgroundColor: 'rgba(60,141,188,0.9)',
                        data: total_venta
                    }]
                }

                var barChartData = $.extend(true, {}, areaChartData);

                var temp0 = areaChartData.datasets[0];

                barChartData.datasets[0] = temp0;

                var barChartOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    events: false,
                    legend: {
                        display: true
                    },
                    scales: {
                        xAxes: [{
                            stacked: true,
                        }],
                        yAxes: [{
                            stacked: true
                        }]
                    },
                    animation: {
                        duration: 500,
                        easing: "easeOutQuart",
                        onComplete: function() {
                            var ctx = this.chart.ctx;
                            ctx.font = Chart.helpers.fontString(Chart.defaults.global
                                .defaultFontFamily, 'bold',
                                Chart.defaults.global.defaultFontFamily);
                            ctx.textAlign = 'center';
                            ctx.textBaseline = 'bottom';

                            for (var i = 0; i < this.data.datasets[1].data.length; i++) {

                                var model = this.data.datasets[1]._meta[Object.keys(this.data.datasets[1]._meta)[0]].data[i]._model,
                                    scale_max = this.data.datasets[1]._meta[Object.keys(this.data.datasets[1]._meta)[0]].data[i]._yScale.maxHeight;

                                var y_pos = model.y;

                                ctx.fillStyle = '#ffa500';
                                ctx.fillText(this.data.datasets[0].data[i], model.x + 20, y_pos);

                                ctx.fillStyle = '#0083ff';
                                ctx.fillText(this.data.datasets[1].data[i], model.x - 20, y_pos);
                            }
                        }
                    }
                }

                new Chart(barChartCanvas, {
                    type: 'bar',
                    data: barChartData,
                    options: barChartOptions
                })


            }
        });

    }


    /* =======================================================
    SOLICITUD AJAX GRAFICO DE DOUGHNUT
    =======================================================*/
    function cargarGraficoDoughnut() {

        $.ajax({
            url: "ajax/dashboard.ajax.php",
            method: 'POST',
            data: {
                'accion': 'grafico_doughnut' //parametro para obtener las ventas del mes
            },
            dataType: 'json',
            success: function(respuesta) {

                var chart = new CanvasJS.Chart("chartContainer", {
                    animationEnabled: true,
                    // title:{
                    //     text: "Email Categories",
                    //     horizontalAlign: "left"
                    // },
                    data: [{
                        type: "doughnut",
                        startAngle: 60,
                        //innerRadius: 60,
                        indexLabelFontSize: 17,
                        indexLabel: "{label} - #percent%",
                        toolTipContent: "<b>{label}:</b> {y} (#percent%)",
                        dataPoints: respuesta
                    }]
                });
                chart.render();

            }
        });



    }


    /* =======================================================
    SOLICITUD AJAX PRODUCTOS MAS VENDIDOS
    =======================================================*/
    function cargarProductosMasVendidos() {

        $("#tbl_productos_mas_vendidos tbody").html('');

        $.ajax({
            url: "ajax/dashboard.ajax.php",
            type: "POST",
            data: {
                'accion': 'productos_mas_vendidos' // listar los 10 productos mas vendidos
            },
            dataType: 'json',
            success: function(respuesta) {

                for (let i = 0; i < respuesta.length; i++) {
                    filas = '<tr>' +
                        // '<td>'+ respuesta[i]["codigo_producto"] + '</td>'+
                        '<td>' + respuesta[i]["descripcion"] + '</td>' +
                        '<td class="text-center">' + respuesta[i]["cantidad"] + '</td>' +
                        '<td class="text-center"> S./ ' + respuesta[i]["total_venta"] + '</td>' +
                        '</tr>'
                    $("#tbl_productos_mas_vendidos tbody").append(filas);
                }

            }
        });

    }


    /* =======================================================
    SOLICITUD AJAX PRODUCTOS CON POCO STOCK
    =======================================================*/
    function cargarProductosPocoStock() {

        $("#tbl_productos_poco_stock tbody").html('');

        $.ajax({
            url: "ajax/dashboard.ajax.php",
            type: "POST",
            data: {
                'accion': 'productos_poco_stock' // listar los  productos con poco stock
            },
            dataType: 'json',
            success: function(respuesta) {
                for (let i = 0; i < respuesta.length; i++) {
                    filas = '<tr>' +
                        // '<td>'+ respuesta[i]["codigo_producto"] + '</td>'+   
                        '<td>' + respuesta[i]["descripcion"] + '</td>' +
                        '<td class="text-center">' + respuesta[i]["stock"] + '</td>' +
                        '<td class="text-center">' + respuesta[i]["minimo_stock"] + '</td>' +
                        '</tr>'
                    $("#tbl_productos_poco_stock tbody").append(filas);
                }

            }
        });

    }
</script>