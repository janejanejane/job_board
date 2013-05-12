# == Schema Information
#
# Table name: games
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  link               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  game_owner         :integer
#

class Game < ActiveRecord::Base

	def self.registered(name, link)
		where("name = ? AND link = ?", name, link).first
	end

	def self.registered_with_image(name, link, image)
		where("name = ? AND link = ? AND image_file_name = ?", name, link, image).first
	end

  attr_accessible :link, :name, :image, :game_owner

  VALID_URL_REGEX = /\A(https?|ftp|file):\/\/[-A-Za-z0-9+&@#\/%?=~_|!:,.;]*[-A-Za-z0-9+&@#\/%=~_|]/ix
  validates :link, presence: :true, format: { with: VALID_URL_REGEX }
  validates :name, presence: :true
  validates_attachment :image, presence: true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	has_and_belongs_to_many :users
	has_attached_file :image, 
			styles: { medium: "300x300>", thumb: "100x100>" }#, 
			# path: ":rails_root/public/system/:attachment/:id/:style/:filename",
      # url: "/system/:attachment/:id/:style/:filename" # from paperclip
end
