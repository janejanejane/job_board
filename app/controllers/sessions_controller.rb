class SessionsController < ApplicationController
	def create
		#raise env["omniauth.auth"].to_yaml
		auth = env["omniauth.auth"]
		authorized_user = Authorization.from_omniauth(auth)
		user = User.find(authorized_user.user_id)
		session[:user_id] = authorized_user.user_id

		if user.new_user?
			redirect_to edit_user_path(user),	flash: { success: "Please update your profile information." } 
		else
			redirect_to root_url,	flash: { success: "Signed in successfully!" } 
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, flash: { success: "Signed out successfully!" } 
	end
end
