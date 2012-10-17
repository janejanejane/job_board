module JobsHelper
  def php_salary(unformatted_salary)
    number_to_currency(unformatted_salary.to_s, unit: "PHP")
  end

  def format_date(date)
    if !date.nil?
      I18n.localize(date, format: "%d %b")
    end
  end

  def current_category(job)
  	@category = job.category
  end
  
  def tweet(company, jobtitle, jobpost)
    @tweet = "http://twitter.com/home?status=#{company} is hiring a #{jobtitle} at #{jobpost}"
  end

  def fb_share(app_id, name, caption, description)
    @name = url_encode(name)
    @caption = url_encode("at " + caption)
    @description = url_encode(description)
    @host = "http://" + request.host_with_port
    @img = @host + image_path('igdamanila.png')
    @fbshare = "https://www.facebook.com/dialog/feed?"
    @fbshare.concat("app_id=#{app_id}&")
    @fbshare.concat("link=https://developers.facebook.com/docs/reference/dialogs/&")
    @fbshare.concat("picture=#{@img}&")
    @fbshare.concat("name=#{@name}&")
    @fbshare.concat("caption=#{@caption}&")
    @fbshare.concat("description=#{@description}&")
    @fbshare.concat("redirect_uri=https://stormy-mountain-2486.herokuapp.com")
  end

  def gplus_share
    @gpshare = "https://plus.google.com/share?url=#{job_url(@job)}"
  end
end
