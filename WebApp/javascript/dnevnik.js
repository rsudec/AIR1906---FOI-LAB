$(document).ready(function() {

    var prikazDnevnik = $("#prikaz_dnevnik");

    prikazDnevnik.text("Loading data...");
    dohvatiPodatke();
    $.ajaxSetup ({
        cache: false
    });

    function dohvatiPodatke() {

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/IspisLog",
            success: function (result) {
                var output =
                    "<table id='tablica'><thead><tr><th>Type</th><th>User</th><th>E-mail</th><th>Resource</th><th>Date and time</th>" +
                    "<th>Feedback</th></thead><tbody>";

                for (var i in result) {
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
                        "</td></tr>";
                }
                output += "</tbody></table>";

                prikazDnevnik.html(output);
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
