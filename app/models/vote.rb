class Vote < ActiveRecord::Base
	def self.check_unique_vote(user_voted, job_preference, voter_id)
		voter_id = "%#{voter_id}%"
		where("user_voted = ? AND job_preference = ? AND voters LIKE ?", user_voted, job_preference, voter_id)
	end

	def self.jobpref_vote(user_voted, job_preference)
		where("user_voted = ? AND job_preference = ?", user_voted, job_preference)
	end

  attr_accessible :user_voted, :job_preference, :voters

  # validate :ensure_not_self

  belongs_to :user

  # def ensure_not_self
  #   errors.add :user_id, "cannot upvote for self" if current_user.id == user_id
  # end
end
