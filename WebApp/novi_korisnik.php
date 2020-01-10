<html>
<head>
    <title>Novi korisnik</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="javascript/registracija.js"></script>
</head>
<body class="novi_korisnik">
<?php
include_once 'izbornik.php';
include_once 'header.php';
/*$prijava = dohvatiLogKorId();

if ($prijava == null) {
    header("Location: prijava.php");
}*/
?>
    <br>
<div class="reg">
    <br>
    <h2 id="titleKorisnik">Novi korisnik</h2>
    <form action="novi_korisnik.php" method='POST' id='dodaj_korisnika' class="registracija">
            <label for="ime">Ime</label><br>
            <input type='text' class="noviKorisnik" id='ime' name='ime' required /><br />
            <label for="prezime">Prezime</label><br>
            <input type='text' class="noviKorisnik" id='prezime' name='prezime' required /><br />

            <label for="telefon">Telefon</label><br>
            <input type='text' class="noviKorisnik" id='telefon' name='telefon'  required /><br />
            <label for="adresa">Adresa</label><br>
            <input type='text' class="noviKorisnik" id='adresa' name='adresa' required /><br />
            <label for="email">Email</label><br>
            <input type='text' class="noviKorisnik" id='email' name='email' required /><div id="greska1"></div><br />
            <label for="oib">OIB</label><br>
            <input type='text' class="noviKorisnik" id='oib' name='oib' required /><br />
            <label for="korime">Korisničko ime</label><br>
            <input type='text' class="noviKorisnik" id='korime' name='korime' required /><div id="greska2"></div><br />
            <label for="lozinka">Lozinka</label><br>
            <input type='password' class="noviKorisnik" id='lozinka' name='lozinka' required /><br />
            <label for="ponovljena_lozinka">Ponovljena lozinka</label><br>
            <input type='password' class="noviKorisnik" id='ponovljena_lozinka' name='ponovljena_lozinka' required /><br />
        <div id="greska"></div><br>
            <br>
            <input class="inputKorisnik" id="gumbregistracija" type='submit' name="registracija_gumb" value='Registracija'/>

            <input type="hidden" id="_token" value="{{ csrf_token() }}">
            <br>
            <br>
    </form>
</div>
</body>
</html>
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

    $url = "https://air-api.azurewebsites.net/SviKorisnici";
    $data = file_get_contents($url);
    $podaci = json_decode($data);

    $ispravno=true;

    foreach ($podaci as $podatak){
        if ($podatak->email==$email){
            echo '<script language="javascript">';
            echo 'alert("Već postoji korisnik s unesenom e-mail adresom")';
            echo '</script>';
            $ispravno=false;
        }
        else if ($podatak->kor_ime==$korime){
            echo '<script language="javascript">';
            echo 'alert("Korisničko ime je zauzeto")';
            echo '</script>';
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
            'poslovnica'    => 1,
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
            echo 'nije dobro';
        }
    }
}