class Book < ActiveRecord::Base
	has_many :usages, :dependent => :delete_all
	has_many :aliases, :dependent => :delete_all
	has_many :base_sets, :dependent => :delete_all
	has_many :lendings, :dependent => :delete_all

	validates :title, :presence => true
	validates :form, :presence => true
	validates :isbn, :length => {:is => 13}, :presence => true, :uniqueness => true

	def used_by(school)
		school.books.exists(self)
	end

	def display_title
		title + form
	end
end
