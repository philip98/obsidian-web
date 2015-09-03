class Student < ActiveRecord::Base
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :destroy
	has_many :lent_books, :through => :lendings
	has_many :base_sets

	validates :class_letter, :length => {:maximum => 1}
	validates :graduation_year, :numericality => {:greater_than => 2000}
	validates :graduation_year, :presence => true
	validates :name, :presence => true
	validates :school, :presence => true

	before_save {
		self.class_letter = class_letter.downcase if class_letter
	}
end
