class BaseSetsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school

	def new

	end

	def create
		params[:isbns].each do |isbn|
			next if isbn.blank?
			next if !(book = book_lookup(isbn))
			begin
				@person.lend_base_set(book)
			rescue ActiveRecord::RecordNotUnique
				flash_message :danger, "#{book.display_title} wurde doppelt eingescannt"
			end
		end
		redirect_back_or show_class_url(@person.display_class)
	end

	def withdraw

	end

	def destroy
		params[:isbns].each do |isbn|
			next if isbn.blank?
			next if !(book = book_lookup(isbn))
			@person.return_base_set(book)
		end
		redirect_back_or show_class_url(@person.display_class)
	end

	private
		def correct_school
			@person = current_school.students.find_by(:id => params[:student_id])
			if !@person
				flash_message :notice, "Der Schüler konnte nicht gefunden werden"
				redirect_back_or students_url
			end
		end
end
