<?php
session_start();
include_once 'sesija.php';

if(dohvatiLogKorId()===null){
    echo "<script> location.href='https://testapp1906.azurewebsites.net/prijava.php'; </script>";
}

include_once 'izbornik.php';
?>

    <html>
    <head>
        <title>New cupboard</title>
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <!-- SweetAlert2 -->
        <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
        <!-- Toastr -->
        <link rel="stylesheet" href="plugins/toastr/toastr.min.css">


        <!-- SweetAlert2 -->
        <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
        <!-- Toastr -->
        <script src="plugins/toastr/toastr.min.js"></script>



        <!-- DataTables -->
        <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">

        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

        <script src="javascript/novi_kontenjer.js"></script>
        <!-- DataTables -->
        <script src="plugins/datatables/jquery.dataTables.js"></script>
        <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>



        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    </head>
    <div class="content-wrapper">

        <div class="reg">
            <section class="content">
                <div class="container-fluid">
                    <div class="col-md-6">
                        <!-- general form elements -->
                        <br>
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">New cupboard</h3>
                            </div>

                            <form role="form" action="novi_kontenjer_glavni.php" enctype="multipart/form-data" method='POST' id='dodaj_kon'>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="naziv">Name: </label>
                                        <input type="text" class="form-control" id="naziv" name="naziv" required="required">
                                    </div>
                                    <div id="greska_prva"></div>
                                    <div class="form-group">
                                        <label for="skladiste">Warehouse:</label>
                                        <select name="skladiste" id="skladiste" class="form-control">
                                            <?php
                                            $url = "https://air-api.azurewebsites.net/Skladista";
                                            $data = file_get_contents($url);
                                            $podaci = json_decode($data);

                                            foreach ($podaci as $podatak){
                                                echo "<option value=$podatak->id_skladiste>" .$podatak->lokacija . "</option>";
                                            }

                                            ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="card-footer">

                                    <input class="btn btn-primary" id="gumb_kon" type='submit' name="kon_gumb" value='Submit'/>

                                </div>
                                <input type="hidden" id="_token" value="{{ csrf_token() }}">
                            </form>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    </html>
    <script type="text/javascript">
        $(function() {
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });

        });

    </script>
<?php
if (isset($_POST['kon_gumb'])) {

    $naziv=$_POST["naziv"];
    $idskladista=$_POST["skladiste"];
    $naziv=rawurlencode($naziv);

    $url = "https://air-api.azurewebsites.net/DodajKontejner/$naziv/$idskladista/null";
    $data= file_get_contents($url);
    $resurs = json_decode($data);

    if ($resurs===null){
        echo'<script type="text/javascript"> toastr.error("Error with adding new cupboard!")</script>';
    }else{
        echo'<script type="text/javascript">  toastr.success("New cupboard successfully added!")</script>';
        echo '<script> setTimeout(function(){
            window.location.href = "https://testapp1906.azurewebsites.net/nova_instanca.php";
         }, 1000); </script>';
    }
}
?>