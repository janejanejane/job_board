$('document').ready(function(){
	console.log("show_availability loaded");
	console.log(availability_data);
	$('#availability').typeahead({source: availability_data})  
});