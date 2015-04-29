$(document).ready(function () {
    $.countdown.setDefaults($.countdown.regionalOptions['']);
    var minute = $('.temp_information').attr("data-minute");
    var oldDateObj = Date.now();
    var newTime = new Date(oldDateObj + minute*60000);
    $('#until2d').countdown({until: newTime, onTick: highlightLast5,onExpiry: save}); 
});

function highlightLast5(periods) { 
    if ($.countdown.periodsToSeconds(periods) === 5) { 
        $(this).addClass('highlight'); 
    } 
}

function save(){
    $("input[name='commit']").trigger( "click" );
}

$(document).ready(function() {
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/tomorrow");
    editor.setDisplayIndentGuides(true)
    editor.getSession().setMode("ace/mode/python");
});
