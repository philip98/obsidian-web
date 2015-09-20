class ApplicationController < JSONAPI::ResourceController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session
	prepend_before_filter :authenticate_from_token!
#	before_filter :authenticate_school!
	@@current_school ||= nil

	def context
		{:current_school => current_school || @@current_school}
	end

	private
		def authenticate_from_token!
			logger.info "ApplicationController#authenticate_school_from_token!"
			authenticate_with_http_token do |token, options|
				secret_id = options[:secret_id]
				current_token = AuthenticationToken.find_authenticated :secret_id => secret_id, :secret => token
				if current_token
					sign_in current_token.school
					@@current_school = current_token.school
				else
					nil
				end
			end
			render :nothing => true, :status => :forbidden unless signed_in?
		end
end