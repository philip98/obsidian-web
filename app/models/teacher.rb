class Teacher < ActiveRecord::Base
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :destroy
	has_many :books, :through => :lendings

	validates :name, :presence => true
	validates :school, :presence => true

	def owner
		school
	end
end
