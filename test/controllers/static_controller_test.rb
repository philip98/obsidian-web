require 'test_helper'

class StaticControllerTest < ActionController::TestCase
	test "should get home" do
		should_get :home
	end

	test "should get help" do
		should_get :help
	end

	test "should get about" do
		should_get :about
	end

	test "should get contact" do
		should_get :contact
	end
end
