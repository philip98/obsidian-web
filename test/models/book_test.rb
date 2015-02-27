require 'test_helper'

class BookTest < ActiveSupport::TestCase
	def setup
		@book = books(:ls11)
	end

	test "title should be present" do
		@book.title = ""
		assert_not @book.valid?
	end

	test "form should be present" do
		@book.form = ""
		assert_not @book.valid?
	end
end
