require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	before :all do
		@a = create :school, :name => 'asdf'
	end

	after :all do
		@a.destroy
	end

	it 'is able to log in with correct password' do
		@request.env["devise.mapping"] = Devise.mappings[:school]
		expect{
			post :create, :name => @a.name, :password => 'password', :format => :json
			expect(@response).to have_http_status(:created)
		}.to change{AuthenticationToken.count}.by(1)
		body = JSON.parse(@response.body)
		token = AuthenticationToken.find_authenticated(:secret_id => body['secret_id'],
			:secret => body['token'])
		expect(token).to be_truthy
	end

	it 'is not able to log in with incorrect password' do
		@request.env["devise.mapping"] = Devise.mappings[:school]
		expect{
			post :create, :name => @a.name, :password => 'lasjkflas', :format => :json
			expect(@response).to have_http_status(401)
		}.not_to change{AuthenticationToken.count}
	end

	it 'is able to log out' do
		@request.env["devise.mapping"] = Devise.mappings[:school]
		sign_in @a
		b = AuthenticationToken.create(:school => @a)
		@request.headers['Authorization'] = ActionController::HttpAuthentication::Token.encode_credentials(b.secret, 
			:secret_id => b.secret_id)
		expect{
			delete :destroy
			expect(@response).to have_http_status(:ok)
		}.to change{AuthenticationToken.count}.by(-1)
	end
end
