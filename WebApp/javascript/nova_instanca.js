$(document).ready(function($) {

    $("#ormar").on("click",function () {
        var id_ormar = $(this).val();

        $.ajax({
            type: 'GET',
            url: 'https://air-api.azurewebsites.net/Police2/'+id_ormar,
            success: function (msg) {
                $("#pozicija").empty();
                $.each(msg, function(i, item) {
                    $("#pozicija").append("<option value='" + item.id_kontejner + "'>" + item.naziv +"</option>");
                });
            },

        });
    });
});

