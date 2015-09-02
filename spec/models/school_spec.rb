require 'rails_helper'

RSpec.describe School, type: :model do
	it 'has a valid factory' do
		expect(create(:school)).to be_valid
	end

	it 'is invalid without name' do
		expect(build(:school, :name => nil)).not_to be_valid
	end

	it 'is invalid without unique name' do
		create(:school)
		expect(build(:school)).not_to be_valid
	end

	it 'is invalid without password' do
		expect(build(:school, :password => nil)).not_to be_valid
	end

	it 'is automatically creates a authentication_token' do
		expect(create(:school).authentication_token).not_to be_empty
	end

	it 'automatically lower-cases its name' do
		expect(create(:school, :name => 'MGM').name).to eq('mgm')
	end
end
