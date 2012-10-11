class CategoryController < ApplicationController
	def show
		@category = params[:id]
    @jobs = Job.confirmed.find_all_by_category(@category)
    if @jobs.size == 0
    	render 'static_pages/not_found'
    end
  end
end
