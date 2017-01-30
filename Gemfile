source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 4.2.0'
gem 'puma'
gem 'bcrypt'
gem 'jsonapi-resources'
gem 'rspec-rails', '~> 3.3.0'
gem 'spring-commands-rspec', :platform => :ruby
gem 'devise'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
	gem 'byebug'
	gem 'sqlite3'
	gem 'spring', :platform => :ruby
	gem 'factory_girl_rails', '~> 4.5.0'
	gem 'shoulda-matchers'
end

group :production do
	gem 'mysql2'
end
