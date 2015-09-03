require 'rails_helper'

RSpec.describe Book, type: :model do
	it 'has a valid factory' do
		expect(build(:book)).to be_valid
	end

	it {should validate_presence_of(:school)}
	it {should validate_presence_of(:isbn)}
	it {should validate_length_of(:isbn).is_equal_to(13)}
	it {should validate_presence_of(:title)}
	it {should validate_presence_of(:form)}

	it do
		create(:book)
		should validate_uniqueness_of(:isbn).scoped_to(:school_id)
	end

	it do
		create(:book)
		should validate_uniqueness_of(:title).scoped_to(:school_id)
	end

	it {should belong_to(:school)}
	it {should have_many(:lendings)}
	it {should have_many(:base_sets)}	
end
