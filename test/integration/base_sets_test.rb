require 'test_helper'

class BaseSetsTest < ActionDispatch::IntegrationTest
	def setup
		@school = schools(:mgm)
		@student = students(:philip)
		@book = books(:ls11)
	end

	test "unsuccessful lending" do
		log_in_as @school
		assert_no_difference "BaseSet.count" do
			get new_student_base_set_path(@student)
			post student_base_sets_path(@student), :isbns => ["0000", "", "abc"]
		end
		get new_student_base_set_path(@student)
		post student_base_sets_path(@student), :isbns => [@book.isbn]
		assert_no_difference "BaseSet.count" do
			get new_student_base_set_path(@student)
			post student_base_sets_path(@student), :isbns => [@book.isbn]
		end
	end

	test "unsuccessful withdrawal" do
		log_in_as @school
		assert_no_difference "BaseSet.count" do
			get withdraw_student_base_sets_path(@student)
			delete student_base_sets_path(@student), :isbns => ["0000", "", "abc", @book.isbn]
		end
	end

	test "successful lending and withdrawal" do
		log_in_as @school
		get new_student_base_set_path(:student_id => @student)
		assert_difference "BaseSet.count", 1 do
			post student_base_sets_path(:student_id => @student), :isbns => ["m11", "", @book.isbn]
		end
		get withdraw_student_base_sets_path(@student)
		assert_difference "BaseSet.count", -1 do
			delete student_base_sets_path(:student_id => @student), :isbns => ["m11", "", @book.isbn]
		end
	end
end
