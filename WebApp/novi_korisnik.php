<html>
<head>
    <title>Novi korisnik</title>
</head>
<body class="novi_korisnik">
<?php
include_once 'izbornik.php';
?>
    <br>
<div class="reg">
    <br>
    <h2 id="titleKorisnik">Novi korisnik</h2>
    <form action="" method=\'POST\' id=\'dodaj_korisnika\' class="registracija">
            <label for="ime">Ime</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'ime\' name=\'ime\' required /><br />
            <label for="prezime">Prezime</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'prezime\' name=\'prezime\' required /><br />
            <label for="datum">Datum rođenja</label><br>
            <input type="date" class="noviKorisnik" id=\'datum\' name=\'datum\'  required /><br />
            <label for="telefon">Telefon</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'telefon\' name=\'telefon\'  required /><br />
            <label for="adresa">Adresa</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'adresa\' name=\'adresa\' required /><br />
            <label for="email">Email</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'email\' name=\'email\' required /><br />
            <label for="oib">OIB</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'oib\' name=\'oib\' required /><br />
            <label for="korime">Korisničko ime</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'korime\' name=\'korime\' required /><br />
            <label for="lozinka">Lozinka</label><br>
            <input type=\'text\' class="noviKorisnik" id=\'lozinka\' name=\'lozinka\' required /><br />
            <br>
            <input class="inputKorisnik" id="gumbregistracija" type='submit'name="registracija_gumb" value='Registracija'/>
            <br>
            <br>
    </form>
</div>
</body>';
</html>
