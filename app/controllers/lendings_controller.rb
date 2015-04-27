class LendingsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school

	def new

	end

	def create
		books = params[:isbns].map{|isbn| book_lookup isbn}.compact
		books.each do |book|
			@person.lend_book(book)
		end

		if student?
			redirect_back_or student_url(@person)
		else
			redirect_back_or teacher_url(@person)
		end
	end

	def withdraw

	end

	def destroy
		books = params[:isbns].map{|isbn| book_lookup isbn}.compact
		books.each do |book|
			@person.return_book(book)
		end
		if student?
			redirect_back_or student_url(@person)
		else
			redirect_back_or teacher_url(@person)
		end
	end

	def student?
		params[:teacher_id].nil?
	end
	helper_method :student?

	private
		def correct_school
			if student?
				@person = current_school.students.find_by(:id => params[:student_id])
			else
				@person = current_school.teachers.find_by(:id => params[:teacher_id])
			end
			if not @person
				flash_message :danger, "Person nicht gefunden"
				redirect_to root_url
			end
		end
end
