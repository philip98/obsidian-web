require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
	def setup
		@school = schools(:mgm)
		@other_school = schools(:test)
		@student = students(:philip)
	end

	test "should get index" do
		log_in_as(@school)
		should_get :index
	end

	test "should get show_class" do
		log_in_as(@school)
		should_get :show_class, :class => @student.display_class
	end

	test "should get show" do
		log_in_as(@school)
		should_get :show, :id => @student
	end

	test "should get new" do
		log_in_as(@school)
		should_get :new
	end

	test "should get edit" do
		log_in_as(@school)
		should_get :edit, :id => @student
	end

	test "should redirect when not logged in" do
		should_not_get :index
		should_not_get :show_class, :class => @student.display_class
		should_not_get :show, :id => @student
		should_not_get :new
		should_not_get :edit, :id => @student
		should_not_get :import, :class_letter => @student.class_letter, :graduation_year => @student.graduation_year
		should_not_get :destroy, :id => @student
	end

	test "should redirect when logged in as wrong school" do
		log_in_as(@other_school)
		should_not_get :show, :id => @student
		should_not_get :edit, :id => @student
		should_not_get :destroy, :id => @student
	end
end
