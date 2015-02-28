require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
	def setup
		@school = schools(:mgm)
		@other_school = schools(:test)
	end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should redirect edit when not logged in" do
		get :edit, :id => @school
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect update when not logged in" do
		patch :update, :id => @school, :school => {:password => "password",
			:password_confirmation => "password"}
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_school)
		get :edit, :id => @school
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@other_school)
		patch :update, :id => @school, :school => {:password => "password",
			:password_confirmation => "password"}
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference "School.count" do
			delete :destroy, :id => @school
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when logged in as another user" do
		log_in_as(@other_school)
		assert_no_difference "School.count" do
			delete :destroy, :id => @school
		end
		assert_redirected_to root_url
	end
end
