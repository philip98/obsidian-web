class Book < ActiveRecord::Base
	belongs_to :school
	has_many :usages
	has_many :aliases
	has_many :base_sets
	has_many :lendings

	validates :title, :presence => true, :uniqueness => {:scope => :school}
	validates :isbn, :length => {:is => 13}, :presence => true, :uniqueness => {:scope => :school}
	validates :school, :presence => true
	validates :form, :presence => true
end
