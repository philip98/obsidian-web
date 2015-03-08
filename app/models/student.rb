class Student < ActiveRecord::Base
	include StudentsHelper
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :destroy
	has_many :lent_books, :through => :lendings
	has_many :base_sets

	validates :class_letter, :length => {:maximum => 1}
	validates :graduation_year, :numericality => {:greater_than => 2000}
	validates :name, :presence => true
	validates :school, :presence => true

	before_save {self.class_letter = class_letter.downcase if class_letter}

	def lend_book(book)
		if book
			self.lendings.create(:book => book)
		end
	end

	def return_book(book)
		if (b = self.lendings.find_by(:book => book))
			b.destroy
		end
	end

	def lend_base_set(book)
		if book
			self.base_sets.create(:book => book)
		end
	end

	def return_base_set(book)
		if (b = self.base_sets.find_by(:book => book))
			b.destroy
		end
	end

	def display_class
		"#{grad_to_form(graduation_year)}#{class_letter}"
	end
end
