class LendableResource < JSONAPI::Resource
	abstract
	has_many :lendings
end