<?php
session_start();
include_once 'sesija.php';

if(dohvatiLogKorId()===null){
    echo "<script> location.href='https://testapp1906.azurewebsites.net/prijava.php'; </script>";
}
include_once 'izbornik.php';

include('libs/phpqrcode/qrlib.php');

if (isset($_POST['instanca_gumb'])) {

    $id_res=$_POST["resurs"];
    $kolicina=1;
    $mjesto=$_POST["pozicija"];

    $data = array(
        'idres'      => $id_res,
        'idkon'    => $mjesto,
        'kolicina'  =>$kolicina,
        '_token'=> '{{csrf_token()}}'

    );

    $url = "https://air-api.azurewebsites.net/DodajInstancu";
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

    $instance = json_decode($json_odgovor);

    if ($instance==null){
        echo'<script type="text/javascript"> toastr.error("Error with adding new instance!")</script>';
    }else{
        echo'<script type="text/javascript">  toastr.success("New instance successfully added!")</script>';
    }

    $tempDir = 'img/';

    $url = "https://air-api.azurewebsites.net/Qr/" . $id_res . "/" . $mjesto . "";
    $data = file_get_contents($url);
    $podaci = json_decode($data);

    foreach ($podaci as $podatak) {
        $id = $podatak->id_instanca;
    }
    $tempDir = 'img/';
    $url = "https://air-api.azurewebsites.net/Qr/$id_res/$mjesto";
    $data = file_get_contents($url);
    $podaci = json_decode($data);

    foreach ($podaci as $podatak) {
        $id = $podatak->id_instanca;
    }

    $filename = $id;
    $codeContents = $filename;
    QRcode::png($codeContents, $tempDir . '' . $filename . '.png', QR_ECLEVEL_L, 5);

}

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

                        <form role="form" action="nova_instanca.php" enctype="multipart/form-data" method='POST' id='dodaj_resurs'>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="resurs">Resource:</label>
                                    <select name="resurs" id="resurs" class="form-control">
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
                                    <label for="pozicija">Place:</label>
                                    <select name="pozicija" id="pozicija" class="form-control">
                                        <?php
                                        $url = "https://air-api.azurewebsites.net/SlobodniKontejneri";
                                        $data = file_get_contents($url);
                                        $podaci = json_decode($data);

                                        foreach ($podaci as $podatak){
                                            echo "<option value=$podatak->id_kontejner>" .$podatak->naziv . "</option>";
                                        }

                                        ?>
                                    </select>
                                </div>
                            </div>
                            <div class="card-footer">

                                <input class="btn btn-primary" id="gumbinstanca" type='submit' name="instanca_gumb" value='Submit'/>

                            </div>
                            <?php
                            if(!isset($filename)){
                                $filename = "author";
                            }
                            ?>
                            <div class="card-footer">
                                <label for="kod">QR Code: </label>
                                <div class="qrframe" style="border:2px solid black; width:210px; height:210px;">
                                    <?php echo '<img src="img/'. @$filename.'.png" style="width:200px; height:200px;"><br>'; ?>
                                </div>

                                <a class="btn btn-primary" style="width:210px; margin:5px 0;"  href="download.php?file=<?php echo $filename; ?>.png ">Download QR Code</a>

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