module VotesHelper
	def get_vote_details(job_preference, user_voted)
		@vote_details = Vote.jobpref_vote(job_preference, user_voted)
	end
end
