class SchoolsController < ApplicationController
	before_action :logged_in_school, :only => [:edit, :update, :destroy]
	before_action :correct_school, :only => [:edit, :update, :destroy]

	def new
		@school = School.new
	end

	def create
		@school = School.new(school_params)
		if @school.save
			log_in @school
			flash_message :success, "Willkommen!"
			redirect_to root_url
		else
			render "new"
		end
	end

	def edit
		@school = School.find(params[:id])
	end

	def update
		@school = School.find(params[:id])
		if @school.update_attributes(params.require(:school).permit(:password,
			:password_confirmation))
			flash_message :success, "Passwort geändert"
			redirect_to root_url
		else
			render "edit"
		end
	end

	def destroy
		log_out
		School.find(params[:id]).destroy
		flash_message :success, "Schule gelöscht"
		redirect_to root_url
	end

	def query
		term = params[:term]
		books = current_school.books.where("title LIKE ?", "#{term}%").limit(10)
		result = books.map do |book|
			{:label => display_title(book), :value => book_url(book)}
		end
		students = current_school.students.where("name LIKE ?", "%#{term}%").limit(10)
		result += students.map do |student|
			{:label => "#{student.name} - #{student.display_class}", :value => student_url(student)}
		end
		teachers = current_school.teachers.where("name LIKE ?", "%#{term}%").limit(10)
		result += teachers.map do |teacher|
			{:label => teacher.name, :value => teacher_url(teacher)}
		end
		respond_to do |format|
			format.json {render :json => result}
		end
	end

	private
		def school_params
			params.require(:school).permit(:name, :password, :password_confirmation)
		end

		def correct_school
			@school = School.find(params[:id])
			redirect_to root_url unless current_school?(@school)
		end
end