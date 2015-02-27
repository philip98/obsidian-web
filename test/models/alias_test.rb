require 'test_helper'

class AliasTest < ActiveSupport::TestCase
	def setup
		@school = schools(:mgm)
		@other_school = schools(:test)
		@book = books(:ls11)
	end

	test "should be able to set alias" do
		assert @other_school.aliases.create(:book => @book, :name => "m11")
	end
end
