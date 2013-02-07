class GamesController < ApplicationController

	before_filter :correct_user, only: [:index, :create]
  before_filter :check_for_cancel, only: [:new, :create, :update]

	def index
		logger.debug "inside INDEX"

		@user_games = @user.games
		@game = @user.games.build(params[:game])
		@all_games = Game.all
	end

	def create
		logger.debug "inside CREATE"

		params[:game][:link] = check_url_structure(params[:game][:link])
		@recorded_game = Game.registered(params[:game][:name].strip, params[:game][:link].strip)

		if @recorded_game.blank? # if there is no recorded entry of the game
			@game = @user.games.create(params[:game]) # insert new entry in games table
			@games = @user.games

			if @game.save # for newly created games
				flash[:success] = "New game entry added!"
				redirect_to user_games_path
			else
				@user_games = @user.games
				@all_games = Game.all
				render 'index'
			end
		else
			if @user.games.exists?(params[:game]) # check if user has this game entry
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
	end

	def update
		logger.debug "inside UPDATE"
		@game = Game.find(params[:id])

		if @game.update_attributes(params[:game])
			redirect_to @game
		else
			render 'edit'
		end
	end

	def destroy
		logger.debug "inside DESTROY"
		Game.find(params[:id]).destroy
		flash[:success] = "Game entry destroyed!"
		redirect_to games_path
	end

	private 

		def correct_user
			@user = User.find(params[:user_id])
		end

    def check_for_cancel
      if params[:commit] == "Cancel" || params[:commit] == "OK"
        redirect_to jobs_path
      end
    end

    def check_url_structure(url)
      /^https?/.match(url) ? url : "http://#{url}"
    end
end
