$(document).ready(function() {

    var prikazKorisnici = $("#prikaz_korisnici");

    prikazKorisnici.text("Učitavanje podataka...");
    dohvatiPodatke();
    $.ajaxSetup ({
        cache: false
    });

    function dohvatiPodatke() {

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/SviKorisnici",
            success: function (result) {
                var output =
                    "<table id='tablica'><thead><tr><th>Name</th><th>Lastname</th><th>Telephone number</th><th>Address</th><th>E-mail</th>" +
                    "<th>OIB</th><th>Username</th></thead><tbody>";

                for (var i in result) {

                    output +=
                        "<tr><td>" +
                        result[i].ime +
                        "</td><td>" +
                        result[i].prezime +
                        "</td><td>" +
                        result[i].telefon +
                        "</td><td>" +
                        result[i].adresa+
                        "</td><td>" +
                        result[i].email+
                        "</td><td>" +
                        result[i].oib +
                        "</td><td>" +
                        result[i].kor_ime+
                        "</td></tr>";
                }
                output += "</tbody></table>";

                prikazKorisnici.html(output);

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


});
