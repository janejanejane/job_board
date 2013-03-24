# == Schema Information
#
# Table name: votes
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  job_preference :integer
#  user_voted     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Vote < ActiveRecord::Base
	def self.check_unique_vote(user_id, job_preference, user_voted)
		where("user_id = ? AND job_preference = ? AND user_voted = ?", user_id, job_preference, user_voted)
	end

	def self.jobpref_vote(job_preference, user_voted)
		where("job_preference = ? AND user_voted = ?", job_preference, user_voted)
	end

  attr_accessible :job_preference, :user_voted

  validates :job_preference, presence: true
  validates :user_voted, presence: true
  # validate :ensure_not_self

  belongs_to :user

  # def ensure_not_self
  #   errors.add :user_id, "cannot upvote for self" if current_user.id == user_id
  # end
end
