FactoryGirl.define do
	factory :school do
		name 'MGM'
		password_digest {BCrypt::Password.create('password')}
	end

end
