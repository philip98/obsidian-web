require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
	test "should get login" do
		should_get :new
	end
end
