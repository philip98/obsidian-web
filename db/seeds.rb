include StudentsHelper
s = School.create!(:name => "MGM", :password => "password", :password_confirmation => "password")
[5, 6, 7, 8, 9, 10].each do |form|
	['a', 'b', 'c', 'd', 'e', 'f'].each do |class_letter|
		s.students.create!(:name => Faker::Name.name, :graduation_year => form_to_grad(form),
			:class_letter => class_letter)
	end
end

[11, 12].each do |form|
	s.students.create!(:name => Faker::Name.name, :graduation_year => form_to_grad(form))
end

[5, 6, 7, 8, 9, 10, 12].each do |form|
	b = Book.create!(:title => "Lambacher Schweizer", :isbn => Faker::Code.ean, :form => "#{form}")
	s.usages.create!(:book => b)
end

s.students.each do |student|
	student.lend_base_set(Book.find_by(:title => "Lambacher Schweizer", :form => "9"))
	student.lend_book(Book.find_by(:title => "Lambacher Schweizer", :form => "10"))
end