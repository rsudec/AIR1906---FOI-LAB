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
    $userfile = $_FILES['userfile']['tmp_name'];
    $userfile_name = $_FILES['userfile']['name'];
    $userfile_size = $_FILES['userfile']['size'];
    $userfile_type = $_FILES['userfile']['type'];
    $userfile_error = $_FILES['userfile']['error'];

    if ($userfile_error > 0) {
        echo 'Problem: ';
        switch ($userfile_error) {
            case 1: echo 'Size larger than ' . ini_get('upload_max_filesize');
                break;
            case 2: echo 'Size larger than ' . $_POST["MAX_FILE_SIZE"] . 'B';
                break;
            case 3: echo 'File partially uploaded';
                break;
            case 4: echo 'File not uploaded';
                break;
        }
        exit;
    }
    $upfile = 'img/'.$userfile_name;

    if (is_uploaded_file($userfile)) {
        if (!move_uploaded_file($userfile, $upfile)) {
            echo 'An issue: it is not possible to upload the file to its destination';
            exit;
        }
    } else {
        echo 'An issue: Possible transmission attack. File: ' . $userfile_name;
        exit;
    }

    $naziv=$_POST["naziv"];
    $tip=$_POST["tip_resursa"];
    $dostupan=$_POST["trajanje"];
    $kolicina=0;
    $slika=$userfile_name;

    $url = "https://air-api.azurewebsites.net/SviResursi";
    $data = file_get_contents($url);
    $podaci = json_decode($data);

    $ispravno=true;

    foreach ($podaci as $podatak){
        if ($podatak->nazivr==$naziv){
            echo'<script type="text/javascript"> toastr.error("There is already a resurs with this name!")</script>';
            $ispravno=false;
        }
    }

    if ($ispravno){
        $data = array(
            'naziv'      => $naziv,
            'kolicina'    => $kolicina,
            'slika'    => $slika,
            'posudba'    => $dostupan,
            'tip'    => $tip,
            '_token'=> '{{csrf_token()}}'

        );

        $url = "https://air-api.azurewebsites.net/DodajResurs";
        $content = json_encode($data);

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER,
            array("Content-type: application/json"));
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $content);

        $json_odgovor = curl_exec($curl);

        $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

        if ( $status != 200 ) {
            die("Error: call to URL $url failed with status $status, response $json_odgovor, curl_error " . curl_error($curl) . ", curl_errno " . curl_errno($curl));
        }


        curl_close($curl);

        $resurs = json_decode($json_odgovor);

        if ($resurs==null){
            echo'<script type="text/javascript"> toastr.error("Error with adding new resurs!")</script>';
        }else{
            echo'<script type="text/javascript">  toastr.success("New resurs successfully added!")</script>';
        }
    }
}
?>