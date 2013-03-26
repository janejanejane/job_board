class UsersController < ApplicationController
  # rescue_from ActiveRecord::Errors, :with => :has_same_name

  # before_filter :check_for_cancel, only: [:edit, :update]
  before_filter :catch_cancel, update: [:create, :update, :destroy]
  after_filter :set_referrer, only: [:index, :show]
  before_filter :find_user, only: [:show, :edit, :update, :plus, :minus]
  before_filter :set_pref, only: [:show, :edit]
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
    @games = @user.games
    @all_games = Game.all(order: "id ASC")
    @user_extra = @user.extra
  end

	def edit
    logger.debug 'inside EDIT'

		if @user.new_user?
      @user.update_attribute(:new_user, "false")
		end
	end

	def update
    logger.debug 'inside UPDATE'
		params[:user][:new_user] = 'false'

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
    user_voted = params[:id].to_i # user id for voted user
    job_preference = params[:jobpref]
    voters = Array.new

    if current_user.id != user_voted
      vote_record = Vote.jobpref_vote(job_preference, user_voted)

      if !vote_record.blank?
        vote_record.each do |vote|
          voters.push(vote.user_id)
        end

        if !voters.include?(current_user.id)
          cast_vote(job_preference, user_voted)
        else
          Vote.where(user_id: current_user.id, job_preference: job_preference, user_voted: user_voted).delete_all
          vote_details = Vote.jobpref_vote(job_preference, user_voted)
          # redirect_to :back, flash: { success: "Vote subtracted." }    
          render json: { success: "Vote subtracted.", votes: vote_details.count }, status: 200
        end
      else
        cast_vote(job_preference, user_voted)
      end
    else
      vote_details = Vote.jobpref_vote(job_preference, user_voted)
      # redirect_to :back, flash: { error: "You are not allowed to vote for yourself." }
      render json: { errors: "You are not allowed to vote for yourself.", votes: vote_details.count }, status: 422
    end
  end

  def plus
    job_preference = params[:jobpref].to_i
    recorded_points = (@user.job_pref_pnts.nil?) ? "" : @user.job_pref_pnts.split(',')
    remaining_pnts = @user.remaining_pnts
    points = Array.new

    CATEGORY.each_with_index do |choice, index|
      if job_preference == index
        num = (recorded_points.empty?) ? 0 : recorded_points[index].to_i
        if(num + 1 < remaining_pnts)
          points.push((num + 1).to_s)
          remaining_pnts -= 1
        else
          points.push("0")
          redirect_to :back, flash: { error: "Cannot set value greater than your points: #{remaining_pnts}." } and return
        end
      else
        points.push("0")
      end
    end

    if @user.update_attributes({"job_pref_pnts" => points.join(','), "remaining_pnts" => remaining_pnts})
      redirect_to :back and return
    else
      render 'edit'
    end
    # redirect_to :back, flash: { success: "Plus! #{points.join(',')}" }
  end

  def minus
    job_preference = params[:jobpref].to_i
    recorded_points = (@user.job_pref_pnts.nil?) ? "" : @user.job_pref_pnts.split(',')
    remaining_pnts = @user.remaining_pnts
    points = Array.new

    CATEGORY.each_with_index do |choice, index|
      if job_preference == index
        num = (recorded_points.empty?) ? 0 : recorded_points[index].to_i
        if(num - 1 > -1)
          points.push((num - 1).to_s)
          remaining_pnts += 1
        else
          points.push("0")
          redirect_to :back, flash: { error: "Cannot set value lesser than 0." } and return
        end
      else
        points.push("0")
      end
    end

    if @user.update_attributes({"job_pref_pnts" => points.join(','), "remaining_pnts" => remaining_pnts})
      redirect_to :back and return
    else
      render 'edit'
    end
    # redirect_to :back, flash: { success: "Minus! #{points.join(',')}" }
  end

	private

    def find_user
      @user = User.find(params[:id])
    end

    def set_pref
      @job_preference = (@user.job_preference.nil?) ? "" : @user.job_preference.split(',')
      @job_pref_pnts = (@user.job_pref_pnts.nil?) ? "" : @user.job_pref_pnts.split(',')
    end

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

    def cast_vote(job_preference, user_voted)
      # cast new vote
      vote = current_user.votes.new(job_preference: job_preference, user_voted: user_voted)
      if vote.save
        vote_details = Vote.jobpref_vote(job_preference, user_voted)
        # redirect_to :back, flash: { success: "Vote counted." }      
        render json: { success: "Vote counted.", votes: vote_details.count }, status: 200
      else
        vote_details = Vote.jobpref_vote(job_preference, user_voted)
        # redirect_to :back, flash: { error: "Unable to vote, perhaps you already did." }        
        render json: { errors: "Unable to vote, perhaps you already did.", votes: vote_details.count }, status: 422
      end
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
