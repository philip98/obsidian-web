class StudentsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:edit, :update, :show, :destroy]

	def index
		@students = current_school.students.order("graduation_year DESC", "class_letter").paginate(:page => params[:page])
		@forms = current_school.students.select(:graduation_year, :class_letter).order("graduation_year DESC", :class_letter)
			.distinct
		store_location
	end

	def show_class
		params[:list] ||= (Time.now.month >= 9) ? "new" : "old"
		@graduation_year = Student.form_to_grad(params[:class].to_i)
		if params[:class][-1].match /[0-9]/
			@data = current_school.students.where("graduation_year = ?", @graduation_year)
		else
			@class_letter = params[:class][-1].downcase
			@data = current_school.students.where("graduation_year = ? AND class_letter = ?", @graduation_year, 
				@class_letter)
		end
		@students = @data.order("name").paginate(:page => params[:page])
		@books_new = current_school.books.joins(:usages).where("usages.form LIKE ?", "%#{13+Time.now.year-@graduation_year}%")
		@books_old = current_school.books.joins(:usages).where("usages.form LIKE ?", "%#{12+Time.now.year-@graduation_year}%")
		if params[:list] == "old"
			@books = @books_old
		elsif params[:list] == "new"
			@books = @books_new
		end

		@bs = Hash.new
		@students.each do |student|
			@bs[student] = Hash.new
			student.base_sets.each do |base_set|
				@bs[student][base_set.book] = true
			end
		end
		store_location
		respond_to do |format|
			format.html
			format.text
			format.js
		end
	end

	def show
		@student = Student.find(params[:id])
		store_location
	end

	def new
		@student = Student.new(params.permit(:class_letter, :graduation_year))
	end

	def create
		student = current_school.students.new(student_params)
		if student.save
			flash_message :success, "Schüler erfolgreich erstellt"
			redirect_back_or students_url
		else
			render "new"
		end
	end

	def edit
		@student = current_school.students.find(params[:id])
	end

	def update
		@student = current_school.students.find(params[:id])
		if @student.update_attributes(student_params)
			flash_message :success, "Schülerdaten erfolgreich geändert"
			redirect_to students_url
		else
			render "edit"
		end
	end

	def destroy
		@student = current_school.students.find(params[:id])
		if @student.destroy
			flash_message :success, "Schüler erfolgreich gelöscht"
		else
			flash_message :danger, "Schüler konnte nicht gelöscht werden"
		end
		redirect_to students_url
	end

	def import
		@class_letter = params[:class_letter]
		@graduation_year = params[:graduation_year]
		respond_to do |format|
			format.js
			format.html
		end
	end

	def import_students
		if !params[:file]
			flash_message :danger, "Es wurde keine Datei angegeben"
		else
			c = Student.import(params[:file], (params[:graduation_year] if params[:graduation_year_ch]),
				(params[:class_letter] if params[:class_letter_ch]), current_school)
			if c == 1
				flash_message :success, "Es wurde ein Schüler importiert"
			elsif c.is_a?(String)
				flash_message :danger, c
			elsif c > 1
				flash_message :success, "Es wurden #{c} Schüler importiert"
			else
				flash_message :warning, "Es wurde kein Schüler importiert"
			end
		end
			
		redirect_back_or students_url
	end

	def query
		students = current_school.students.where("name LIKE ?", "#{params[:q]}%").limit(10)
		st = students.map do |s|
			{:name => s.name, :class => s.display_class, :url => student_url(s)}
		end
		respond_to do |format|
			format.json { render :json => st }
		end
	end

	def mass_edit
		redirect_back_or students_url unless ["graduation_year", "class_letter"].include?(params[:field])
		count = 0
		params[:ids].each do |id|
			count += 1 if (student = current_school.students.find_by(:id => id)) and 
				student.update(params[:field].to_sym => params[:value])
		end
		if count == 1
			flash_message :success, "Ein Schüler wurde geändert"
		elsif count > 1
			flash_message :success, "#{count} Schüler wurden geändert"
		else
			flash_message :warning, "Kein Schüler wurde geändert"
		end
		redirect_back_or students_url
	end

	private
		def correct_school
			if not (student = Student.find_by(:id => params[:id]))
				flash_message :danger, "Schüler konnte nicht gefunden werden"
				redirect_to students_url
			elsif not current_school?(student.school)
				flash_message :danger, "Der Schüler ist kein Schüler dieser Schule"
				redirect_to students_url
			end
		end

		def student_params
			params.require(:student).permit(:name, :graduation_year, :class_letter)
		end
end
