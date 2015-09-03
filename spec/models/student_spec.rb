require 'rails_helper'

RSpec.describe Student, type: :model do
	it 'has a valid factory' do
		expect(build(:student)).to be_valid
	end

	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:graduation_year)}
	it {should validate_numericality_of(:graduation_year).is_greater_than(2000)}
	it {should validate_presence_of(:school)}
	it {should validate_length_of(:class_letter).is_at_most(1)}
	it {should belong_to(:school)}
	it {should have_many(:lendings)}
	it {should have_many(:base_sets)}

	it 'converts the class_letter to lower case' do
		school = create(:student, :class_letter => 'A')
		expect(school.class_letter).to eq('a')
		school.destroy
	end
end
