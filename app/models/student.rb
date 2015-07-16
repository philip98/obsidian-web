class Student < ActiveRecord::Base
	require 'csv'
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :destroy
	has_many :lent_books, :through => :lendings
	has_many :base_sets

	validates :class_letter, :length => {:maximum => 1}
	validates :graduation_year, :numericality => {:greater_than => 2000}
	validates :name, :presence => true
	validates :school, :presence => true

	before_save {
		self.class_letter = class_letter.downcase if class_letter
	}

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

	def self.form_to_grad form
		if Time.current.mon >= 9
			13 + Time.current.year - form
		else
			12 + Time.current.year - form
		end
	end

	def self.grad_to_form grad
		if Time.current.mon >= 9
			13 + Time.current.year - grad
		else
			12 + Time.current.year - grad
		end
	end

	def display_class
		"#{Student.grad_to_form(graduation_year)}#{class_letter}"
	end

	def partially_free?
		!base_sets.any? do |bs| 
			!bs.book.form(school).include? Student.grad_to_form(graduation_year - 1).to_s
		end
	end

	def free?
		partially_free? && self.lendings.empty?
	end

	def self.import(file, graduation_year, class_letter, school)
		count = 0
		CSV.foreach(file.path, :col_sep => "\t", :headers => true) do |r|
			row = r.to_hash
			name = row["name"] || "#{row['nachname']} #{row['vorname']}" || next
			gr = graduation_year || row["abschlussjahr"] || next
			cl = class_letter || row["klassenbuchstabe"] || ""
			s = Student.new :name => name, :graduation_year => gr, :class_letter => cl, :school => school
			if s.save
				count += 1
			else
				return s.errors.full_messages.join("\n")
			end
		end
		return count
	end
end
