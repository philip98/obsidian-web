class StudentsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:edit, :update, :show, :destroy]

	def index
		@students = current_school.students.paginate(:page => params[:page])
	end

	def show

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
end
