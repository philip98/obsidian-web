class Usage < ActiveRecord::Base
	belongs_to :school
	belongs_to :book

	validates :school, :presence => true
	validates :book, :presence => true
	validates :form, :presence => true

	def display_form
		"#{book.title} #{form}"
	end
end
