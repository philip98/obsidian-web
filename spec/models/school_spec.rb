require 'rails_helper'

RSpec.describe School, type: :model do
	it 'has a valid factory' do
		expect(build(:school)).to be_valid
	end

	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:encrypted_password)}

	it {should validate_uniqueness_of(:name)}
	it {should have_many(:students)}
	it {should have_many(:books)}
	it {should have_many(:teachers)}
	it {should have_many(:aliases)}

	it 'is automatically creates a authentication_token' do
		school = create(:school)
		expect(school.authentication_token).to be
		expect(school.authentication_token).not_to be_empty
		school.destroy
	end

	it 'automatically lower-cases its name' do
		school = create(:school, :name => 'MGM')
		expect(school.name).to eq('mgm')
		school.destroy
	end
end
