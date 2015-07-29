class Book < ActiveRecord::Base
	has_many :usages
	has_many :aliases
	has_many :base_sets
	has_many :lendings

	validates :title, :presence => true
	validates :isbn, :length => {:is => 13}, :presence => true, :uniqueness => true

	def used_by school
		Usage.exists?(:school => school, :book => self)
	end
	
	def form school
		u = usages.find_by(:school => school)
		u.form if u
	end

	def display_title school
		if school && form(school)
			"#{self.title} (#{form school})"
		else
			""
		end
	end
end
