/**
 * Created by Jaime on 6/1/2017.
 */
var converter = new Markdown.Converter();
function convert() {
    var area = document.getElementById('text-doc');
    var preview = document.getElementById('preview-doc');
    preview.innerHTML = converter.makeHtml(area.value);
}

function getLikeCount(doc) {
    var q = doc.val();
    $.ajax({
        type: "GET",
        url: "/likes",
        dataType: "json",
        data: {'':q},
        success: function (result) {

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
        var like_count = getLikeCount();
    });

    like_button.click(function () {
        $(this).toggleClass("active");
        $(this).blur();
    });
});