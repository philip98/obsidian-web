require 'test_helper'

class StudentEditTest < ActionDispatch::IntegrationTest
	def setup
		@school = schools(:mgm)
		@student = students(:philip)
	end

	test "unsuccessful edit" do
		log_in_as @school
		get edit_student_path(@student)
		assert_template "students/edit"
		patch student_path(@student), :student => {:class_letter => "abc"}
		assert_template "students/edit"
	end

	test "unsuccessful mass edit" do
		log_in_as @school
		get show_class_path(@student.display_class)
		assert_template "students/show_class"
		post mass_edit_students_path, :ids => [@student], :field => "class_letter", :value => "abc"
		assert_not (flash[:warning].nil? || flash[:warning].empty?)
	end

	test "successful mass edit" do
		log_in_as @school
		get show_class_path(@student.display_class)
		assert_template "students/show_class"
		post mass_edit_students_path, :ids => [@student], :field => "graduation_year", :value => "2015"
		assert_not flash.empty?
	end

	test "successful edit" do
		log_in_as @school
		get edit_student_path(@student)
		assert_template "students/edit"
		patch student_path(@student), :student => {:graduation_year => 2015}
		assert_not (flash[:success].nil? || flash[:success].empty?)
	end
end
