$('document').ready(function(){
	console.log("voting...")
	$(".vote-btn").click(function(e){
		e.preventDefault();
		console.log('Vote Btn Clicked');

		var that = this;
		var id = $(this).data('vote').user_id;
		var jobpref = $(this).data('vote').jobpref;
		console.log($(this).data('vote'));
		console.log(id);

		$.ajax({
			type : "POST",
			url : "/users/" + id + "/vote",
			data : {
				id : id,
				jobpref : jobpref
			}
		}).done(function(msg){
			console.log(msg);
			console.log("200:" + msg.success);
			// $('.vote-status').html('<div class="alert alert-success">'+ msg.success +'</div>').fadeOut(3000);

			if ($(that).hasClass('up-btn')) {
				console.log("RED BTN");
				$(that).removeClass('up-btn').addClass('red-btn'); //change to upvote color
			} else {
				console.log("UP BTN");
				$(that).removeClass('red-btn').addClass('up-btn'); //change to downvote color
			}

			$(that).parent().find("span").html(msg.votes); //change vote numbers

		}).fail(function(jqXHR, textStatus){
			var response = JSON.parse(jqXHR.responseText);

			if(jqXHR.status == 422){
				console.log("422:" + response.errors);
			}else if(jqXHR.status == 500){
				console.log("500:" + response.errors);
			}else if(jqXHR.status == 404){
				console.log("404:" + response.errors);
			}

			$('.vote-status').html('<div class="alert alert-error">'+ response.errors +'</div>').show().fadeOut(1000);
		});

		return false;
	});
});