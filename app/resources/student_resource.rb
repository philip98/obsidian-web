class StudentResource < PersonResource
	attributes :name, :graduation_year, :class_letter
	
	has_many :base_sets
	has_one :school

	filters :graduation_year, :class_letter
end