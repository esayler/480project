$(function () { 
	var newYear = new Date(); 
	newYear = new Date(newYear.getFullYear() + 1, 1 - 1, 1);
	$('#until2d').countdown({until: newYear});
});