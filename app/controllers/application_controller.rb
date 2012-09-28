class ApplicationController < ActionController::Base
  before_filter :set_mailer_host
  protect_from_forgery

  def set_mailer_host
  	ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
