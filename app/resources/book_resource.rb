class BookResource < BaseResource
	attributes :isbn, :title, :form

	has_many :aliases
	has_many :lendings
	has_many :base_sets
	has_one :school

	filters :form, :isbn
end