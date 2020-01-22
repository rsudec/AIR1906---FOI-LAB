<?php
include_once 'izbornik.php';
?>

<html>
<head>
    <title>Resources</title>
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
</head>

    <div class="content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-12">
                    <br>
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Resources</h3>
                        </div>

                        <div class="card-body">
                            <div id="prikaz_resursi"></div>
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
                        <div class="modal-footer justify-content-between">
                            <button type="button" class="btn-sm danger" data-dismiss="modal">Close</button>

                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </div>

</head>
</html>
