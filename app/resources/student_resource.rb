class StudentResource < PersonResource
	attributes :name, :graduation_year, :class_letter
	
	has_many :base_sets

	filters :graduation_year, :class_letter
end
