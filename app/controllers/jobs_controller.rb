class JobsController < ApplicationController
  #private methods are loaded
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
      params[:job][:company_website] = check_url_structure(params[:job][:company_website])
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
    @category = Job.confirmed.find_all_by_category(@job.category)
  end

  def preview
    logger.debug 'PREVIEW IS HERE'
    @job = session[:job]
  end

  def success
    logger.debug 'SUCCESS IS HERE'
  end

  def confirm
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
    def current_job
      @job = Job.find_by_id(params[:id])
      if @job == nil
        render 'static_pages/not_found'
      end
    end

    def check_for_cancel
      if params[:commit] == "Cancel" || params[:commit] == "OK"
        redirect_to jobs_path
      end
    end

    def check_url_structure(url)
      /^https?/.match(url) ? url : "http://#{url}"
    end

    def clean_salary_format(salary)
      if salary =~ /^[-+],?[0-9]*\.?[0-9]+$/
        salary.split('.')[0]
      end

      if salary.include?(',')
        salary.gsub!(',', '') if salary.is_a?(String)
      end
      salary.to_i
    end

    def create_key(length)
      SecureRandom.hex(length)
    end

    def search
      @word = params[:search]
      @search = 0
      if !@word.nil?
        if @word != "" || !@word.blank?
          @query = "%" + @word + "%"
          @results = Job.where(['(lower(jobtitle) LIKE ? OR lower(description) LIKE ? OR
                                lower(category) LIKE ? OR lower(company_name) LIKE ? OR
                                lower(location) LIKE ?) AND  isdeleted = 0', @query, @query, @query, @query, @query]).group_by { |job| job.category }
          @search = @results.length
        end
        render 'static_pages/search'
      end
    end
end
