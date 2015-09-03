require 'rails_helper'

RSpec.describe BaseSet, type: :model do
	it 'has a valid factory' do
		a = create :school
		b = create :book, :school => a
		c = create :student, :school => a
		expect(create(:base_set, :book => b, :student => c)).to be_valid
		c.destroy
		b.destroy
		a.destroy
	end

	it {should validate_presence_of(:student)}
	it {should validate_presence_of(:book)}

	it {should belong_to(:student)}
	it {should belong_to(:book)}

	it 'requires that the student have the same school as the student' do
		a = create :school
		b = create :school, :name => 'abc'
		c = create :book, :school => a
		d = create :student, :school => b
		expect(build(:base_set, :student => d, :book => c)).not_to be_valid
		d.destroy
		c.destroy
		b.destroy
		a.destroy
	end
end
