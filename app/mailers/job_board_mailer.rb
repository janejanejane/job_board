class JobBoardMailer < ActionMailer::Base
	#default_url_options[:host] = request.host_with_port
	default from: "noreply@igda.com"

	def confirmation_email(jobpost)
		@jobpost = jobpost
		@host = job_url(@jobpost)
		@jobpost = jobpost.jobtitle
		@id = jobpost.id
		@confirmation_key = jobpost.jobkey
		mail to: jobpost.confirmation_email, subject: 'Confirmation'
	end
end
