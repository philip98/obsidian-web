class Teacher < ActiveRecord::Base
	belongs_to :school
	has_many :lendings, :as => :person, :dependent => :delete_all
	has_many :books, :through => :lendings


	validates :name, :presence => true
	validates :school, :presence => true
end
