FactoryGirl.define do
	factory :student, :class => 'Student' do
		name 'Philip Schlösser'
		school
		graduation_year '2016'
		class_letter ''
	end

end
