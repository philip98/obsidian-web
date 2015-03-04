class StudentsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:edit, :update, :show, :destroy]

	def index
		@students = current_school.students.order("graduation_year DESC", "class_letter").paginate(:page => params[:page])
	end

	def show_class
		graduation_year = Student.form_to_grad(params[:class].to_i)
		if params[:class][-1].match /[0..9]/
			class_letter = ""
		else
			class_letter = params[:class][-1].downcase
		end
		@students = current_school.students.where("graduation_year = ? AND class_letter = ?", graduation_year, 
			class_letter).paginate(:page => params[:page])
	end

	def show
		@student = Student.find(params[:id])
	end

	def new
		@student = Student.new
	end

	def create
		student = current_school.students.new(student_params)
		if student.save
			flash[:success] = "Schüler erfolgreich erstellt"
			redirect_to students_url
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
			flash[:success] = "Schülerdaten erfolgreich geändert"
			redirect_to students_url
		else
			render "edit"
		end
	end

	def destroy
		@student = current_school.students.find(params[:id])
		if @student.destroy
			flash[:success] = "Schüler erfolgreich gelöscht"
		else
			flash[:danger] = "Schüler konnte nicht gelöscht werden"
		end
		redirect_to students_url
	end

	def import

	end

	private
		def correct_school
			if not (student = Student.find_by(:id => params[:id]))
				flash[:danger] = "Schüler konnte nicht gefunden werden"
				redirect_to students_url
			elsif not current_school?(student.school)
				flash[:danger] = "Der Schüler ist kein Schüler dieser Schule"
				redirect_to students_url
			end
		end

		def student_params
			params.require(:student).permit(:name, :graduation_year, :class_letter)
		end
end
