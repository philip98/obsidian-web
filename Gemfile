source 'https://rubygems.org'

gem 'rails', '~> 4.2.0'
gem 'puma'
gem 'jsonapi-resources', :git => 'https://github.com/cerebris/jsonapi-resources', :branch => 'master'
gem 'rspec_api_documentation'
gem 'apitome'
gem 'rspec-rails', '~> 3.3.0'
gem 'spring-commands-rspec', :platform => :ruby

group :development, :test do
	gem 'byebug'
	gem 'sqlite3'
	gem 'spring', :platform => :ruby
	gem 'factory_girl_rails', '~> 4.5.0'
end

group :production do
	gem 'rails_12factor'
	gem 'pg'
end