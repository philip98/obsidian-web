require 'rails_helper'

RSpec.describe LendingsController, type: :controller do
	before :all do
		@a = create :school, :name => 'LendingsController'
		@b = create :school, :name => 'Otheradfad'
		@c = create :book, :school => @a
		@d = create :book, :school => @b
		@e = create :student, :school => @a
		@f = create :student, :school => @b
		@g = create :teacher, :school => @a
		@h = create :teacher, :school => @b
		@i = create :lending, :book => @c, :person => @e
		@j = create :lending, :book => @d, :person => @f
		@k = create :lending, :book => @c, :person => @g
		@l = create :lending, :book => @d, :person => @h
	end

	after :all do
		Lending.destroy_all
		Student.destroy_all
		Teacher.destroy_all
		School.destroy_all
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
		expect(@response).to have_http_status(:ok)
	end

	it 'automatically scopes index to current school' do
		get :index
		body = JSON.parse(@response.body)
		expect(body['data'].length).to eq(2)
		body['data'].each do |rec|
			expect([@i.id.to_s, @k.id.to_s]).to include(rec['id'])
		end
	end

	it 'is able to GET show' do
		get :show, :id => @i.id
		expect(@response).to have_http_status(:ok)
		get :show, :id => @k.id
		expect(@response).to have_http_status(:ok)
	end

	it 'shows only authorised records' do
		get :show, :id => @j.id
		expect(@response).to have_http_status(:not_found)
		get :show, :id => @l.id
		expect(@response).to have_http_status(:not_found)
	end

	it 'is able to DELETE records' do
		delete :destroy, :id => @i.id
		expect(@response).to have_http_status(:no_content)
		delete :destroy, :id => @k.id
		expect(@response).to have_http_status(:no_content)
	end

	it 'destroys only authorised records' do
		delete :destroy, :id => @j.id
		expect(@response).to have_http_status(:not_found)
		delete :destroy, :id => @l.id
		expect(@response).to have_http_status(:not_found)
	end
end
