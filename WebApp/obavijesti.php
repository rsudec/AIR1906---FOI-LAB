<html>
<head>
    <title>Obavijesti</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="javascript/obavijesti.js"></script>


</head>
</html>
<?php
include_once 'izbornik.php';
?>
<html>
<body><h1>Obavijesti</h1></body>
<div id="prikaz_obavijesti"></div>
</html>