class TeachersController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:show, :edit, :update, :destroy]

	def index
		@teachers = current_school.teachers.order("name").paginate(:page => params[:page])
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
