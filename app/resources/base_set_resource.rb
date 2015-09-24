class BaseSetResource < BaseResource
	attributes :created_at

	has_one :student
	has_one :book

	filters :student_id, :book_id
end