class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def flash_message type, text
		flash[type] ||= []
		flash[type] << text
	end

	def book_lookup isbn
		if (a = current_school.aliases.find_by(:name => isbn))
			a.book
		elsif (b = current_school.books.find_by(:isbn => isbn))
			b
		else
			nil
		end
	end

	def log_in school
		session[:school_id] = school.id
	end

	def log_out
		session.delete :school_id
	end

	def current_school
		@current_school ||= School.find_by(:id => session[:school_id])
	end

	def current_school? school
		school == current_school
	end

	def logged_in?
		!current_school.nil?
	end

	helper_method :logged_in?
	helper_method :current_school

	def logged_in_school
		unless logged_in?
			store_location
			flash_message :danger, "Bitte einloggen"
			redirect_to login_url
		end
	end

	def redirect_back_or default
		redirect_to(session[:forwarding_url] || default)
		session.delete :forwarding_url
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

	def display_title book
		"#{book.display_title current_school}"
	end

	def form book
		book.form current_school
	end
end
