module ApplicationHelper
	Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") }

	def full_title(page_title)
		base_title = "Jet blog"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

end
