require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
	context 'when logged in' do
		it 'is able to GET index' do
			school = create(:school, :name => 'StudentsController')
			@request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(school.authentication_token,
				:name => school.name)

			@request.env['HTTP_ACCEPT'] = 'application/json'
			@request.env['CONTENT_TYPE'] = 'application/json'
			get :index
			expect(response.status).to eq(200)
		end
	end

	context 'when not logged in' do
		it 'is not able to get index' do
			get :index, :format => :json
			expect(response.status).to eq(JSONAPI::FORBIDDEN)
		end
	end
end
