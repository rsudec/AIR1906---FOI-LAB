<?php
include_once 'izbornik.php';

/*$prijava = dohvatiLogKorId();

if ($prijava == null) {
    header("Location: prijava.php");
}*/
?>

<html>
<head>
    <title>New resource</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
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
                            <h3 class="card-title">New resource</h3>
                        </div>

                        <div role="form" action="novi_resurs.php" method='POST' id='dodaj_resurs'>
                            <div class="card-body">
                                 <div class="form-group">
                                    <label for="naziv">Naziv resursa: </label><input type="text" class="form-control" id="naziv" name="naziv" required="required">
                                 </div>
                                <div class="form-group">
                                    <label for="tip_resursa">Tip resursa:</label>
                                    <select name="tip_resursa" id="tip_resursa" class="form-control">
                                        <option value="1">Resurs 1</option>
                                        <option value="2">Resurs 2</option>
                                        <option value="3">Resurs 3</option>
                                        <option value="4">Resurs 4</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="skladiste">Lokacija skladišta:</label>
                                    <select name="skladiste" id="skladiste" class="form-control">
                                        <option value="1">Skladiste 1</option>
                                        <option value="2">Skladiste 2</option>
                                        <option value="3">Skladiste 3</option>
                                        <option value="4">Skladiste 4</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="pozicija">Slobodno mjesto:</label>
                                    <select name="pozicija" id="pozicija" class="form-control">
                                        <option value="1">Mjesto 1</option>
                                        <option value="2">Mjesto 2</option>
                                        <option value="3">Mjesto 3</option>
                                        <option value="4">Mjesto 4</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="kolicina">Količina: </label>
                                    <input type="number" id="kolicina" name="kolicina" min="0" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Kreiranje QR koda</label>
                                    <input class="btn btn-primary" id="gumbQr" type='button' name="gumb_Qr" value='Kreiraj'/>
                                </div>
                                <div class="form-group">
                                    <label>Dodaj sliku resursa</label>
                                    <input type="hidden" name="MAX_FILE_SIZE" value="30000">
                                    <label for="predaj">Datoteka: </label>
                                    <input id="predaj" name="userfile" type="file"><br>
                                </div>
                            </div>
                            <div class="card-footer">

                                    <input class="btn btn-primary" id="gumbresurs" type='submit' name="resurs_gumb" value='Submit'/>

                            </div>
                            <input type="hidden" id="_token" value="{{ csrf_token() }}">
                        </div>
    </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
</html>
