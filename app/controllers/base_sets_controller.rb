class BaseSetsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school

	def new

	end

	def create
		books = params[:isbns].map{|isbn| book_lookup isbn}.compact
		doubles = books.select{|book| books.count(book) > 1}.uniq
		books = books.uniq
		
		doubles.each do |book|
			flash_message :danger, "#{display_title(book)} wurde doppelt eingescannt"
		end
		books.each do |book|
			begin
				@person.lend_base_set(book)
			rescue ActiveRecord::RecordNotUnique
				flash_message :danger, "#{display_title(book)} wurde bereits ausgegeben"
			end
		end
		redirect_back_or show_class_url(@person.display_class)
	end

	def withdraw

	end

	def destroy
		books = params[:isbns].map{|isbn| book_lookup isbn}.compact
		doubles = books.select{|book| books.count(book) > 1}.uniq
		books = books.uniq

		doubles.each do |book|
			flash_message :danger, "#{display_title(book)} wurde doppelt eingescannt"
		end
		books.each do |book|
			@person.return_base_set(book)
		end
		redirect_back_or show_class_url(@person.display_class)
	end

	private
		def correct_school
			@person = current_school.students.find_by(:id => params[:student_id])
			if !@person
				flash_message :danger, "Der Schüler konnte nicht gefunden werden"
				redirect_back_or students_url
			end
		end
end
