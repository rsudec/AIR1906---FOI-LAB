<?php
session_start();
include_once 'sesija.php';

if(dohvatiLogKorId()===null){
    echo "<script> location.href='https://testapp1906.azurewebsites.net/prijava.php'; </script>";
}


include_once 'izbornik.php';
$id=$_GET["id"];


?>
<script type="text/javascript">
    $(document).ready(function () {


        var url_string = window.location.href;
        var url = new URL(url_string);
        var id = url.searchParams.get("id");
        $("img").css({"width": "50px", "height": "50px"});
        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/SviResursi",
            success: function (result) {

                for (var i in result) {
                    if(result[i].id_resurs===id){
                        document.getElementById("naziv").value = result[i].nazivr;
                        document.getElementById("kolicina").value=result[i].kolicina;
                        document.getElementById("posudba").value=result[i].max_posudba;
                        document.getElementById("slika_c").src=result[i].slika;
                        document.getElementById("slika_hidden").value=result[i].slika;
                    }

                }

            }
        });



    });


</script>

<html>
<head>
    <title>Edit resource</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="javascript/registracija.js"></script>

    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <!-- Toastr -->
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css">


    <!-- SweetAlert2 -->
    <script src="plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="plugins/toastr/toastr.min.js"></script>



    <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.css">

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="javascript/resursi.js"></script>


    <!-- DataTables -->
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>

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
                            <h3 class="card-title">Edit resource</h3>
                        </div>

                        <form role="form" action="edit_resurs.php?id=<?php echo $id ?>" method='POST' id='dodaj_resurs' enctype="multipart/form-data">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="naziv">Name: </label><input type="text" class="form-control" id="naziv" name="naziv" required="required"
                                    >
                                </div>

                                <div class="form-group">
                                    <label for="kolicina">Quantity: </label>
                                    <input type="number" id="kolicina" name="kolicina" min="0" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="posudba">Maximum loan period (days): </label>
                                    <input type="number" id="posudba" name="posudba" min="0" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Current picture: </label><br>
                                    <img id="slika_c" src="">
                                </div>

                                <div class="form-group">
                                    <label>Upload new picture of resource: </label>
                                    <input type="hidden" name="MAX_FILE_SIZE" value="500000"><br>
                                    <label for="predaj">File: </label>
                                    <input  name="userfile" type="file"><br>
                                </div>
                            </div>
                            <div class="card-footer">
                                <input type="hidden" id="_token" value="{{ csrf_token() }}">

                                <input class="btn btn-primary" id="gumbresurs" type='submit' name="resurs_gumb" value='Submit'/>

                            </div>
                            <input type="hidden" id="slika_hidden" name="slika_hidden">
                            <input type="hidden" id="_token" value="{{ csrf_token() }}">
                        </form>

                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
</html>
<?php
if (isset($_POST['resurs_gumb'])) {
    $userfile = $_FILES["userfile"]["tmp_name"];
    $userfile_name = $_FILES["userfile"]["name"];
    $userfile_size = $_FILES["userfile"]["size"];
    $userfile_type = $_FILES["userfile"]["type"];
    $userfile_error = $_FILES["userfile"]["error"];

    $upfile = 'img/' . $userfile_name;





    $naziv = $_POST["naziv"];
    $kolicina = $_POST["kolicina"];

    $posudba = $_POST["posudba"];

    $resurs=$_GET['id'];
    $alt_slika=$_POST["slika_hidden"];
if ($userfile_name!=""){
    $slika = 'https://testapp1906.azurewebsites.net/img/'.$userfile_name;;
}
else{
    $slika=$alt_slika;
}



        $data = array(
            'id'      => $resurs,
            'naziv'    => $naziv,
            'kolicina'    => $kolicina,
            'slika'    => $slika,
            'posudba'    => $posudba,

            '_token'=> '{{csrf_token()}}'

        );

        $url = "https://air-api.azurewebsites.net/Azuriraj";
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

        $resurs = json_decode($json_odgovor);

        if ($resurs==null){

            echo'<script type="text/javascript"> toastr.error("Error with editing resource!")</script>';
        }else{
            echo'<script type="text/javascript">  toastr.success("Resource edited successfully!")</script>';
            echo '<script> setTimeout(function(){
            window.location.href = "https://testapp1906.azurewebsites.net/resursi.php";
         }, 1000); </script>';
        }

}