# jQuery ->
# 	if $('.pagination').length
# 		$(window).scroll ->
# 			url = $('.pagination .next_page').attr('href')
# 			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 500
# 				$('.pagination').text("Loading more...")
# 				$.getScript(url)
# 				console.log $.getScript(url)
# 		$(window).scroll()