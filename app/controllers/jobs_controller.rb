require 'will_paginate/array'

class JobsController < ApplicationController
  #private methods are loaded

  # before_filter :signed_in_user, except: [:index, :show]
  before_filter :current_job, only: [:show, :category, :confirm]
  before_filter :check_for_cancel, only: [:new, :create, :update]
  before_filter :search

  def show
    logger.debug 'SHOWING SHOW'
    if @job.jobkey_confirmation.blank?
      render 'success' #show success page
    end
  end
  
  def index
    logger.debug 'INDEX IS HERE'
    @jobs_by_category = Job.confirmed.group_by { |job| job.category }    
  end

  def new
    logger.debug 'NEW IS HERE'
    if params[:job]
      params[:job][:jobkey] = create_key(20)
      # params[:job][:company_website] = check_url_structure(params[:job][:company_website])
      params[:job][:salary] = clean_salary_format(params[:job][:salary])
      @job = Job.new(params[:job])
      if !@job.valid?
        @save_errors = @job.errors
      else
        create
      end
    else
      @job = Job.new
    end
  end
  
  def create
    logger.debug 'CREATE IS HERE'
    @job = Job.new(params[:job])
    
    if params[:preview]
      session[:job] = @job
      redirect_to preview_new_job_path(@job)
    else
      if params[:save] && @job.save
        logger.debug 'SAVED!'
        flash[:success] = "Job details successfully saved!"

        if JobBoardMailer.confirmation_email(@job).deliver
          redirect_to @job #ask for confirmation key first before posting job
        end
      end
    end
  end

  def update
    @jobkey = @job.jobkey
    if !@jobkey.blank?
      @jobkey_confirmation = params[:job][:jobkey_confirmation].strip
      if @jobkey == @jobkey_confirmation
        @job.update_attribute(:jobkey_confirmation, @jobkey_confirmation)
        redirect_to @job
      else
        flash[:error] = "Job Key Error!"
        #render 'edit'
        render 'confirm'
      end
    end
  end

  def category
    logger.debug 'inside category'
    # @cat_id = Job.confirmed.find_all_by_category(@job.category)
    # @category = CATEGORY[@cat_id]
    @cat_id = CATEGORY.index(params[:name])
    @jobs = Job.confirmed.find_all_by_category(@cat_id)
    if @jobs.size == 0
      render 'static_pages/job_error'
    else
      @jobs = @jobs.paginate(:page => params[:page], :per_page => NUMBER_LIMIT)
    end
  end

  def preview
    logger.debug 'PREVIEW IS HERE'
    @job = session[:job]
  end

  def success
    logger.debug 'SUCCESS IS HERE'
  end

  def confirm
    logger.debug 'inside confirm'
    if params[:code]
      if @job.jobkey_confirmation.blank?
        @jobkey_confirmation = params[:code].strip
        if @jobkey_confirmation == @job.jobkey 
          if @job.update_attribute(:jobkey_confirmation, @jobkey_confirmation)
            flash.now[:success] = "Job post successfully confirmed!"
            render 'show'
          end
        else
          flash.now[:error] = "Job post not confirmed!"
          render 'error'
        end
      else
        flash.now[:error] = "Job post already confirmed!"
        render 'error'
      end
    else
      flash.now[:error] = "Job post code blank!"
      render 'error'
    end 
  end

  def search
    
  end

  private

    def signed_in_user
      logger.debug "inside signed_in_user"
      logger.debug signed_in?

      redirect_to root_url, flash: { error: "Action not allowed because you are not signed in." } unless signed_in?
    end
    
    def current_job
      logger.debug 'inside current_job'
      if params[:name] == nil # make sure that there is no :name parameter - used for category collection route
        @job = Job.find_by_id(params[:id])
        if @job == nil
          redirect_to root_url, flash: { error: "Invalid URL!" }
        end
      end
    end

    def check_for_cancel
      logger.debug 'inside check_for_cancel'
      if params[:commit] == "Cancel" || params[:commit] == "OK"
        redirect_to jobs_path
      end
    end

    def check_url_structure(url)
      logger.debug 'inside check_url_structure'
      /^https?/.match(url) ? url : "http://#{url}"
    end

    def clean_salary_format(salary)
      logger.debug 'inside clean_salary_format'
      if salary =~ /^[-+],?[0-9]*\.?[0-9]+$/
        salary.split('.')[0]
      end

      if salary.include?(',')
        salary.gsub!(',', '') if salary.is_a?(String)
      end
      salary.to_i
    end

    def create_key(length)
      logger.debug 'inside create_key'
      SecureRandom.hex(length)
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
