require 'test_helper'

class StudentTest < ActiveSupport::TestCase
	def setup
		@student = students(:philip)
	end

	test "graduation year should be greater than 2000" do
		@student.graduation_year = 1999
		assert_not @student.valid?
	end

	test "class letter should be blank or one letter" do
		@student.class_letter = "a"
		assert @student.valid?
		@student.class_letter = "ab"
		assert_not @student.valid?
		@student.class_letter = ""
		assert @student.valid?
	end

	test "name should be present" do
		@student.name = ""
		assert_not @student.valid?
	end

	test "school should exist" do
		@student.school_id = 5
		assert_not @student.valid?
	end
end
