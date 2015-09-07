require 'rails_helper'

RSpec.describe BaseSetsController, type: :controller do
	before :all do
		School.delete_all
		@a = create :school, :name => 'BaseSetsController'
		@b = create :school, :name => 'OtherSchool'
		@c = create :student, :school => @a
		@d = create :student, :school => @b
		@e = create :book, :school => @a
		@f = create :book, :school => @b
		@g = create :base_set, :student => @c, :book => @e
		@h = create :base_set, :student => @d, :book => @f
	end

	after :all do
		@h.destroy
		@g.destroy
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
		expect(body['data'][0]['id']).to eq(@g.id.to_s)
	end

	it 'is able to GET show' do
		get :show, :id => @g.id
		expect(response).to have_http_status(:ok)
	end

	it 'shows only authorised records' do
		get :show, :id => @h.id
		expect(response).to have_http_status(:not_found)
	end

	it 'is able to DELETE records' do
		expect{
			delete :destroy, :id => @g.id
		}.to change{BaseSet.count}.by(-1)
		expect(response).to have_http_status(:no_content)
	end

	it 'destroys only authorised records' do
		expect{
			delete :destroy, :id => @h.id
		}.not_to change{BaseSet.count}
		expect(response).to have_http_status(:not_found)
	end
end
