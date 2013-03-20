module VotesHelper
	def get_vote_details(user_id, job_preference, voter_id)
		# @vote_details = Vote.check_unique_vote(user_id, job_preference, voter_id)
		@vote_details = Vote.jobpref_vote(user_id, job_preference)
		if !@vote_details.blank?
			@vote_details = @vote_details.first.voters.split(",")
		end
	end
end
