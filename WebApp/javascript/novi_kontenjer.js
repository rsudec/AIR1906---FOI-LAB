$(document).ready(function($) {
    $.ajaxSetup ({
        cache: false
    });

    $(document).on('keyup', '#naziv', function() {

        var naziv_res = $("#naziv").val();

        var greska=$("#greska_prva");

        var ispravno=true;

        $.ajax({
            type: "GET",
            url: "https://air-api.azurewebsites.net/Police",
            success: function (result) {

                for (var i in result) {
                    if (result[i].naziv===naziv_res){
                        ispravno=false;
                    }
                }
                if (ispravno){
                    greska.text(" ");
                }
                else{
                    greska.text("There is already a place with this name!");
                    greska.css('color', 'red');

                }

            }
        });

    });
});