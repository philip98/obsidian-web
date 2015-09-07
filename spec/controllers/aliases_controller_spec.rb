require 'rails_helper'

RSpec.describe AliasesController, type: :controller do
	before :all do
		School.destroy_all
		@a = create :school, :name => 'AliasesController'
		@b = create :school, :name => 'otherSchool'
		@c = create :book, :school => @a
		@d = create :book, :school => @b
		@e = create :alias, :book => @c
		@f = create :alias, :book => @d
	end

	after :all do
		@f.destroy
		@e.destroy
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
		expect(body['data'][0]['id']).to eq(@e.id.to_s)
	end

	it 'is able to GET show' do
		get :show, :id => @e.id
		expect(response).to have_http_status(:ok)
	end

	it 'shows only authorised records' do
		get :show, :id => @f.id
		expect(response).to have_http_status(:not_found)
	end

	it 'is able to DELETE a record' do
		expect{
			delete :destroy, :id => @e.id
		}.to change{Alias.count}.by(-1)
		expect(response).to have_http_status(:no_content)
	end

	it 'destroys only authorised records' do
		expect{
			delete :destroy, :id => @f.id
		}.not_to change{Alias.count}
		expect(response).to have_http_status(:not_found)
	end
end
