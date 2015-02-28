require 'test_helper'

class SchoolLoginTest < ActionDispatch::IntegrationTest
	def setup
		@school = schools(:mgm)
	end

	test "login with invalid information" do
		get login_path
		assert_template "sessions/new"
		post login_path, :session => {:name => "", :password => ""}
		assert_template "sessions/new"
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "login with valid information followed by logout" do
		get login_path
		post login_path, :session => {:school => @school.name, :password => "password"}
		assert is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_template "static/home"
		assert_select "a[href=?]", login_path, :count => 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", edit_school_path(@school)
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, :count => 0
		assert_select "a[href=?]", edit_school_path(@school), :count => 0
	end
end