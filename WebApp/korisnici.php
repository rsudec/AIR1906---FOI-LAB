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
    <title>Users</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="javascript/korisnici.js"></script>


    <!-- DataTables -->
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
</head>

<div class="content-wrapper">
    <section class="content">
        <div class="row">
            <div class="col-12">
                <br>
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Users</h3>
                    </div>

                    <div class="card-body">
                        <div id="prikaz_korisnici"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modal-default">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Details</h4>

                    </div>
                    <div class="modal-body">
                        <pre id="ispis"></pre>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </section>
</div>
</head>
</html>
