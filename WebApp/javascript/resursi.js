$(document).ready(function() {

    var $prikazResursi = $("#prikaz_resursi");

    $prikazResursi.text("Loading data...");
    dohvatiPodatke();
    $.ajaxSetup({
        cache: false
    });

    function dohvatiPodatke() {

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/SviResursi",
            success: function (result) {
                var output =
                    "<table id='tablica'><thead><tr><th>ID</th><th>Name</th><th>Type</th><th>Quantity</th><th>Borrowed</th>" +
                    "<th>Maximum loan period<br>(days)</th><th>Picture</th><th></th></thead><tbody>";

                for (var i in result) {
                    var slika = result[i].slika;
                    var tid = result[i].id_resurs;
                    output +=
                        "<tr><td>" +
                        result[i].id_resurs +
                        "</td><td>" +
                        result[i].nazivr +
                        "</td><td>" +
                        result[i].nazivtr +
                        "</td><td>" +
                        result[i].kolicina +
                        "</td><td>" +
                        result[i].zauzeto +
                        "</td><td>" +
                        result[i].max_posudba +
                        "</td><td>" +
                        "<img src='" + slika + "'>" +
                        "</td><td>" +
                        '<button data-toggle="modal" data-target="#modal-default" id="' + tid + '" >Details</button>' +
                        "</td></tr>";
                }
                output += "</tbody></table>";

                $prikazResursi.html(output);
                $("button").addClass("btn btn-block btn-primary btn-sm");

                $("img").css({"width": "50px", "height": "50px"});

                $("table").addClass("table table-bordered table-hover");

                $('#tablica').DataTable({
                    "paging": true,
                    "lengthChange": true,
                    "searching": true,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false,
                });


                setTimeout(dohvatiPodatke, 10000);
            }
        });
    }


    $(document.body).on('click', 'button', function (event) {
        var resurs_id = event.target.id;
        var ispis_p=$("#ispis");
        var ispis="";

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/InstancePoResursu/"+resurs_id,
            success: function (result) {
                if(result===null){
                    ispis="Nije posuđena niti jedna instanca";
                }
                else{
                    for (var i in result) {
                        if(result[i].kor_ime!=null){
                            ispis+="Instance "+result[i].id_instanca+" is borrowed by user: " +result[i].kor_ime+
                                ", e-mail "+result[i].email+" on "+result[i].datum+'\n';
                        }
                        else{
                            ispis+="Instance "+result[i].id_instanca+" is free."+"\n";

                        }

                    }
                }
                ispis_p.text(ispis);


            }
        });

    });
});
