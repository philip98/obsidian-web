require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
	def setup
		@school = schools(:mgm)
	end

	test "school name should be present" do
		@school.name = ""
		assert_not @school.valid?
	end
end
