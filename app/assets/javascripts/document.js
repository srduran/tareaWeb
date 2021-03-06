/**
 * Created by Jaime on 6/1/2017.
 */

var converter = new Markdown.Converter();
function convert() {
    var area = document.getElementById('text-doc');
    var preview = document.getElementById('preview-doc');
    preview.innerHTML = converter.makeHtml(area.value);
}

function getLikeCount(doc_id) {
    var url = "/likes/" + doc_id + "/count";
    console.log(url);
    $.ajax({
        type: "GET",
        url: url,
        dataType: "json",
        success: function (result) {
            var button = $("#like-button");
            button.html(' ' + result.likingPeople);
            if (result.iLikeIt) {
                button.toggleClass("active");
            }

            console.log(result.iLikeIt);
        }
    })
}

function addLike(doc_id){
    $.ajax({
        type:"POST",
        url: "/likes/" + doc_id + "/add",
        dataType: "json",
        success: function (result) {
            var button = $("#like-button");
            button.html(' ' + result.likingPeople);
            if (result.iLikeIt) {
                button.addClass("active");
            }
            console.log(result)
        }
    })
}

function removeLike(doc_id){
    $.ajax({
        type:"DELETE",
        url: "/likes/" + doc_id + "/remove",
        dataType: "json",
        success: function (result) {
            var button = $("#like-button");
            button.html(' ' + result.likingPeople);
            if (!result.iLikeIt){
                button.removeClass("active");
            }
            console.log(result)
        }
    })
}

$(document).ready(function (){
    var like_button = $('#like-button');

    $("#text-doc").keyup(function () {
        convert()
    });
    //Include code relating to reading whether the user liked this document
    //need to add a table for "likes" of some kind.
    like_button.ready(function () {
        var doc_id = $("#doc_id").attr('data-id');
        getLikeCount(doc_id);
    });

    like_button.click(function () {
        var doc_id = $("#doc_id").attr('data-id');
        if ($(this).hasClass("active")){
            removeLike(doc_id);
        }
        else{
            addLike(doc_id);
        }
        //$(this).toggleClass("active");
        $(this).blur();
    });
});