class ExtrasController < ApplicationController

  before_filter :signed_in_user, except: [:index, :show]
 	before_filter :catch_cancel, update: [:create, :update, :destroy]
  after_filter :set_referrer, only: [:index, :show]
  before_filter :find_user, only: [:index, :create, :update]
  # skip_before_filter :update_remaining_pnts, only: [:create, :update] # prevent filter from running before particular actions

	def index
		logger.debug "inside INDEX"
		# @user = User.find(params[:user_id])
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
		# @user = User.find(params[:user_id])
    @extra = @user.create_extra(params[:extra])

		if @extra.valid?
			if @extra.save # for newly created games
				if update_remaining_pnts(@extra)
					flash[:success] = "Info entry added!"
				else
					flash[:error] = "Info entry update not successful!"
				end
				
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
		# @user = User.find(params[:user_id])
		@extra = @user.extra

		if @extra.update_attributes(params[:extra])
			if update_remaining_pnts(@extra)
				flash[:success] = "Info entry updated!"
			else
				flash[:error] = "Info entry update not successful!"
			end

			redirect_to user_extras_path
		else
			render 'index'
		end
	end

	private 
	
    def signed_in_user
      logger.debug "inside signed_in_user"
      logger.debug signed_in?

      redirect_to root_url, flash: { error: "Action not allowed because you are not signed in." } unless signed_in?
    end

    def find_user
      @user = User.find(params[:user_id])
    end

		def update_remaining_pnts(user_extra)
			if user_extra.experience < Time.now.year
				points = 10 + ((Time.now.year - user_extra.experience) * 10)
				@user.update_attribute(:remaining_pnts, points)
			end
		end

    def set_referrer
      # session[:referrer] = url_for(params)
      session[:referrer] = request.referer
    end

    def catch_cancel
      redirect_to session[:referrer] if params[:commit] == "Cancel"
    end
end
