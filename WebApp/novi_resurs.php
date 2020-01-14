<html>
<head>
    <title>Novi resurs</title>
</head>

<body class="novi_resurs">
<?php
include_once 'izbornik.php';
include_once 'header.php';
/*$prijava = dohvatiLogKorId();

if ($prijava == null) {
    header("Location: prijava.php");
}*/
?>
<br>
<div class="res">
    <br>
    <h2 id="titleResurs">Novi resurs</h2>
    <form  id='dodaj_resurs' class="resurs" novalidate id="forma_resurs" enctype="multipart/form-data" method="post" action="">
        <fieldset class="blokovi">
            <legend>Unos podataka o resursu</legend>
            <label for="naziv">Naziv resursa: </label>
            <input type="text" class="noviResurs" id="naziv" name="naziv" size="20" maxlength="100" required="required"><br>
            <label for="tip_resursa">Tip resursa:</label>
            <select name="tip_resursa" id="tip_resursa" class="noviResurs">
                <option value="1">Resurs 1</option>
                <option value="2">Resurs 2</option>
                <option value="3">Resurs 3</option>
                <option value="4">Resurs 4</option>
            </select><br>
            <label for="skladiste">Lokacija skladišta:</label>
            <select name="skladiste" id="skladiste" class="noviResurs">
                <option value="1">Skladiste 1</option>
                <option value="2">Skladiste 2</option>
                <option value="3">Skladiste 3</option>
                <option value="4">Skladiste 4</option>
            </select><br>
            <label for="pozicija">Slobodno mjesto:</label>
            <select name="pozicija" id="pozicija" class="noviResurs">
                <option value="1">Mjesto 1</option>
                <option value="2">Mjesto 2</option>
                <option value="3">Mjesto 3</option>
                <option value="4">Mjesto 4</option>
            </select><br>
            <label for="kolicina">Količina: </label><br>
            <input type="number" id="kolicina" name="kolicina" min="0" class="noviResurs"><br>
        </fieldset>
        <fieldset class="blokovi">
            <legend>Kreiranje QR koda</legend>
            <input class="inputQr" id="gumbQr" type='button' name="gumb_Qr" value='Kreiraj'/>
        </fieldset>
        <fieldset class="blokovi">
            <legend>Dodaj sliku resursa</legend>
            <input type="hidden" name="MAX_FILE_SIZE" value="30000">
            <label for="predaj">Datoteka: </label>
            <input id="predaj" name="userfile" type="file"><br>
        </fieldset>
        <br>
        <fieldset class="blokovi_gumb">
            <input class="inputPresurs" id="gumbresurs" type='submit' name="resurs_gumb" value='Dodaj'/>
        </fieldset>
    </form>
</div>
</body>
</html>