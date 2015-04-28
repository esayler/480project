$(function () { 
	var minute = $('.temp_information').data('minute')
	var oldDateObj = Date.now()
	var newTime = new Date(oldDateObj + minute*60000);
	console.log(minute);
	console.log(newTime)
	$('#until2d').countdown({until: newTime});
});