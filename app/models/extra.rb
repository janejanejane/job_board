# == Schema Information
#
# Table name: extras
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  special_title :string(255)
#  experience    :integer
#  behance       :string(255)
#  deviantart    :string(255)
#  kongregate    :string(255)
#  gamasutra     :string(255)
#  newgrounds    :string(255)
#  gamejolt      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Extra < ActiveRecord::Base

	def self.find_user_id(user_id)
		where("user_id = ?", user_id)
	end

  attr_accessible :special_title, :experience, :behance, :deviantart, :kongregate, :gamasutra, :newgrounds, :gamejolt

  belongs_to :user

  validates :experience, numericality: {greater_than: 0}
end
