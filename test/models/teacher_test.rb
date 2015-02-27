require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
	def setup
		@teacher = teachers(:one)
	end

	test "name should be present" do
		@teacher.name = ""
		assert_not @teacher.valid?
	end

	test "school should exist" do
		@teacher.school_id = 5
		assert_not @teacher.valid?
	end
end
