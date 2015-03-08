class BooksController < ApplicationController
	def lookup
		@book = book_lookup(params[:b])
		@field = params[:a]
		respond_to do |format|
			format.js
		end
	end
end
