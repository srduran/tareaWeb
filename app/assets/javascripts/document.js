/**
 * Created by Jaime on 6/1/2017.
 */
var converter = new Markdown.Converter();
function convert() {
    var area = document.getElementById('text-doc');
    var preview = document.getElementById('preview-doc');
    preview.innerHTML = converter.makeHtml(area.value);
}

$(document).ready(function (){

    $("#text-doc").keyup(function () {
        convert()
    });
    //Include code relating to reading whether the user liked this document
    //need to add a table for "likes" of some kind.
    $('#like-button').click(function () {
        $(this).toggleClass("active");
        $(this).blur();
    });
});