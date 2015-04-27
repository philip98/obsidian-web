require 'test_helper'

class LendingsTest < ActionDispatch::IntegrationTest
	def setup
		@student = students(:philip)
		@teacher = teachers(:one)
		@book = books(:ls11)
		@school = schools(:mgm)
	end

	test "unsuccessful lending" do
		log_in_as @school
		assert_no_difference "Lending.count" do
			get new_student_lending_path(@student)
			post student_lendings_path(@student), :isbns => ["0000", "", "656"]
			get new_teacher_lending_path(@teacher)
			post teacher_lendings_path(@teacher), :isbns => ["0000", "", "656"]
		end
	end

	test "unsuccessful withdrawal" do
		log_in_as @school
		assert_no_difference "Lending.count" do
			get withdraw_student_lendings_path(@student)
			delete student_lendings_path(@student), :isbns => ["0000", "", @book.isbn]
			get withdraw_teacher_lendings_path(@teacher)
			delete teacher_lendings_path(@teacher), :isbns => ["0000", "", @book.isbn]
		end
	end

	test "successful lending and withdrawal" do
		log_in_as @school
		get new_student_lending_path(:student_id => @student)
		assert_difference "Lending.count", 2 do
			post student_lendings_path(:student_id => @student), :isbns => ["m11", "", @book.isbn]
		end
		get new_teacher_lending_path(:teacher_id => @teacher)
		assert_difference "Lending.count", 2 do
			post teacher_lendings_path(:teacher_id => @teacher), :isbns => ["m11", "", @book.isbn]
		end
		get withdraw_student_lendings_path(@student)
		assert_difference "Lending.count", -2 do
			delete student_lendings_path(@student), :isbns => ["m11", "", @book.isbn]
		end
		get withdraw_teacher_lendings_path(@teacher)
		assert_difference "Lending.count", -2 do
			delete teacher_lendings_path(@teacher), :isbns => ["m11", "", @book.isbn]
		end
	end
end
