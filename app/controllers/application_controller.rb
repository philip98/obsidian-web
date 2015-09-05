class ApplicationController < JSONAPI::ResourceController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :authenticate_school_from_token!
#	before_filter :authenticate_school!

	def context
		{:current_school => current_school}
	end

	private
		def authenticate_school_from_token!
			logger.info "ApplicationController#authenticate_school_from_token!"
			res = authenticate_with_http_token do |token, options|
				school_name = options[:name].presence
				logger.debug "school_name: #{school_name}"
				logger.debug "token: #{token}"
				school = school_name && School.find_by_name(school_name)

				if school && Devise.secure_compare(school.authentication_token, token)
					sign_in school, :store => false
				end
			end

			if res
				res
			else
				render :nothing => true, :status => :forbidden
			end
		end
end