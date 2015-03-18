class AliasesController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:destroy]

	def index
		@aliases = current_school.aliases.order(:name).paginate(:page => params[:page])
		store_location
	end

	def new
		@alias = Alias.new
		@alias.book = Book.new
		respond_to do |format|
			format.js
			format.html
		end
	end

	def create
		al = nil
		if params[:book_id]
			al = current_school.aliases.new(params.permit(:book_id, :name))
		elsif params[:alias]
			al = current_school.aliases.new(alias_params.merge(:school => current_school))
		end
		if al && al.save
			flash_message :success, "Alias erstellt"
			redirect_back_or aliases_path
		else
			render :new
		end
	end

	def destroy
		al = current_school.aliases.find_by(:id => params[:id])
		if !al
			flash_message :danger, "Der Alias konnte nicht gefunden werden"
		elsif !al.destroy
			flash_message :danger, "Der Alias konnte nicht gelöscht werden"
		else
			flash_message :success, "Der Alias wurde gelöscht"
		end
		redirect_to aliases_url
	end

	private
		def correct_school
			if !(al = Alias.find_by(:id => params[:id]))
				flash_message :danger, "Alias konnte nicht gefunden werden"
				redirect_to aliases_url
			elsif !current_school?(al.school)
				flash_message :danger, "Dieser Alias gehört zu einer anderen Schule"
				redirect_to aliases_url
			end
		end

		def alias_params
			params.require(:alias).permit(:name, :book_attributes => [:isbn])
		end
end
