class Lending < ActiveRecord::Base
	belongs_to :person, :polymorphic => true
	belongs_to :book

	validates :person, :presence => true
	validates :book, :presence => true
	validate :used_by_school

	def used_by_school
		errors.add(:book, " wird nicht von der Schule verwendet") unless person and
			book and person.school == book.school
	end
end
