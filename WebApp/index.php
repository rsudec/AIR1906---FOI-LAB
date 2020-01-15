<?php
include_once 'izbornik.php';

include_once 'sesija.php';

?>
<html>
<head>
    <title>Home</title>
</head>
<div class="content-wrapper">
    <section class="content">
        <br>
        <div class="container-fluid">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-info">
                        <div class="inner">
                            <h3 id="resursi">0</h3>

                            <p>Resources</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-stats-bars"></i>
                        </div>
                        <a href="resursi.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-success">
                        <div class="inner">
                            <h3 id="obavijesti">0</h3>

                            <p>Notifications</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-pie-graph"></i>
                        </div>
                        <a href="obavijesti.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-warning">
                        <div class="inner">
                            <h3 id="korisnici">0</h3>

                            <p>User Registrations</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-person-add"></i>
                        </div>
                        <a href="novi_korisnik.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                </div>

                <!-- ./col -->
            </div>
        </div>
            <!-- /.row -->
    </section>


</div>


</html>
<script>
    $(document).ready(function() {
        dohvatiO();
        dohvatiR();
        dohvatiK();
        var broj_resursa=0;
        var resursi=$("#resursi");
        var obavijesti=$("#obavijesti");
        var broj_obavijesti=0;
        var broj_korisnika=0;
        var korisnici=$("#korisnici");
        function dohvatiR(){
            $.ajax({
                type: "GET",
                url: "https://air-api.azurewebsites.net/SviResursi",
                success: function (result) {

                    for (var i in result) {
                        broj_resursa++;
                    }
                    resursi.text(broj_resursa);
                }
            });
        }
        function dohvatiO(){
            $.ajax({
                type: "GET",
                url: "https://air-api.azurewebsites.net/IspisNeprocitanih",
                success: function (result) {

                    for (var i in result) {
                        broj_obavijesti++;
                    }
                    obavijesti.text(broj_obavijesti);
                }
            });
        }
        function dohvatiK() {
            $.ajax({
                type: "GET",
                url: "https://air-api.azurewebsites.net/SviKorisnici",
                success: function (result) {

                    for (var i in result) {
                        broj_korisnika++;
                    }
                   korisnici.text(broj_korisnika);
                }
            });
        }


        
        


    });

</script>


