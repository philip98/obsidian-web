require 'test_helper'

class UsageTest < ActiveSupport::TestCase
	def setup
		@school = schools(:mgm)
		@other_school = schools(:test)
		@book = books(:ls11)
	end

	test "should be able to add book" do
		assert @other_school.usages.create(:book => @book)
	end
end
