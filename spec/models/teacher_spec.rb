require 'rails_helper'

RSpec.describe Teacher, type: :model do
	it 'has a valid factory' do
		expect(build(:teacher)).to be_valid
	end

	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:school)}

	it {should belong_to(:school)}
	it {should have_many(:lendings)}
end
