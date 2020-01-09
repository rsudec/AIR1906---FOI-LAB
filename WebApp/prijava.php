<html>
<meta name="csrf-token" content="{{ csrf_token() }}">
<body class="prijavabgc">
<br>
<br>
<br>
<div class="prijavafrm">
<h2>Prijava</h2>
        <form  id='prijava' action="prijava.php" method="post">

            <input type='text' class="inputprijava" id='korime' name='korime' placeholder="Korisničko ime" required autofocus /><br />
<br>
            <input type='password' class="inputprijava" id='lozinka' name='lozinka' placeholder="Lozinka" required /><br />
<br>
            <input class="inputprijava" id="gumbprijava" type='submit' name="prijava_gumb" value='Prijava' />

            <input type="hidden" id="_token" value="{{ csrf_token() }}">
        </form>
</div>
<div id="test"></div>
</body>
</html>
<?php
include_once 'header.php';
include_once 'sesija.php';

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
        echo '<script language="javascript">';
        echo 'alert("Pogrešno korisničko ime ili lozinka!")';
        echo '</script>';
    }else {
        $kljuc = $korisnik[0]->fk_uloga;
        $id = $korisnik[0]->id_korisnik;
        if ($kljuc == 1) {
            $_SESSION["korisnik"] = $id;
            setcookie("korisnik", $id, time() + (60*60*1));
            header("Location: index.php");
        } else {
            echo '<script language="javascript">';
            echo 'alert("Niste administrator sustava!")';
            echo '</script>';
        }
    }


}
