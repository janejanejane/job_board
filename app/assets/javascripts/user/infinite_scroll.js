$('document').ready(function(){
	console.log("pagination loaded");
	if($(".pagination")){
		$(window).scroll(function(){

			// console.log(($('window').scrollTop() + $('window').height()));
			// console.log(($('document').height() - 200));
			var that = this;
			var nextUrl = $(".pagination .next_page").attr("href");

			if (nextUrl && (($(window).scrollTop() + $(window).height()) > ($('document').height() - 50))){
				console.log(nextUrl);
				$(".pagination").text("Loading...");
				$.ajax({ //used with handlebars: #1
					type : "GET",
					url : nextUrl
				})
				// $.getScript(nextUrl) // used with category.js.erb
				.done(function(response, textStatus){
					console.log(response);
					console.log(textStatus);
					// #1					
					var thisList = $("#moreUsersList").html();
					if(thisList){
						var template = Handlebars.compile(thisList);
						var usersMoreThanZero = response.entries.length > 0;

						Handlebars.registerHelper('getPoints', function(points, catId) {
							var str = "0";
							if(points != null){
								var values = points.split(",");
								str = values[catId]; // from @cat_id
								console.log("category: ", catId, "points: ", values);
							}
						  return str;
						});

						Handlebars.registerHelper('getGames', function(games) {
							var str = [];
							for (var i = 0; i < games.length; i++) {
								str.push(games[i].name);
							};
							return str.join(",");
						});
						
						var htmlData = template({
							usersMoreThanZero: usersMoreThanZero, 
							usersData: response.entries
						});
						$(".users").append(htmlData);

						if( $("li").length < response.entries.total_entries){
							if($(".next_page")) {
								var path = window.location.pathname + "?page="+ (response.current_page + 1);
								$(".pagination").replaceWith("<a href='" + path + "' class='pagination next_page'>Load more...</a>");
							} 
						} else {
							$(".pagination").remove();	
						}	
					}
					// #1

				}).fail(errorMsg);
			}
		});	// end $(window).scroll(function(){
	} // end if($(".pagination"))

	function errorMsg(jqXHR, settings, textStatus){
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
	}
});