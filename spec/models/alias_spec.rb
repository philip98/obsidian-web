require 'rails_helper'

RSpec.describe Alias, type: :model do
	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:book)}

	it {should belong_to(:book)}

	it 'is invalid when the name is not unique within its school' do
		a = create :alias
		b = create :school, :name => 'abc'
		c = create :book, :school => b
		expect(build(:alias, :book => a.book, :name => a.name)).not_to be_valid
		expect(build(:alias, :book => c, :name => a.name)).to be_valid
		c.destroy
		b.destroy
		a.destroy
	end
end
