$(document).ready(function() {

    var prikazDnevnik = $("#prikaz_resursi");

    prikazDnevnik.text("Učitavanje podataka...");
    dohvatiPodatke();
    $.ajaxSetup ({
        cache: false
    });

    function dohvatiPodatke() {

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/SviResursi",
            success: function (result) {
                var output =
                    "<table id='tablica'><thead><tr><th>ID resursa</th><th>Naziv</th><th>Tip resursa</th><th>Količina</th><th>Zauzeto</th>" +
                    "<th>Maksimalno vrijeme<br> posudbe (u danima)</th><th>Slika</th></thead><tbody>";

                for (var i in result) {
                    var slika=result[i].slika;
                    output +=
                        "<tr><td>" +
                        result[i].id_resurs +
                        "</td><td>" +
                        result[i].nazivr +
                        "</td><td>" +
                        result[i].nazivtr +
                        "</td><td>" +
                        result[i].kolicina+
                        "</td><td>" +
                        result[i].zauzeto+
                        "</td><td>" +
                        result[i].max_posudba +
                        "</td><td>" +
                        "<img src='"+slika+"'>"+
                        "</td></tr>";
                }
                output += "</tbody></table>";

                prikazDnevnik.html(output);
                $("table").addClass("table");
                $("th").css({"background-color": "#f3f3f3", "color":"#4E5766", "text-align": "center",
                    "vertical-align": "middle"});
                $("td").css({"text-align": "center",
                    "vertical-align": "middle"});
                $("img").css({"width": "50px", "height": "50px"});
                $('table').DataTable(
                    {

                    });
                setTimeout(dohvatiPodatke, 10000);
            }
        });
    }


});
