$('document').ready(function(){
	console.log("pagination loaded");
	if($(".pagination")){
		$(window).scroll(function(){

			// console.log(($('window').scrollTop() + $('window').height()));
			// console.log(($('document').height() - 200));
			var that = this;
			var nextUrl = $(".pagination .next_page").attr("href");

			if (nextUrl && (($(window).scrollTop() + $(window).height()) > ($('document').height() - 200))){
				console.log(nextUrl);
				$(".pagination").text("Loading...");
				// $.ajax({ //used with handlebars: #1
				// 	type : "GET",
				// 	url : nextUrl
				// })
				$.getScript(nextUrl) // used with category.js.erb
				.done(function(response, textStatus){
					console.log(response);
					console.log(textStatus);
					// #1
					// console.log(response.entries.length);

					// var container = $(that).find(".users");

					// var moreUsersList = $("#moreUsersList").html();
					// if(moreUsersList){
					// 	var template = Handlebars.compile(moreUsersList);
					// 	var usersMoreThanZero = response.entries.length > 0;
					// 	var htmlData = template({usersMoreThanZero: usersMoreThanZero, usersData: response.entries})
					// 	container.append(htmlData);
					// }
					// #1

				}).fail(function(jqXHR, settings, textStatus){
					var response = JSON.parse(jqXHR.responseText);
					console.log("ERROR: ", response);

					if(jqXHR.status == 422){
						console.log("422:" + response.errors);
					}else if(jqXHR.status == 500){
						console.log("500:" + response.errors);
					}else if(jqXHR.status == 404){
						console.log("404:" + response.errors);
					}

					$('.category-status').html('<div class="alert alert-error">'+ response.errors +'</div>').show().fadeOut(2000);
				});
			}
		});	// end $(window).scroll(function(){
	} // end if($(".pagination"))
});