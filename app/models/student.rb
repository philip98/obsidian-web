class Student < ActiveRecord::Base
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :delete_all
	has_many :lent_books, :through => :lendings
	has_many :base_sets, :dependent => :delete_all

	validates :class_letter, :length => {:minimum => 0, :maximum => 1}
	validates :graduation_year, :numericality => {:greater_than => 2000}
	validates :name, :presence => true
	validates :school, :presence => true

	before_save {self.class_letter = class_letter.downcase}

	def lend_book(book)
		self.lendings.create(:book => book)
	end

	def return_book(book)
		self.lendings.find_by(:book => book).destroy
	end

	def lend_base_set(book)
		self.base_sets.create(:book => book)
	end

	def return_base_set(book)
		self.base_sets.find_by(:book => book).destroy
	end

	def Student.form_to_grad(form)
		if Time.current.mon >= 9
			13 + Time.current.year - form
		else
			12 + Time.current.year - form
		end
	end

	def Student.grad_to_form(grad)
		if Time.current.mon >= 9
			13 + Time.current.year - grad
		else
			12 + Time.current.year - grad
		end
	end

	def display_class
		"#{Student.grad_to_form(graduation_year)}#{class_letter}"
	end
end
