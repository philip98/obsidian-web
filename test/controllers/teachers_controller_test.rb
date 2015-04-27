require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
	def setup
		@school = schools(:mgm)
		@other_school = schools(:test)
		@teacher = teachers(:one)
	end

	test "should get index" do
		log_in_as(@school)
		should_get :index
	end

	test "should get show" do
		log_in_as(@school)
		should_get :show, :id => @teacher
	end

	test "should get new" do
		log_in_as @school
		should_get :new
	end

	test "should get edit" do
		log_in_as @school
		should_get :edit, :id => @teacher
	end

	test "should redirect when not logged in" do
		should_not_get :index
		should_not_get :show, :id => @teacher
		should_not_get :new
		should_not_get :edit, :id => @teacher
		should_not_get :destroy, :id => @teacher
	end

	test "should redirect when logged in as wrong school" do
		log_in_as @other_school
		should_not_get :show, :id => @teacher
		should_not_get :edit, :id => @teacher
		should_not_get :destroy, :id => @teacher
	end
end
