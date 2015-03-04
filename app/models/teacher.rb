class Teacher < ActiveRecord::Base
	belongs_to :school
	has_many :lendings, :as => :person
	has_many :books, :through => :lendings


	validates :name, :presence => true
	validates :school, :presence => true
end
