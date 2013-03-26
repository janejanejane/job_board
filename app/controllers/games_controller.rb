class GamesController < ApplicationController

  before_filter :signed_in_user, except: [:index]
	before_filter :correct_user, only: [:index, :edit, :update, :create, :destroy]
  # before_filter :check_for_cancel, only: [:new, :create, :update]
 	before_filter :catch_cancel, update: [:create, :update, :destroy]
  after_filter :set_referrer, only: [:index, :show]

	def index
		logger.debug "inside INDEX"

		@user_games = @user.games
		@game = @user.games.build(params[:game])
		@all_games = Game.all(order: "id ASC")
	end

	def create
		logger.debug "inside CREATE"

		params[:game][:link] = check_url_structure(params[:game][:link])
		params[:game][:game_owner] = @user.id
		@recorded_game = Game.registered(params[:game][:name].strip, params[:game][:link].strip)

		if @recorded_game.blank? # if there is no recorded entry of the game
			@game = @user.games.create(params[:game]) # insert new entry in games table
			@games = @user.games

			if @game.valid?
				if @game.save # for newly created games
					flash[:success] = "New game entry added!"
					redirect_to user_games_path
				else
				@user_games = @user.games
				@all_games = Game.all
				render 'index'
				end
			else
				@user_games = @user.games
				@all_games = Game.all
				render 'index'
			end
		else
			game_info = params[:game]
			game_info.delete(:image)
			if @user.games.exists?(game_info)  # check if user has this game entry
				flash[:error] = "Game entry is in the list."
				redirect_to user_games_path
			else
				@games = @user.games << @recorded_game # create the association

				flash[:success] = "Game entry has been added before by a different user."
				redirect_to user_games_path
			end
		end
	end

	def edit
		logger.debug "inside EDIT"
		@game = Game.find(params[:id])
		@all_games = Game.all(order: "id ASC")
	end

	def update
		logger.debug "inside UPDATE"

		params[:game][:link] = check_url_structure(params[:game][:link])
		@game = Game.find(params[:id])
		# get name, link combination first to check it does not exists; avoids duplicate name
		@recorded_game = Game.registered(params[:game][:name].strip, params[:game][:link].strip) 

		if !params[:game][:image].nil? || @recorded_game.blank?
			@recorded_game = Game.registered_with_image(params[:game][:name].strip, params[:game][:link].strip, params[:game][:image].original_filename)
		end

		if @recorded_game.blank?
			if @game.update_attributes(params[:game])
				flash[:success] = "Game entry updated!"
				redirect_to user_games_path
			else
				render 'edit'
			end
		else
			game_info = params[:game]
			game_info.delete(:image)

			if @user.games.exists?(game_info) # check if user has this game entry
				flash[:error] = "Game entry is in the list."
				redirect_to user_games_path
			else
				@games = @user.games << @recorded_game # create the association

				flash[:success] = "Game entry has been added before by a different user."
				redirect_to user_games_path
			end
		end
	end

	def destroy
		logger.debug "inside DESTROY"
		this_game = Game.find(params[:id])
		@user.games.delete(this_game) # remove the associations
		if @user.id == current_user.id 
			if this_game.game_owner == @user.id # check ownership
				this_game.destroy # remove game record
			end
			flash[:success] = "Game entry removed!"
			redirect_to user_games_path
		else
			flash[:success] = "User removed!"
			params[:user_id] = current_user.id
			redirect_to edit_user_game_path(current_user.id)
		end
	end

	private 

		def signed_in_user
      logger.debug "inside signed_in_user"
      logger.debug signed_in?

      redirect_to root_url, flash: { error: "Action not allowed because you are not signed in." } unless signed_in?
    end

    def set_referrer
      # session[:referrer] = url_for(params)
      session[:referrer] = request.referer
    end

    def catch_cancel
      redirect_to session[:referrer] if params[:commit] == "Cancel"
    end

		def correct_user
			@user = User.find(params[:user_id])
		end

    def check_for_cancel
      if params[:commit] == "Cancel" || params[:commit] == "OK"
        redirect_to user_games_path
      end
    end

    def check_url_structure(url)
      /^https?/.match(url) ? url : "http://#{url}"
    end
end
