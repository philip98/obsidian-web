class Book < ActiveRecord::Base
	belongs_to :school
	has_many :usages
	has_many :aliases
	has_many :base_sets
	has_many :lendings

	validates :title, :presence => true
	validates :isbn, :length => {:is => 13}, :presence => true, :uniqueness => true
	validates :school, :presence => true
	validates :form, :presence => true
end
