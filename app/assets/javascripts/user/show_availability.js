$('document').ready(function(){
	console.log("show_availability loaded");
	console.log(availability_data);
	// $('input:visible').focus();
	$('#availability').typeahead({
    minLength: 0,
    items: 3,
		source: availability_data
	});
	$('#availability').on(
		'focus', $('#availability').typeahead.bind(
			$('#availability'), 'lookup')
	);
	// $('#availability').on('focus', function() {
 //      setTimeout($('#availability').typeahead.bind($('#availability'), 'lookup'), 200);
 //  });
	// $('#availability').focus();
});