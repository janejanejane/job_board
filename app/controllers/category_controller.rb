class CategoryController < ApplicationController
 #  before_filter :search

	# def show
	# 	@cat_id = CATEGORY.index(params[:id])
 #    @jobs = Job.confirmed.find_all_by_category(@cat_id)
 #    if @jobs.size == 0
 #    	render 'static_pages/not_found'
 #    end
 #  end

	# private
	#   def search
	#     @word = params[:search]
	#     @search = 0
	#     if !@word.nil?
	#       if @word != "" || !@word.blank?
	#         @query = "%" + @word + "%"
	#         @results = Job.where(['lower(jobtitle) LIKE ? OR lower(description) LIKE ? OR
	#                               lower(company_name) LIKE ? OR lower(location) LIKE ? ', @query, @query, @query, @query])
	#         @grouped_results = @results.group_by { |job| job.category }
	#         @search = @results.length
	#       end
	#       render 'static_pages/search'
	#     end
 #  	end
end
