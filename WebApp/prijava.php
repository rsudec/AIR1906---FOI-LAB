<html>
<body class="prijavabgc">
<br>
<br>
<br>

<h2>Prijava</h2>
        <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method='POST' id='prijava'>

            <input type='text' class="inputprijava" id='korime' name='korime' placeholder="Korisničko ime" required autofocus /><br />
<br>
            <input type='password' class="inputprijava" id='lozinka' name='lozinka' placeholder="Lozinka" required /><br />
<br>
            <input class="inputprijava" id="gumbprijava" type='submit'name="prijava_gumb" value='Prijava' />
        </form>

</body>
</html>
<?php
include_once 'header.php';
include_once 'sesija.php';
include_once 'baza.php';

//provjera sigurne https veze
$uri = $_SERVER["REQUEST_URI"];
$pos = strrpos($uri, "/");
$dir = $_SERVER["SERVER_NAME"] . substr($uri, 0, $pos + 1);

if (!isset($_SERVER["HTTPS"]) || strtolower($_SERVER["HTTPS"]) != "on") {
    $adresa = 'https://' . $dir . 'prijava.php';
    header("Location: $adresa");
    exit();
}

//provjera je li već prijavljen korisnik
$prijava = dohvatiLogKorId();

# REDIREKCIJA AKO JE VEC PRIJAVLJEN
if ($prijava != null) {
    header("Location: index.php");
}

if (isset($_POST['prijava_gumb'])) {

    $korime = $_POST["korime"];
    $lozinka = $_POST["lozinka"];

    echo "$korime, $lozinka";
    $baza = new Baza();
    $conn=$baza->SpojiDB();

    $upit = "select * FROM korisnik where korime = '$korime' and lozinka='$lozinka'";
    $rezultat = sqlsrv_query( $conn, $upit );

    if (sqlsrv_has_rows( $rezultat )) { # POSTOJI AKTIVIRAN KORISNIK
        $upit2="select id from korisnik where korime = '$korime' and lozinka='$lozinka' and tip_korisnika='4'";
        $rez = sqlsrv_query( $conn, $upit2 );
        if(!sqlsrv_has_rows( $rez )){
            echo '<script language="javascript">';
            echo 'alert("Niste administrator sustava!")';
            echo '</script>';
        }
        else{
            $upit2="select id from korisnik where korime = '$korime' and lozinka='$lozinka' and tip_korisnika='4'";
            $rez = sqlsrv_query( $conn, $upit2 );
            $row = sqlsrv_fetch_array( $rez, SQLSRV_FETCH_ASSOC) ;
            $id=$row["id"];
            $_SESSION["korisnik"] = $id;
            header("Location: index.php");
        }

        }
    else{
        echo '<script language="javascript">';
        echo 'alert("Neispravno korisničko ime ili lozinka!")';
        echo '</script>';
    }






}
