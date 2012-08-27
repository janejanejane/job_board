class JobsController < ApplicationController
  before_filter :current_job, only: [:show, :preview, :update, :category, :confirmation]
  before_filter :check_for_cancel, only: [:create, :update]

  def show
    if @job.jobkey_confirmation.blank?
      render 'edit'
    end
  end
  
  def index
    #@jobs_by_category = Job.find(:all).group_by { |job| job.category }
    #@jobs_by_category = Job.find(:all, order: "created_at DESC").group_by { |job| job.category }
    @jobs_by_category = Job.confirmed(:all).group_by { |job| job.category }
  end

  def new
    if params[:job]
      @job = params[:job]
    else
      @job = Job.new
    end
  end
  
  def create
    params[:job][:company_website] = check_url_structure(params[:job][:company_website])
    params[:job][:salary] = clean_salary_format(params[:job][:salary])
    params[:job][:jobkey] = create_key(20)
    @job = Job.new(params[:job])
    if params[:preview] || !@job.save
      render 'preview'
    else
      flash[:success] = "Job details successfully saved!"
      redirect_to @job #ask for confirmation key first before posting job
    end
  end

  def edit

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
        render 'edit'
      end
    end
  end

  def category
    @category = Job.confirmed.find_all_by_category(@job.category)
  end

  def preview

  end

  private
    def current_job
      @job = Job.find(params[:id])
    end

    def check_for_cancel
      if params[:commit] == "Cancel"
        redirect_to jobs_path
      end
    end

    def check_url_structure(url)
      /^https?/.match(url) ? url : "http://#{url}"
    end

    def clean_salary_format(salary)
      if salary =~ /^[-+]?[0-9]*\.?[0-9]+$/
        salary.split(".")[0]
      end
    end

    def create_key(length)
      SecureRandom.hex(length)
    end
end
