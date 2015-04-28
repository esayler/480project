$(document).ready(function () {
    var minute = $('.temp_information').data('minute')
    var oldDateObj = Date.now()
    var newTime = new Date(oldDateObj + minute*60000);
    console.log(minute);
    console.log(newTime)
    $('#until2d').countdown({until: newTime});
});


$(document).ready(function() {
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/tomorrow");
    editor.setDisplayIndentGuides(true)
    editor.getSession().setMode("ace/mode/python");
});
