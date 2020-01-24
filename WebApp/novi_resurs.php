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
    <title>New resource</title>
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
    <script src="javascript/novi_resurs.js"></script>

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
                            <h3 class="card-title">New resource</h3>
                        </div>

                        <form role="form" action="novi_resurs.php" enctype="multipart/form-data" method='POST' id='dodaj_resurs'>
                            <div class="card-body">
                                 <div class="form-group">
                                     <label for="naziv">Name: </label>
                                     <input type="text" class="form-control" id="naziv" name="naziv" required="required">
                                 </div>
                                 <div id="greska_prva"></div>
                                 <div class="form-group">
                                    <label for="tip_resursa">Type:</label>
                                    <select name="tip_resursa" id="tip_resursa" class="form-control">
                                        <?php
                                        $url = "https://air-api.azurewebsites.net/VrsteResursa";
                                        $data = file_get_contents($url);
                                        $podaci = json_decode($data);

                                        foreach ($podaci as $podatak){
                                            echo "<option value=$podatak->id_tip_resursa>" .$podatak->nazivtr . "</option>";
                                        }

                                        ?>
                                    </select>
                                 </div>
                                 <div class="form-group">
                                    <label for="trajanje">Maximum loan period: </label>
                                    <input type="number" id="trajanje" name="trajanje" min="1" placeholder="days" class="form-control">
                                 </div>
                                 <div class="form-group">
                                    <label for="predaj">Upload picture of resource: </label>
                                    <input type="file" name="userfile" id="predaj">
                                 </div>
                            </div>
                            <div class="card-footer">

                                    <input class="btn btn-primary" id="gumb_resurs" type='submit' name="resurs_gumb" value='Submit'/>

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

if (isset($_POST['resurs_gumb'])) {
    $currentDir = getcwd();
    $uploadDirectory = "img/";

    $errors = []; // Store all foreseen and unforseen errors here

    $fileExtensions = ['jpeg','jpg','png']; // Get all the file extensions

    $fileName = $_FILES['userfile']['name'];
    $fileSize = $_FILES['userfile']['size'];
    $fileTmpName  = $_FILES['userfile']['tmp_name'];
    $fileType = $_FILES['userfile']['type'];
    $fileExtension = strtolower(end(explode('.',$fileName)));

    $uploadPath = $currentDir . $uploadDirectory . basename($fileName);
    $text=$fileName;
    echo '<script type="text/javascript">alert("'.$text.'")</script>';
}
?>