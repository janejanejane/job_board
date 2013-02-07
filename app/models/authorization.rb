# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  username   :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authorization < ActiveRecord::Base
	belongs_to :user
	
  def self.from_omniauth(auth)
	  where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
	end

	def self.create_from_omniauth(auth, user = nil)
		user ||= User.create_from_hash(auth)
	  create! do |registered_user|
	    registered_user.provider = auth["provider"]
	    registered_user.uid = auth["uid"]
	    registered_user.username = auth["info"]["nickname"]
	    registered_user.user = user
	  end
	end
end
