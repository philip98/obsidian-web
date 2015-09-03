require 'rails_helper'

RSpec.describe Teacher, type: :model do
	it 'has a valid factory' do
		expect(create(:teacher)).to be_valid
	end

	it 'is invalid without name' do
		expect(build(:teacher, :name => nil)).not_to be_valid
	end

	it 'is invalid without school' do
		expect(build(:teacher, :school => nil)).not_to be_valid
	end
end
