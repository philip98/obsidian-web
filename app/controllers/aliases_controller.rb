class AliasesController < ApplicationController
	before_action :logged_in_school
	before_action :correct_school, :only => [:destroy]

	def index
		@aliases = current_school.aliases.order(:name).paginate(:page => params[:page])
		store_location
	end

	def new
		@isbn = params[:isbn]
		respond_to do |format|
			format.js
			format.html
		end
	end

	def create
		book = current_school.books.find_by(:id => params[:book_id]) ||
			current_school.books.find_by(:isbn => params[:isbn])
		@alias = current_school.aliases.new :name => params[:name], :book => book
		if @alias.save
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
			unless current_school.aliases.find_by(:id => params[:id])
				flash_message :danger, "Alias konnte nicht gefunden werden"
				redirect_to aliases_url
			end
		end
end
