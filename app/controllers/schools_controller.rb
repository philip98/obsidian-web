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
			flash[:success] = "Willkommen!"
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
			flash[:success] = "Passwort geändert"
			redirect_to root_url
		else
			render "edit"
		end
	end

	def destroy
		log_out
		School.find(params[:id]).destroy
		flash[:success] = "Schule gelöscht"
		redirect_to root_url
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