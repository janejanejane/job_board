module GamesHelper
	def format_users_id
		@users_with_id = Hash.new 
		@all_games.each do |game_record| 
			game_record.users.each do |user_record| 
				if game_record.id == @game.id && user_record.id != params[:user_id].to_i 
					@users_with_id[user_record.id] = user_record.first_name		
				end
			end 
		end 
	end
end
