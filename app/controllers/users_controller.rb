class UsersController < ApplicationController
  # rescue_from ActiveRecord::Errors, :with => :has_same_name

  before_filter :check_for_cancel, only: [:edit, :update]
  before_filter :format_job_pref, only: [:create, :update]
  before_filter :search

  def index
    logger.debug 'inside INDEX'
  	@users_by_job_pref = Hash.new
    CATEGORY.each_with_index do |choice, index|
      result = User.in_job_preference(index.to_s)
      if(!result.blank?)
        @users_by_job_pref[choice] = result
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @users_by_job_pref }
    end
  end

  def show
  	@user = User.find(params[:id])
  end

	def edit
    logger.debug 'inside EDIT'
		@user = User.find(params[:id])
		@job_preference = (@user.job_preference.nil?) ? "" : @user.job_preference.split(',')
		if @user.new_user?
      @user.update_attribute(:new_user, "false")
		end
	end

	def update
    logger.debug 'inside UPDATE'
		params[:user][:new_user] = 'false'
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile update successful!"
			redirect_to root_path
		else
			render 'edit'
		end
	end

	private

    def has_same_name 
      flash[:error] = "User has been registered."
      redirect_to :root
    end

    def check_for_cancel
    logger.debug 'inside check_for_cancel'
      if params[:commit] == "Cancel" || params[:commit] == "OK"
        redirect_to jobs_path
      end
    end

    # gets the value of params[:lecture][:job_preference] and builds an array from it
    def format_job_pref
      logger.debug "inside format_job_pref"
      logger.debug "params: " + params.to_s

      if(!params[:user][:job_preference].nil?)
        @job_preference = params[:user][:job_preference].join(',')
      else
        @job_preference = ''
      end
      
      params[:user][:job_preference] = @job_preference
    end

    def search
      @word = word = params[:search]
      @job_search = @user_search = 0
      if !@word.nil?
        if @word != "" || !@word.blank?
          @job_results = Job.search(@word)
          @grouped_job_results = @job_results.group_by { |job| job.category }
          @job_search = @job_results.length

          @grouped_user_results = Hash.new
          CATEGORY.each_with_index do |choice, index|
            if((choice.downcase).include?(@word))
              word = index.to_s
            end
            @user_results = User.search(word)
            if(!@user_results.blank?)
              @grouped_user_results = @user_results
            end
          end
          @user_search = @user_results.length
        end
        render 'static_pages/search'
      end
    end
end
