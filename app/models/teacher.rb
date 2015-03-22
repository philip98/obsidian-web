class Teacher < ActiveRecord::Base
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :destroy
	has_many :books, :through => :lendings

	validates :name, :presence => true
	validates :school, :presence => true

	def lend_book(book)
		self.lendings.create(:book => book)
	end

	def return_book(book)
		self.lendings.find_by(:book => book).destroy
	end

	def lend_base_set(book)
	end

	def return_base_set(book)
	end
end
