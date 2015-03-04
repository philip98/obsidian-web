class StudentsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:edit, :update, :show, :destroy]

	def index
		@students = current_school.students.paginate(:page => params[:page])
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

	end

	def create

	end

	def edit

	end

	def update

	end

	def destroy

	end

	private
		def correct_school
			redirect_to home_url unless current_school?(Student.find(params[:id]).school)
		end
end
