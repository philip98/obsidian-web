class BaseSetResource < JSONAPI::Resource
	attributes :created_at

	has_one :student
	has_one :book
end