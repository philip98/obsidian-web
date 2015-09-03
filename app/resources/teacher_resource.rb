class TeacherResource < PersonResource
	attributes :name

	filter :name
end