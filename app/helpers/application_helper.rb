module ApplicationHelper
	def full_title(page_title = "")
		base_title = "Obsidian Web"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def flash_message(type, text)
		flash[type] ||= []
		flash[type] << text
	end

	def render_flash
		rendered = []
		flash.each do |type, messages|
			messages.each do |m|
				rendered << render(:partial => "shared/flash", :locals => {:type => type, :message => m}) unless m.blank?
			end
		end
		rendered.join("").html_safe
	end
end
