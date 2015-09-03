class BaseSet < ActiveRecord::Base
	belongs_to :student
	belongs_to :book

	validates :student, :presence => true
	validates :book, :presence => true
	validate :used_by_school

	def used_by_school
		errors.add(:book, "wird nicht von der Schule verwendet") unless book and
			student and book.school == student.school
	end
end
