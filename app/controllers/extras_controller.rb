class ExtrasController < ApplicationController

 	before_filter :catch_cancel, update: [:create, :update, :destroy]
  after_filter :set_referrer, only: [:index, :show]

	def index
		logger.debug "inside INDEX"
		@user = User.find(params[:user_id])
		@user_extra = @user.extra
		if @user_extra.blank?
    	@extra = @user.build_extra(params[:extra])
    else
    	@extra = @user_extra
    end
	end

	def show
		logger.debug "inside SHOW"
		@extra = Extra.find(params[:extra])
	end
	
	def create
		logger.debug "inside CREATE"
		@user = User.find(params[:user_id])
    @extra = @user.create_extra(params[:extra])

		if @extra.valid?
			if @extra.save # for newly created games
				flash[:success] = "Info entry added!"
				redirect_to user_extras_path
			else
				render 'index'
			end
		else
			render 'index'
		end
	end

	def update
		logger.debug "inside UPDATE"
		@user = User.find(params[:user_id])
		@extra = @user.extra

		if @extra.update_attributes(params[:extra])
			flash[:success] = "Info entry updated!"
			redirect_to user_extras_path
		else
			render 'index'
		end
	end

	private 

    def set_referrer
      # session[:referrer] = url_for(params)
      session[:referrer] = request.referer
    end

    def catch_cancel
      redirect_to session[:referrer] if params[:commit] == "Cancel"
    end
end
