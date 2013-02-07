# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  link       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base

	def self.registered(name, link)
		where("name = ? AND link = ?", name, link).first
	end

  attr_accessible :link, :name

  VALID_URL_REGEX = /\A(https?|ftp|file):\/\/[-A-Za-z0-9+&@#\/%?=~_|!:,.;]*[-A-Za-z0-9+&@#\/%=~_|]/ix
  validates :link, presence: :true, format: { with: VALID_URL_REGEX }
  validates :name, presence: :true

	has_and_belongs_to_many :users
end
