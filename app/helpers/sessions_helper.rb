module SessionsHelper
	def log_in(school)
		session[:school_id] = school.id
	end

	def current_school
		@current_school ||= School.find_by(:id => session[:school_id])
	end

	def logged_in?
		!current_school.nil?
	end

	def log_out
		session.delete(:school_id)
		@current_school = nil
	end

	def logged_in_school
		unless logged_in?
			store_location
			flash_message :danger, "Bitte einloggen"
			redirect_to login_url
		end
	end

	def current_school?(school)
		school == current_school
	end

	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
end
