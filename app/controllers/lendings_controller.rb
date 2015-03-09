class LendingsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school

	def new

	end

	def create
		params[:isbns].each do |isbn|
			@book = book_lookup(isbn)
			if params[:base_set]
				begin
					@person.lend_base_set(@book)
				rescue ActiveRecord::RecordNotUnique
					flash_message :warning, "#{@person.name} hat das Buch #{@book.display_title} schon bekommen"
				end
			else
				@person.lend_book(@book)
			end
		end
		if @person.is_a?(Student)
			redirect_to student_url(@person.id)
		elsif @person.is_a?(Teacher)
			redirect_to teacher_url(@person.id)
		end
	end

	def remove

	end

	def destroy
		params[:isbns].each do |isbn|
			if isbn.blank?
				next
			end
			@book = book_lookup(isbn)
			if params[:base_set]
				@person.return_base_set(@book)
			else
				@person.return_book(@book)
			end
		end
		if @person.is_a?(Student)
			redirect_to student_url(@person.id)
		elsif @person.is_a?(Teacher)
			redirect_to teacher_url(@person.id)
		end
	end

	private
		def correct_school
			if params[:type] == "students"
				@person = Student.find_by(:id => params[:id])
			elsif params[:type] == "teachers"
				@person = Teacher.find_by(:id => params[:id])
			else
				@person = nil
			end
			if not @person
				flash_message :danger, "Person nicht gefunden"
				redirect_to root_url
			elsif not current_school? @person.school
				flash_message :danger, "Person wurde in dieser Schule nicht gefunden"
				redirect_to root_url
			end
		end
end
