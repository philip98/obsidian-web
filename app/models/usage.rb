class Usage < ActiveRecord::Base
	belongs_to :school
	belongs_to :book

	validates :school, :presence => true
	validates :book, :presence => true
end
