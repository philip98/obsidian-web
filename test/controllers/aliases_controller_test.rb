require 'test_helper'

class AliasesControllerTest < ActionController::TestCase
	def setup
		@school = schools(:mgm)
	end

	test "should redirect when not logged in" do
		should_not_get :index
		should_not_get :new
	end

	test "should get index" do
		log_in_as(@school)
		should_get :index
	end

	test "should get new" do
		log_in_as(@school)
		should_get :new
	end
end
