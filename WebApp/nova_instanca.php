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
    <title>New instance</title>
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

    <script src="javascript/resursi.js"></script>


    <!-- DataTables -->
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="javascript/nova_instanca.js"></script>
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
                            <h3 class="card-title">New instance</h3>
                        </div>

                        <div role="form" action="nova_instanca.php" method='POST' id='dodaj_instancu'>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="tip_resursa">Resurs:</label>
                                    <select name="tip_resursa" id="tip_resursa" class="form-control">
                                        <?php
                                        $url = "https://air-api.azurewebsites.net/SviResursi";
                                        $data = file_get_contents($url);
                                        $podaci = json_decode($data);

                                        foreach ($podaci as $podatak){
                                            echo "<option value=$podatak->id_resurs>" .$podatak->nazivr . "</option>";
                                        }

                                        ?>
                                    </select>
                                </div>
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
                                <div class="form-group">
                                    <label for="pozicija">Items place:</label>
                                    <select name="pozicija" id="pozicija" class="form-control">
                                        <option value="1">Mjesto 1</option>
                                        <option value="2">Mjesto 2</option>
                                        <option value="3">Mjesto 3</option>
                                        <option value="4">Mjesto 4</option>
                                    </select>
                                </div>
                            </div>
                            <div class="card-footer">

                                <input class="btn btn-primary" id="gumbresurs" type='submit' name="resurs_gumb" value='Submit'/>

                            </div>
                            <input type="hidden" id="_token" value="{{ csrf_token() }}">
                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
</html>
