require 'test_helper'

class SchoolSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup information" do
		get new_school_path
		assert_no_difference "School.count" do
			post schools_path, :school => {:name => "", :password => "foo",
				:password_confirmation => "bar"}
		end
		assert_template "schools/new"
	end

	test "valid signup information" do
		get new_school_path
		assert_difference "School.count", 1 do
			post_via_redirect schools_path, :school => {:name => "Beispiel",
				:password => "password", :password_confirmation => "password"}
		end
		assert_template "static/home"
	end
end
