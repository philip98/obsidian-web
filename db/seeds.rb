s = School.create!(:name => "MGM", :password => "password", :password_confirmation => "password")
[5, 6, 7, 8, 9, 10].each do |form|
	['a', 'b', 'c', 'd', 'e', 'f'].each do |class_letter|
		s.students.create!(:name => Faker::Name.name, :graduation_year => form_to_grad(form),
			:class_letter => class_letter)
	end
end

[11, 12].each do |form|
	s.students.create!(:name => Faker::Name.name, :graduation_year => Student.form_to_grad(form), :class_letter => "")
end

[5, 6, 7, 8, 9, 10, 12].each do |form|
	b = Book.create!(:title => "Lambacher Schweizer", :isbn => Faker::Code.ean)
	s.usages.create!(:book => b, :form => "#{form}")
end

30.times do
	Teacher.create(:name => Faker::Name.name, :school => s)
end

s.students.each do |student|
	student.lend_base_set(s.usages.joins(:book).find_by(:form => "9", :books => {:title => "Lambacher Schweizer"}).book)
	student.lend_book(s.usages.joins(:book).find_by(:form => "10", :books => {:title => "Lambacher Schweizer"}).book)
end