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
                    "<th>Maximum loan <br> period (days)</th><th>Picture</th><th></th></thead><tbody>";

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
                        '<img src="/img/'+slika+'"> '+
                        "</td><td>" +
                        '<button class="btn btn-block btn-primary btn-sm" data-toggle="modal" data-target="#modal-default" id="' + tid + '" >Details</button>' +
                        '<button class="btn btn-block btn-warning btn-sm " id='+tid+'>Edit</button>'+
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


    $(document.body).on('click', '.btn-primary', function (event) {
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
                            var email=result[i].email;
                            ispis+="Instance "+result[i].id_instanca+" is borrowed \nby user: " +result[i].kor_ime+'\n'+
                                "e-mail: "+email+ ' on ' +result[i].datum+'\n'+'\n';
                        }
                        else{
                            ispis+="Instance "+result[i].id_instanca+" is free."+"\n"+"\n";

                        }

                    }
                }
                ispis_p.text(ispis);


            }
        });

    });
    $(document.body).on('click', '.btn-warning', function (event)  {
        var resurs_id=event.target.id;
        location.href='https://testapp1906.azurewebsites.net/edit_resurs.php?id='+resurs_id;
    });
});
