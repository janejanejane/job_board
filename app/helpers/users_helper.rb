module UsersHelper
	def format_job_pref
		# @user_upvotes = Hash.new
		@user_upvotes = Array.new
		CATEGORY.each_with_index do |choice, index| 
			# if(!@job_preference.empty?) # limit display to job preference only
				# if(@job_preference.index{|d| d == index.to_s}) # checks if index is not nil; returns true if value is in array
					vote_details = Vote.jobpref_vote(index, @user.id)
        	num = (@recorded_points.empty?) ? 0 : @recorded_points[index].to_i
					if !vote_details.blank?
						names = Array.new()
						vote_details.each do |record|
							user_details = User.find(record.user_id)
							names.push("<a href='/users/#{user_details.id}' class='user-link'><img src='#{user_details.image}'></a>")
						end
						# @user_upvotes[choice] = { points: "<b>[+#{num}]</b>", voters: names.join(",") }
						@user_upvotes.push({ name: "#{choice}", points: num, voters: names.join(",") })
					else
						# @user_upvotes[choice] = { points: "<b>[+#{num}]</b>", voters: "" }
						@user_upvotes.push({ name: "#{choice}", points: num, voters: "" })
					end


					if(!@job_preference.empty?) # check if user has jobpref
						if(@job_preference.index{|d| d == index.to_s}) # checks if index is not nil; returns true if value is in array
							@user_upvotes[index][:preferred] = true
						end
					else
						@user_upvotes[index][:preferred] = false
					end
    		# end
  		# end 
 	 	end
	end

	def get_games(user_id)
		@games = User.find(user_id).games
	end
end
