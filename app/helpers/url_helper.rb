module UrlHelper
	def url_with_protocol(url)
		@website = /^https?/.match(url) ? url : "http://#{url}"
	end	
end