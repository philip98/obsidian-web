ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
	fixtures :all

	def is_logged_in?
		!session[:school_id].nil?
	end

	def log_in_as(school)
		if integration_test?
			post login_path, :session => {:school => school.name, :password => "password"}
		else
			session[:school_id] = school.id
		end
	end

	private
		def integration_test?
			defined?(post_via_redirect)
		end
end
