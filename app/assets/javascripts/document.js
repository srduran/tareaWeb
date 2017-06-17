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
    })
});