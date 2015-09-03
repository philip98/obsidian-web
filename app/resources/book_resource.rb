class BookResource < JSONAPI::Resource
	attributes :isbn, :title, :form

	has_many :aliases
	has_many :lendings
	has_many :base_sets

	filter :form
end