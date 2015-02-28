class SchoolsController < ApplicationController
	def new
		@school = School.new
	end

	def create
		@school = School.new(school_params)
		if @school.save
			flash[:success] = "Willkommen!"
			redirect_to root_path
		else
			render "new"
		end
	end

	def edit

	end

	def update

	end

	def destroy

	end

	private
		def school_params
			params.require(:school).permit(:name, :password, :password_confirmation)
		end
end
