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
		    if hash["provider"] == "twitter"
				  user.image = hash["info"]["image"].sub("_normal", "")
				else
		    	user.image = hash["info"]["image"].split("=")[0] << "=large"
				end
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
		includes(:games).where("job_preference LIKE ?", "%"+job_pref+"%")
	end

	def self.no_job_pref
		where("job_preference IS NULL OR job_preference = ''")
	end

	def self.search(word, availability, location)
    query = "%" + word + "%"
    query_a = availability
    query_l = "%" + location + "%"

    if availability == -1 && location == ''
	    where(['((lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(nickname) LIKE ? 
	      OR lower(job_preference) LIKE ?))', query, query, query, query])
	  else
	  	if word == '' && location == '' 	
	  		where(['(availability = ?)', query_a])	  	
	  	elsif word = '' && availability = -1
	  		where(['(lower(location) LIKE ?)', query_l])	  	
	  	else
	  		where(['((lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(nickname) LIKE ? 
	      OR lower(job_preference) LIKE ?) AND availability = ? AND lower(location) LIKE ?)', query, query, query, query, query_a, query_l])
	  	end
	  end
	end


	attr_writer :vote_count, :vote_color # temporary/virtual variables
	attr_accessible :first_name, :last_name, :nickname, :personal_statement, 
									:image, :location, :job_preference, :availability, :job_pref_pnts, 
									:remaining_pnts, :new_user, :vote_count, :vote_color#, :extra_attributes

	has_many :authorizations
	has_many :votes
  has_one :extra, dependent: :destroy
	has_and_belongs_to_many :games

	# accepts_nested_attributes_for :extra
	
  # validates :first_name, uniqueness: { case_sensitive: false }
  # validates :last_name, uniqueness: { case_sensitive: false }
end
