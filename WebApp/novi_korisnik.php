<?php
include_once 'izbornik.php';

/*$prijava = dohvatiLogKorId();

if ($prijava == null) {
    header("Location: prijava.php");
}*/
?>

<html>
<head>
    <title>New user</title>
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
    <script src="javascript/registracija.js"></script>
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
                            <h3 class="card-title">New user</h3>
                        </div>

                        <!-- form start -->
                        <form role="form" action="novi_korisnik.php" method='POST' id='dodaj_korisnika'>
                            <div class="card-body">
                                <div class="form-group">
                                     <label for="ime">Name</label>
                                     <input type='text' class="form-control" id='ime' name='ime' required >
                                </div>
                                <div class="form-group">
                                    <label for="prezime">Surname</label>
                                    <input type='text' class="form-control" id='prezime' name='prezime' required>
                                </div>
                                <div class="form-group">
                                    <label for="telefon">Telephone number</label>
                                    <input type='text' class="form-control" id='telefon' name='telefon'  required>
                                </div>
                                <div class="form-group">
                                    <label for="adresa">Address</label>
                                    <input type='text' class="form-control" id='adresa' name='adresa' required>
                                </div>
                                <div class="form-group">
                                    <label for="email">E-mail</label>
                                    <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    </div>
                                    <input type='text' class="form-control" id='email' name='email' required >
                                    </div>
                                </div>
                                <div id="greska_prva"></div>
                                <div class="form-group">
                                    <label for="oib">OIB</label>
                                    <input type='text' class="form-control" id='oib' name='oib' required>
                                </div>
                                <div class="form-group">
                                    <label for="poslovnica">Office</label>
                                    <select name="poslovnica" id="poslovnica" class="form-control">
                                        <?php
                                        $url = "https://air-api.azurewebsites.net/SvePoslovnice";
                                        $data = file_get_contents($url);
                                        $podaci = json_decode($data);

                                        foreach ($podaci as $podatak){
                                            echo "<option value=$podatak->id_poslovnica>" .$podatak->naziv . "</option>";
                                        }

                                        ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="korime">Username</label>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">@</span>
                                        </div>
                                        <input type='text' class="form-control" id='korime' name='korime' required >
                                    </div>

                                </div>
                                <div id="greska_druga"></div>
                                <div class="form-group">
                                    <label for="lozinka">Password</label>
                                    <input type='password' class="form-control" id='lozinka' name='lozinka' required>
                                </div>
                                <div class="form-group">
                                    <label for="ponovljena_lozinka">Confirm password</label>
                                    <input type='password' class="form-control" id='ponovljena_lozinka' name='ponovljena_lozinka' required>
                                </div>
                                <div id="greska"></div>
                            </div>
                                <div class="card-footer">
    <input class="btn btn-primary" id="gumbregistracija" type='submit' name="registracija_gumb" value='Submit'>

    <input type="hidden" id="_token" value="{{ csrf_token() }}">
</div>
    </form>
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
if (isset($_POST['registracija_gumb'])) {

    $ime = $_POST["ime"];
    $prezime = $_POST["prezime"];

    $telefon = $_POST["telefon"];
    $adresa = $_POST["adresa"];
    $email = $_POST["email"];
    $oib = $_POST["oib"];
    $korime = $_POST["korime"];
    $lozinka = $_POST["lozinka"];
    $poslovnica=$_POST["poslovnica"];

    $url = "https://air-api.azurewebsites.net/SviKorisnici";
    $data = file_get_contents($url);
    $podaci = json_decode($data);

    $ispravno=true;

    foreach ($podaci as $podatak){
        if ($podatak->email==$email){
            echo'<script type="text/javascript"> toastr.error("There is already a user with this e-mail address!")</script>';
            $ispravno=false;
        }
        else if ($podatak->kor_ime==$korime){
            echo'<script type="text/javascript"> toastr.error("This username is already taken!")</script>';
            $ispravno=false;
        }
    }

    if ($ispravno){
        $data = array(
            'ime'      => $ime,
            'prezime'    => $prezime,
            'telefon'    => $telefon,
            'adresa'    => $adresa,
            'email'    => $email,
            'oib'    => $oib,
            'korime'    => $korime,
            'lozinka'    => $lozinka,
            'poslovnica'    => $poslovnica,
            '_token'=> '{{csrf_token()}}'

        );

        $url = "https://air-api.azurewebsites.net/DodajKorisnika";
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
            echo'<script type="text/javascript"> toastr.error("Error with adding new user!")</script>';
        }else{
            echo'<script type="text/javascript">  toastr.success("New user successfully added!")</script>';
        }
    }
}
