include ActionView::Helpers::NumberHelper

def full_title(page_title)
  base_title = "IGDA"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def php_salary(unformatted_salary)
	number_to_currency(unformatted_salary.to_s, unit: "PHP")
end

def format_date(date)
	if !date.nil?
	  I18n.localize(date, format: "%d %b")
	end
end
