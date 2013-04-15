$('document').ready(function(){
	console.log("format_email loaded");
	var el = $('#apply-details');
	if(el.length){
		var str = $(el).text().split(" ");
		var email;
		var emailId;
		$.each(str, function(index, item){
			if(item.indexOf("@") > -1 && item.indexOf(".") > -1){
				emailId = index;
				email = $("<a>").attr("href", "mailto:" + item).text(item);
			}	
		});

		console.log(email[0].outerHTML);
		str[emailId] = email[0].outerHTML;

		$(el).html(str.join(" "));
	}
});