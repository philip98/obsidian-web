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

	def assert_redirect_and_flash
		assert_not (flash[:danger].nil? || flash[:danger].empty?)
		assert_response :redirect
	end

	def should_get(action, options=nil)
		get action, options
		assert (flash[:danger].nil? || flash[:danger].empty?)
		assert_response :success
	end

	def should_not_get(action, options=nil)
		get action, options
		assert_redirect_and_flash
	end

	private
		def integration_test?
			defined?(post_via_redirect)
		end
end
