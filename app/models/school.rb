class School < ActiveRecord::Base
	has_many :students
	has_many :teachers
	has_many :usages
	has_many :books
	has_many :aliases

	validates :name, :presence => true, :uniqueness => true

	has_secure_password
end