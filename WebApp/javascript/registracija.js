$(document).ready(function($) {
    $.ajaxSetup ({
        cache: false
    });
    $(document).on('input', '#ponovljena_lozinka', function() {

        var v = $("#lozinka").val();
        var v2 = $("#ponovljena_lozinka").val();
        var greska=$("#greska");

        if (v === v2)
        {
            greska.text(" ");
            $("#gumbregistracija").prop("disabled", false);

        } else {

            greska.text("Lozinka i ponovljena lozinka nisu jednake");
            greska.css('color', 'red');
            $("#gumbregistracija").prop("disabled", true);
        }
    });

    $(document).on('input', '#email', function() {

        var email = $("#email").val();

        var greska=$("#greska1");


        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/ShowUsers",
            success: function (result) {

                for (var i in result) {
                    if (result[i].email===email){
                        greska.text("Već postoji korisnik s unesenom e-mail adresom");
                        greska.css('color', 'red');
                        $("#gumbregistracija").prop("disabled", true);
                    }
                    else {
                        greska.text(" ");
                        $("#gumbregistracija").prop("disabled", false);
                    }

                }

            }
        });
    });

        $(document).on('input', '#korime', function() {

            var korime = $("#korime").val();

            var greska=$("#greska2");


            $.ajax({
                type: "GET",
                url: "https://air-api.azurewebsites.net/ShowUsers",
                success: function (result) {

                    for (var i in result) {
                        if (result[i].kor_ime===korime){
                            greska.text("Korisničko ime je zauzeto");
                            greska.css('color', 'red');
                            $("#gumbregistracija").prop("disabled", true);
                        }
                        else {
                            greska.text(" ");
                            $("#gumbregistracija").prop("disabled", false);
                        }

                    }

                }
            });

    });


});
