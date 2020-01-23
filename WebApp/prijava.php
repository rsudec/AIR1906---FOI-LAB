<?php
session_start();
include_once 'sesija.php';

?>
<html>
<head>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <!-- Toastr -->
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">



    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 -->
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="plugins/toastr/toastr.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>

</head>

<body class="hold-transition login-page">
<div class="login-box">

    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <form action="prijava.php" method="post">
                <div class="input-group mb-3">
                    <input type="text" name="korime" class="form-control" placeholder="Username">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password" name="lozinka" class="form-control" placeholder="Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>



                        <button type="submit" id="prijava" name="prijava_gumb" class="btn btn-primary btn-block">Sign In</button>


                <input type="hidden" id="_token" value="{{ csrf_token() }}">
            </form>



        </div>
        <!-- /.login-card-body -->
    </div>
</div>


</body>
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
include_once 'header.php';


//provjera sigurne https veze
$uri = $_SERVER["REQUEST_URI"];
$pos = strrpos($uri, "/");
$dir = $_SERVER["SERVER_NAME"] . substr($uri, 0, $pos + 1);

if (!isset($_SERVER["HTTPS"]) || strtolower($_SERVER["HTTPS"]) != "on") {
    $adresa = 'https://' . $dir . 'prijava.php';
    header("Location: $adresa");
    exit();
}

$prijava = dohvatiLogKorId();

# REDIREKCIJA AKO JE VEC PRIJAVLJEN
if ($prijava != null) {
    header("Location: index.php");
}


if (isset($_POST['prijava_gumb'])) {

    $korime = $_POST["korime"];
    $lozinka = $_POST["lozinka"];

/*
    $url = "https://air-api.azurewebsites.net/Prijava/$korime/$lozinka";
    $data = file_get_contents($url);
    $korisnik = json_decode($data);
*/

    $data = array(
        'korime'      => $korime,
        'lozinka'    => $lozinka,
        '_token'=> '{{csrf_token()}}'

    );

    $url = "https://air-api.azurewebsites.net/Prijava";
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

    $korisnik = json_decode($json_odgovor);


    if ($korisnik==null){

        echo'<script type="text/javascript"> toastr.error("Username and/or password is incorrect!")</script>';

    }else {
        $kljuc = $korisnik[0]->fk_uloga;
        $id = $korisnik[0]->id_korisnik;
        if ($kljuc == 1) {

            $_SESSION["korisnik"] = $id;

            setcookie("korisnik",$id, time() + (60*60));
            echo "<script> location.href='https://testapp1906.azurewebsites.net/index.php'; </script>";
        } else {
            echo'<script type="text/javascript"> toastr.error("You are not administrator!")</script>';

        }
    }


}
