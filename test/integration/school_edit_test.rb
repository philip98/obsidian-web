require 'test_helper'

class SchoolEditTest < ActionDispatch::IntegrationTest
	def setup
		@school = schools(:mgm)
	end

	test "unsuccessful edit" do
		log_in_as(@school)
		get edit_school_path(@school)
		assert_template "schools/edit"
		patch school_path(@school), :school => {:password => "foo",
			:password_confirmation => "bar"}
		assert_template "schools/edit"
	end

	test "successful edit with friendly forwarding" do
		get edit_school_path(@school)
		log_in_as(@school)
		assert_redirected_to edit_school_path(@school)
		patch school_path(@school), :school => {:password => "password",
			:password_confirmation => "password"}
		assert_not flash.empty?
		assert_redirected_to root_url
		@school.reload
		assert @school.authenticate("password")
	end
end
