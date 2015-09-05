class Alias < ActiveRecord::Base
	belongs_to :book

	validates :name, :presence => true
	validates :book, :presence => true
	validate :unique_within_school?

	before_create {self.name = name.downcase}

	def unique_within_school?
		errors.add(:alias, "already exists in that school") if book and book.school and book.school.aliases.find_by_name(name)
	end

	def owner
		book.school
	end
end
