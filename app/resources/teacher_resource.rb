class TeacherResource < PersonResource
	attributes :name

	filter :name

	has_one :school
end