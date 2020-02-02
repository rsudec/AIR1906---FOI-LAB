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
    <title>New category</title>
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

    <script src="javascript/novi_tip.js"></script>


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
                            <h3 class="card-title">New category</h3>
                        </div>

                        <form role="form" action="novi_tip.php" enctype="multipart/form-data" method='POST' id='dodaj_tip'>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="naziv">Name: </label>
                                    <input type="text" class="form-control" id="naziv" name="naziv" required="required">
                                </div>
                                <div id="greska_prva"></div>
                                <div class="form-group">
                                    <label>Description:</label>
                                    <textarea id = "opis" class="form-control" rows = "3" >Your description...</textarea>
                                </div>

                            </div>
                            <div class="card-footer">

                                <input class="btn btn-primary" id="gumb_tip" type='submit' name="tip_gumb" value='Submit'/>

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
if (isset($_POST['tip_gumb'])) {

    $naziv=$_POST["naziv"];
    $opis=$_POST["opis"];

    $url = "https://air-api.azurewebsites.net/VrsteResursa";
    $data = file_get_contents($url);
    $podaci = json_decode($data);

    $ispravno=true;

    foreach ($podaci as $podatak){
        if ($podatak->nazivr==$naziv){
            echo'<script type="text/javascript"> toastr.error("There is already a category with this name!")</script>';
            $ispravno=false;
        }
    }

    if ($ispravno){
        $data = array(
            'naziv'      => $naziv,
            'kolicina'    => $opis,
            '_token'=> '{{csrf_token()}}'

        );

        $url = "https://air-api.azurewebsites.net/DodajTip";
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
            echo'<script type="text/javascript"> toastr.error("Error with adding new category!")</script>';
        }else{
            echo'<script type="text/javascript">  toastr.success("New category successfully added!")</script>';
            echo '<script> setTimeout(function(){
            window.location.href = "https://testapp1906.azurewebsites.net/novi_resurs.php";
         }, 1000); </script>';
        }
    }
}
?>