class School < ActiveRecord::Base
	has_many :students, :dependent => :delete_all
	has_many :teachers, :dependent => :delete_all
	has_many :usages, :dependent => :delete_all
	has_many :books, :through => :usages
	has_many :aliases, :dependent => :delete_all

	validates :name, :presence => true, :uniqueness => true

	has_secure_password
end