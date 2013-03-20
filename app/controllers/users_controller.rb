class UsersController < ApplicationController
  # rescue_from ActiveRecord::Errors, :with => :has_same_name

  # before_filter :check_for_cancel, only: [:edit, :update]
  before_filter :catch_cancel, update: [:create, :update, :destroy]
  after_filter :set_referrer, only: [:index, :show]
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

    @users_no_job_pref = User.no_job_pref
    
    respond_to do |format|
      format.html
      format.json { render json: @users_by_job_pref }
    end
  end

  def show
  	@user = User.find(params[:id])
    @games = @user.games
    @all_games = Game.all(order: "id ASC")
    @user_extra = @user.extra
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
			redirect_to edit_user_path(@user)
		else
      render 'edit'
		end
	end

  def vote
    # get/set values
    logger.debug params
    user_voted = params[:id].to_i
    job_preference = params[:jobpref]
    voters = Array.new

    if current_user.id != user_voted
      vote_record = Vote.jobpref_vote(user_voted, job_preference)

      if !vote_record.blank?
        voters = vote_record.first.voters.split(",")

        if voters.include?(current_user.id.to_s)
          redirect_to :back, flash: { error: "Unable to vote, perhaps you already did." }
        else
          # include voter
          voters = voters.push(current_user.id).join(",")
          vote_record.first.update_attribute(:voters, voters)
          
          redirect_to :back, flash: { success: "Vote counted." }
        end
      else
        # include voter
        voters = voters.push(current_user.id).join(",")

        # cast new vote
        vote = Vote.new(user_voted: user_voted, job_preference: job_preference, voters: voters)
        if vote.save
          redirect_to :back, flash: { success: "Vote counted." }
        else
          redirect_to :back, flash: { error: "Unable to vote, perhaps you already did." }
        end
      end
    else
      redirect_to :back, flash: { error: "You are not allowed to vote for yourself." }
    end
  end

	private

    def set_referrer
      session[:referrer] = url_for(params)
      # session[:referrer] = request.referer
    end

    def catch_cancel
      redirect_to session[:referrer] if params[:commit] == "Cancel"
    end
    
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
