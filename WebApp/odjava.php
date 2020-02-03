<?php

include_once 'sesija.php';

session_unset($_SESSION["korisnik"]);

session_destroy();
header("Location: prijava.php");
