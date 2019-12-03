<?php
session_start();


function dohvatiLogKorId() {
    $korisnik = null;
    if (isset($_SESSION["korisnik"])) {
        $korisnik = $_SESSION["korisnik"];
    }
    return $korisnik;
}

