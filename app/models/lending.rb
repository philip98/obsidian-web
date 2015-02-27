class Lending < ActiveRecord::Base
	belongs_to :person, :polymorphic => true
	belongs_to :book

	validates :person, :presence => true
	validates :book, :presence => true
end
