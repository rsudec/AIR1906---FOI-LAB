$(document).ready(function() {

    var prikazKorisnici = $("#prikaz_korisnici");

    prikazKorisnici.text("Loading data...");
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
                    "<table id='tablica'><thead><tr><th>Name</th><th>Surname</th><th>Telephone number</th><th>Address</th><th>E-mail</th>" +
                    "<th>OIB</th><th>Username</th><th></th></thead><tbody>";

                for (var i in result) {
                    var tid = result[i].id_korisnik;
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
                        "</td><td>" +
                        '<button class="btn btn-block btn-primary btn-sm" id="' + tid + '" >Edit</button>' +
                        "</td></tr>";
                }
                output += "</tbody></table>";

                prikazKorisnici.html(output);
                $("button").addClass("btn btn-block btn-primary btn-sm");

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
    $(document.body).on('click', '.btn-primary', function (event)  {
        var user_id=event.target.id;
        location.href='https://testapp1906.azurewebsites.net/edit_users.php?id='+user_id;
    });

});
