class LendingResource < BaseResource
	attribute :created_at

	has_one :person, :polymorphic => true
	has_one :book

	filters :person, :book
end