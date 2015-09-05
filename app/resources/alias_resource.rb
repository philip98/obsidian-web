class AliasResource < BaseResource
	attribute :name

	has_one :book

	filter :name
end