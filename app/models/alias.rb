class Alias < ActiveRecord::Base
	belongs_to :school
	belongs_to :book

	validates :name, :presence => true
	validates :book, :presence => true
	validates :school, :presence => true

	before_create {self.name = name.downcase}
end
