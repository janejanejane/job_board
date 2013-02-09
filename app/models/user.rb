# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  nickname           :string(255)
#  personal_statement :string(140)
#  image              :string(255)
#  location           :string(255)
#  job_preference     :string(255)
#  availability       :integer
#  new_user           :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ActiveRecord::Base
	def self.create_from_hash(hash)
		firstname = (hash["info"]["first_name"].nil?) ? hash["info"]["name"] : hash["info"]["first_name"]
		lastname = hash["info"]["last_name"]
		nickname = (hash["info"]["nickname"].nil?) ? firstname : hash["info"]["nickname"]

		if User.registered(firstname, lastname).size > 0
			errors.add("User is registered.")
		else
		  create! do |user|
		    user.first_name = firstname
		    user.last_name = lastname
		    user.nickname = nickname
		    user.image = hash["info"]["image"]
	    	user.location = hash["info"]["location"]
	    	user.personal_statement = hash["info"]["description"]
		  end
		end
	end

	def self.registered(firstname, lastname)
		firstname = "%#{firstname}%"
		lastname = "%#{lastname}%"
		where("first_name LIKE ? AND last_name LIKE ?", firstname, lastname)
	end

	def self.in_job_preference(job_pref)
		where("job_preference LIKE ?", "%"+job_pref+"%")
	end

	def self.no_job_pref
		where("job_preference IS NULL")
	end

	def self.search(word)
    query = "%" + word + "%"
    where(['(lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(nickname) LIKE ? 
      OR lower(location) LIKE ? OR lower(job_preference) LIKE ?)', query, query, query, query, query])
	end

	attr_accessible :first_name, :last_name, :nickname, :personal_statement, 
									:image, :location, :job_preference, :availability, :new_user#, :extra_attributes

	has_many :authorizations
  has_one :extra, dependent: :destroy
	has_and_belongs_to_many :games

	# accepts_nested_attributes_for :extra
	
  # validates :first_name, uniqueness: { case_sensitive: false }
  # validates :last_name, uniqueness: { case_sensitive: false }
end
