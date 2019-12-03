<html>
<head>
    <title>Početna</title>
</head>
</html>
<?php
include_once 'izbornik.php';
echo '<body><h1>Dobrodošli</h1></body>';
include 'baza.php';
$baza= new Baza();
$conn=$baza->SpojiDB();
if ($conn){
    echo 'spojen';
}
else{
    echo 'nisam spojen';
}
