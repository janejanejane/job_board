$('document').ready(function(){
	console.log("change points...")
	$(".icon-plus").click(function(e){
		e.preventDefault();
		console.log('Plus Btn Clicked');

		var that = this;
		var id = $(this).parent().data('point').user_id;
		var jobpref = $(this).parent().data('point').jobpref;
		console.log($(this).parent().data('point'));
		console.log(id);

		$.ajax({
			type : "POST",
			url : "/users/" + id + "/plus",
			data : {
				id : id,
				jobpref : jobpref
			}
		}).done(function(msg){
			console.log(msg);
			console.log("200:" + msg.success);

			$("#" + id + "-" + jobpref).html(msg.points); //change points
			$("#remaining").html(msg.remaining); //change remaining points

		}).fail(function(jqXHR, textStatus){
			var response = JSON.parse(jqXHR.responseText);

			if(jqXHR.status == 422){
				console.log("422:" + response.errors);
			}else if(jqXHR.status == 500){
				console.log("500:" + response.errors);
			}else if(jqXHR.status == 404){
				console.log("404:" + response.errors);
			}

			$('.points-status').html('<div class="alert alert-error">'+ response.errors +'</div>').show().fadeOut(2000);
		});
	});


	$(".icon-minus").click(function(e){
		e.preventDefault();
		console.log('Minus Btn Clicked');

		var that = this;
		var id = $(this).parent().data('point').user_id;
		var jobpref = $(this).parent().data('point').jobpref;
		console.log($(this).parent().data('point'));
		console.log(id);

		$.ajax({
			type : "POST",
			url : "/users/" + id + "/minus",
			data : {
				id : id,
				jobpref : jobpref
			}
		}).done(function(msg){
			console.log(msg);
			console.log("200:" + msg.success);

			$("#" + id + "-" + jobpref).html(msg.points); //change points
			$("#remaining").html(msg.remaining); //change remaining points

		}).fail(function(jqXHR, textStatus){
			var response = JSON.parse(jqXHR.responseText);

			if(jqXHR.status == 422){
				console.log("422:" + response.errors);
			}else if(jqXHR.status == 500){
				console.log("500:" + response.errors);
			}else if(jqXHR.status == 404){
				console.log("404:" + response.errors);
			}

			$('.points-status').html('<div class="alert alert-error">'+ response.errors +'</div>').show().fadeOut(2000);
		});

		return false;
	});
});