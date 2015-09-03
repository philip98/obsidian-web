class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :authenticate_school_from_token!
	before_filter :authenticate_school!

	private
		def authenticate_school_from_token!
			authenticate_with_http_token do |token, options|
				school_name = options[:name].presence
				school = school_name && School.find_by_name(school_name)

				if school && Devise.secure_compare(school.authentication_token, token)
					sign_in school, :store => false
				end
			end
		end
end