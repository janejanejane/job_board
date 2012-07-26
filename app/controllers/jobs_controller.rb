class JobsController < ApplicationController
  def show
    @job = Job.find(params[:id])
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
end
