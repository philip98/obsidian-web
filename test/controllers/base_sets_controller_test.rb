require 'test_helper'

class BaseSetsControllerTest < ActionController::TestCase
	def setup
		@school = schools(:mgm)
		@other_school = schools(:test)
		@student = students(:philip)
	end

	test "should get new" do
		log_in_as @school
		should_get :new, :student_id => @student
	end

	test "should get withdraw" do
		log_in_as @school
		should_get :withdraw, :student_id => @student
	end

	test "should redirect when not logged in" do
		should_not_get :new, :student_id => @student
		should_not_get :withdraw, :student_id => @student
	end

	test "should redirect when logged in as wrong school" do
		log_in_as(@other_school)
		should_not_get :new, :student_id => @student
		should_not_get :withdraw, :student_id => @student
	end
end
