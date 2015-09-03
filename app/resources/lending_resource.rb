class LendingResource < JSONAPI::Resource
	attribute :created_at

	has_one :lendable, :polymorphic => true
	has_one :book
end