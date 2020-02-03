<?php
session_start();
include_once 'sesija.php';

if(dohvatiLogKorId()===null){
    echo "<script> location.href='https://testapp1906.azurewebsites.net/prijava.php'; </script>";
}
include_once 'izbornik.php';

$id=$_GET["id"];

?>
    <script type="text/javascript">
        $(document).ready(function () {


            var url_string = window.location.href;
            var url = new URL(url_string);
            var id = url.searchParams.get("id");
            $.ajax({
                type: "GET",
                url: "https://air-api.azurewebsites.net/SviKorisnici",
                success: function (result) {

                    for (var i in result) {
                        if(result[i].id_korisnik===id){
                            document.getElementById("ime").value = result[i].ime;
                            document.getElementById("prezime").value=result[i].prezime;
                            document.getElementById("telefon").value=result[i].telefon;
                            document.getElementById("adresa").value = result[i].adresa;
                            document.getElementById("email").value=result[i].email;
                            document.getElementById("oib").value=result[i].oib;
                            document.getElementById("poslovnica").value = result[i].fk_poslovnica;
                            document.getElementById("korime").value=result[i].kor_ime;
                            document.getElementById("lozinka").value=result[i].lozinka;
                            document.getElementById("uloga").value=result[i].fk_uloga;
                        }

                    }

                }
            });



        });


    </script>
    <html>
    <head>
        <title>Edit user</title>
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

        <script src="javascript/korisnici.js"></script>


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
                                <h3 class="card-title">Edit user</h3>
                            </div>

                            <!-- form start -->
                            <form role="form" action="edit_users.php?id=<?php echo $id ?>" method='POST' id='dodaj_korisnika' enctype="multipart/form-data">
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
                                        <input type="hidden" id="email" name="email">
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" id="oib" name="oib">
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" id="korime" name="korime">
                                    </div><div class="form-group">
                                        <input type="hidden" id="lozinka" name="lozinka">
                                    </div>
                                    </div><div class="form-group">
                                    <input type="hidden" id="uloga" name="uloga">
                                </div>
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
    $user=$_GET['id'];
    $ime = $_POST["ime"];
    $prezime = $_POST["prezime"];
    $telefon = $_POST["telefon"];
    $adresa = $_POST["adresa"];
    $email = $_POST["email"];
    $oib = $_POST["oib"];
    $korime = $_POST["korime"];
    $lozinka = $_POST["lozinka"];
    $poslovnica=$_POST["poslovnica"];
    $uloga=$_POST["uloga"];

    $data = array(
            'id'      =>$user,
            'ime'      => $ime,
            'prezime'    => $prezime,
            'telefon'    => $telefon,
            'adresa'    => $adresa,
            'email'    => $email,
            'oib'    => $oib,
            'korime'    => $korime,
            'lozinka'    => $lozinka,
            'uloga'     =>$uloga,
            'poslovnica'    => $poslovnica,
            '_token'=> '{{csrf_token()}}'

        );

        $url = "https://air-api.azurewebsites.net/AzurirajKorisnika";
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

            echo'<script type="text/javascript"> toastr.error("Error with editing user!")</script>';
        }else{
            echo'<script type="text/javascript">  toastr.success("User edited successfully!")</script>';
            echo '<script> setTimeout(function(){
            window.location.href = "https://testapp1906.azurewebsites.net/korisnici.php";
         }, 1000); </script>';
        }

}
