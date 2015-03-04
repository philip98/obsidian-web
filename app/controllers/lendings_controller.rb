class LendingsController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school

	def new
		
	end

	def create

	end

	def remove

	end

	def destroy

	end

	private
		def correct_school

			if params[:type] == "students"
				@person = Student.find_by(:id => params[:id])
			else
				@person = Teacher.find_by(:id => params[:id])
			end
			if not @person
				flash[:danger] = "Person nicht gefunden"
				redirect_to root_url
			elsif not current_school? @person.school
				flash[:danger] = "Person wurde in dieser Schule nicht gefunden"
				redirect_to root_url
			end
		end
end
