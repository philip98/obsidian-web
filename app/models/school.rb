class School < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :students
	has_many :teachers
	has_many :usages
	has_many :books
	has_many :aliases

	validates :name, :presence => true, :uniqueness => true
end