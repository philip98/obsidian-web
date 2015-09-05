require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
	before :all do
		@a = create :school, :name => "TeachersController"
		@b = create :school, :name => "OtherSchool"
		@c = create :teacher, :school => @a
		@d = create :teacher, :school => @b
	end

	after :all do
		@d.destroy
		@c.destroy
		@b.destroy
		@a.destroy
	end

	before :each do
		allow(controller).to receive(:authenticate_from_token!)
		sign_in @a
	end

	after :each do
		sign_out @a
	end

	it 'is able to GET index' do
		get :index
		expect(response).to have_http_status(:ok)
	end

	it 'automatically scopes index to current school' do
		get :index
		body = JSON.parse(response.body)
		expect(body['data'].length).to eq(1)
		expect(body['data'][0]['id']).to eq(@c.id.to_s)
	end

	it 'is able to GET show' do
		get :show, :id => @c.id
		expect(response).to have_http_status(:ok)
	end

	it 'shows only authorised records' do
		get :show, :id => @d.id
		expect(response).to have_http_status(:not_found)
	end

	it 'is able to DELETE a record' do
		delete :destroy, :id => @c.id
		expect(response).to have_http_status(:no_content)
	end

	it 'destroys only authorised records' do
		delete :destroy, :id => @d.id
		expect(response).to have_http_status(:not_found)
	end
end
