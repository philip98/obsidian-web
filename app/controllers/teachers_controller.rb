class TeachersController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:show, :edit, :update, :destroy]

	def index
		@teachers = current_school.teachers.order("name").paginate(:page => params[:page])
		store_location
	end

	def show
		store_location
	end

	def new
		@teacher = Teacher.new
	end

	def create
		teacher = current_school.teachers.new(params.require(:teacher).permit(:name))
		if teacher.save
			flash_message :success, "Lehrer erfolgreich erstellt"
			redirect_to teachers_url
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @teacher.update_attributes(params.require(:teacher).permit(:name))
			flash_message :success, "Lehrerdaten erfolgreich geändert"
			redirect_to teachers_url
		else
			render "edit"
		end
	end

	def destroy
		if @teacher.destroy
			flash_message :success, "Lehrer wurde erfolgreich gelöscht"
		else
			flash_message :danger, "Lehrer konnte nicht gelöscht werden"
		end
		redirect_to teachers_url
	end

	private
		def correct_school
			@teacher = current_school.teachers.find_by(:id => params[:id])
			if not @teacher
				flash_message :danger, "Der Lehrer wurde nicht gefunden"
				redirect_to teachers_url
			end
		end
end
