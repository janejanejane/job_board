module UsersHelper
	def format_job_pref
		@user_upvotes = Hash.new
		CATEGORY.each_with_index do |choice, index| 
			# if(!@job_preference.empty?) # limit display to job preference only
				# if(@job_preference.index{|d| d == index.to_s}) # checks if index is not nil
					vote_details = Vote.jobpref_vote(index, @user.id)
        	num = (@recorded_points.empty?) ? 0 : @recorded_points[index].to_i
					if !vote_details.blank?
						names = Array.new()
						vote_details.each do |record|
							user_details = User.find(record.user_id)
							names.push("<a href='/users/#{user_details.id}' class='user-link'><img src='#{user_details.image}'></a>")
						end
						@user_upvotes[choice] = { points: "<b>[+#{num}]</b>", voters: names.join(",") }
					else
						@user_upvotes[choice] = { points: "<b>[+#{num}]</b>", voters: "" }
					end
    		# end
  		# end 
 	 	end
	end
end
