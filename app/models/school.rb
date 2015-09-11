class School < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable
	has_many :students
	has_many :teachers
	has_many :usages
	has_many :books
	has_many :aliases, :through => :books
	has_many :base_sets, :through => :books
	has_many :lendings, :through => :books

	validates :name, :presence => true, :uniqueness => true
	validates :encrypted_password, :presence => true

	alias :school_id :id
	alias :school_id= :id=
end