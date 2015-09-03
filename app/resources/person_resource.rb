class PersonResource < JSONAPI::Resource
	abstract
	has_many :lendings
end