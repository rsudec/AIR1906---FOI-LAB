$(document).ready(function() {

    var prikazObavijesti = $("#prikaz_obavijesti");

    prikazObavijesti.text("Učitavanje podataka...");
    dohvatiPodatke();
    $.ajaxSetup ({
        cache: false
    });
 var tid;
    function dohvatiPodatke() {

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/IspisNeprocitanih",
            success: function (result) {
                var output =
                    "<table id='tablica'><thead><tr><th>Vrsta</th><th>Korisnik</th><th>E-mail</th><th>Resurs</th><th>Datum i vrijeme</th>" +
                    "<th>Napomena</th><th>Označi kao pročitano</th></thead><tbody>";

                for (var i in result) {
                   tid =result[i].id_log;
                    output +=
                        "<tr><td>" +
                        result[i].vrsta +
                        "</td><td>" +
                        result[i].kor_ime +
                        "</td><td>" +
                        result[i].email +
                        "</td><td>" +
                        result[i].nazivr+
                        "</td><td>" +
                        result[i].datum+
                        "</td><td>" +
                        result[i].feed +
                        "</td><td>" +
                        '<button id="'+tid+'" >&#10003</button>'+

                        "</td></tr>";

                }
                output += "</tbody></table>";

                prikazObavijesti.html(output);
                $("table").addClass("table");

              


                $('table').DataTable(
                    {

                    });
                setTimeout(dohvatiPodatke, 10000);
            }
        });
    }
    $(document.body).on('click', 'button', function(event) {
       var obavijest_id=event.target.id;

         var url = "https://air-api.azurewebsites.net//ProcitajObavijest/"+obavijest_id;

        $.ajax({
            type: "GET",
            url: url,
            success: function (result) {
                dohvatiPodatke();
            }
        });

    });


});
