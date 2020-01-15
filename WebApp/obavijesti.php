<?php
include_once 'izbornik.php';
?>

<html>
<head>
    <title>Obavijesti</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="javascript/obavijesti.js"></script>


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
                        <h3 class="card-title">Notifications</h3>
                    </div>

                    <div class="card-body">
                        <div id="prikaz_obavijesti"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </div>
</head>
</html>
