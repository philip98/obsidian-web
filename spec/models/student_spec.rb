require 'rails_helper'

RSpec.describe Student, type: :model do
	it 'has a valid factory' do
		expect(create(:student)).to be_valid
	end

	it 'is invalid without school' do
		expect(build(:student, :school => nil)).not_to be_valid
	end

	it 'is invalid without a name' do
		expect(build(:student, :name => nil)).not_to be_valid
	end

	it 'is invalid without a graduation_year' do
		expect(build(:student, :graduation_year => nil)).not_to be_valid
	end

	it 'is invalid with low graduation_year' do
		expect(build(:student, :graduation_year => 1999)).not_to be_valid
	end

	it 'is invalid with long class_letter' do
		expect(build(:student, :class_letter => 'abc')).not_to be_valid
	end

	it 'converts the class_letter to lower case' do
		expect(create(:student, :class_letter => 'A').class_letter).to eq('a')
	end
end
