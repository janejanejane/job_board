module JobsHelper
  def php_salary(unformatted_salary)
    number_to_currency(unformatted_salary.to_s, unit: "PHP")
  end

  def format_date(date)
    if !date.nil?
      I18n.localize(date, format: "%d %b")
    end
  end

  def current_category(job)
  	@category = job.category
  end
end
