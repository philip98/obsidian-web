require 'rails_helper'

RSpec.describe Lending, type: :model do
	it 'has a valid factory' do
		a = create(:school)
		b = create(:student, :school => a)
		c = create(:teacher, :school => a)
		d = create(:book, :school => a)
		expect(build(:lending, :person => b, :book => d)).to be_valid
		expect(build(:lending, :person => c, :book => d)).to be_valid
		d.destroy
		c.destroy
		b.destroy
		a.destroy
	end

	it {should validate_presence_of(:person)}
	it {should validate_presence_of(:book)}

	it {should belong_to(:book)}
	it {should belong_to(:person)}

	it 'requires the person\'s school to equal the book\'s school' do
		a = create :school
		b = create :school, :name => 'abc'
		c = create :student, :school => a
		d = create :teacher, :school => a
		e = create :book, :school => b
		expect(build(:lending, :person => c, :book => e)).not_to be_valid
		expect(build(:lending, :person => d, :book => e)).not_to be_valid
		e.destroy
		d.destroy
		c.destroy
		b.destroy
		a.destroy
	end

	it 'allows a person to lend a book multiple times' do
		a = create :school
		b = create :student, :school => a
		c = create :teacher, :school => a
		d = create :book, :school => a
		e = create :lending, :person => b, :book => d
		f = create :lending, :person => c, :book => d
		expect(build(:lending, :person => b, :book => d)).to be_valid
		expect(build(:lending, :person => c, :book => d)).to be_valid
		f.destroy
		e.destroy
		d.destroy
		c.destroy
		b.destroy
		a.destroy
	end
end
