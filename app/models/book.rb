class Book < ActiveRecord::Base
	has_many :usages
	has_many :aliases
	has_many :base_sets
	has_many :lendings

	validates :title, :presence => true
	validates :form, :presence => true
	validates :isbn, :length => {:is => 13}, :presence => true, :uniqueness => true

	def used_by(school)
		Usage.exists?(:school => school, :book => self)
	end

	def display_title
		"#{title} #{form}"
	end
end
