class JobsController < ApplicationController
  before_filter :check_for_cancel, only: [:create, :update]

  def show
    @job = Job.find(params[:id])
  end
  
  def index
    @jobs_by_category = Job.find(:all).group_by { |job| job.category }
  end

  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:success] = "Job details successfully saved!"
      redirect_to @job
    else
      render 'new'
    end
  end

  def category
    @job = Job.find(params[:id])
    @category = Job.find_all_by_category(@job.category)
  end

  private
    def check_for_cancel
      if params[:commit] == "Cancel"
        redirect_to jobs_path
      end
    end
end
