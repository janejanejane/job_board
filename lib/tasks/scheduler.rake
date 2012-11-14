namespace :job_board do
	desc "This task checks for job posts that is one-month old."
	task :check_expiring => :environment do
		puts "Starting :check_job_post..."
		job_post_expiring = Job.expiring
		puts "There are #{job_post_expiring.length} jobs that are expired."
		puts "Done."	
	end

	desc "This task sends a notification to job poster if it is ok to delete."
	task :send_reminders => :environment do
		puts "Starting :send_reminders..."
		puts "There are #{reminder_email} email(s) sent."
		puts "Done."
	end

	desc "This task calls both :check_expiring and :send_reminders in order."
	task :all_tasks => [:check_expiring, :send_reminders]

	def reminder_email
		expiring_jobs = Job.expiring
		count = expiring_jobs.length

		if count > 0
			expiring_jobs.each do |jobpost|
				if JobBoardMailer.reminder_email(jobpost).deliver
					delete_job(jobpost)
		      puts "Job Post: #{jobpost.jobtitle} expired; reminder sent."
		    end
			end
		end

		return count
	end

	def delete_job(jobpost)
		jobpost.update_attribute(:isdeleted, 1)
	end
end