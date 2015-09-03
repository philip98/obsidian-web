class AliasResource < JSONAPI::Resource
	attribute :name

	has_one :book

	filter :name
end