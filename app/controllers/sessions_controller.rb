class SessionsController < ApplicationController
	def new

	end

	def create
		school = School.find_by(:name => params[:session][:school])
		if school && school.authenticate(params[:session][:password])
			log_in school
			redirect_back_or root_url
		else
			flash.now[:danger] = ["Ungültiges Passwort"]
			render "new"
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end
end