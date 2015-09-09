require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
	before :all do
		School.destroy_all
		@a = create :school
		@b = create :school, :name => 'aoghwekg'
	end

	after :all do
		School.destroy_all
	end

	before :each do
		allow(controller).to receive(:authenticate_from_token!)
		sign_in @a
	end

	after :each do
		sign_out @a
	end

	it 'is able to GET index (the current school)' do
		get :index
		body = JSON.parse(@response.body)
		expect(@response).to have_http_status(:ok)
		expect(body['data'].length).to eq(1)
		expect(body['data'][0]['id']).to eq(@a.id.to_s)
	end

	it 'is not able to GET a different school' do
		get :show, :id => @b.id
		expect(@response).to have_http_status(:not_found)
	end

	it 'is able to create a new school' do
		sign_out @a
		data = {
			:data => {
				:type => :schools,
				:attributes => {
					:name => 'hvufghskdfh',
					:password => 'password'
				}
			}
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			post :create, data
			expect(@response).to have_http_status(:created)
		}.to change{School.count}.by(1)
		@c = School.find(JSON.parse(@response.body)['data']['id'].to_i)
	end

	it 'is able to update the current school' do
		data = {
			:data => {
				:type => :schools,
				:id => @a.id,
				:attributes => {
					:name => 'sndgdsfj'
				}
			},
			:id => @a
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			patch :update, data
			expect(@response).to have_http_status(:ok)
			@a.reload
		}.to change{@a.name}
	end

	it 'is not able to update a different school' do
		data = {
			:data => {
				:type => :schools,
				:id => @b.id,
				:attributes => {
					:password => 'liisjflsd'
				}
			},
			:id => @b.id
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			patch :update, data
			expect(@response).to have_http_status(:not_found)
			@b.reload
		}.not_to change{@b.encrypted_password}
	end

	it 'is not able to destroy another school' do
		expect{
			delete :destroy, :id => @b.id
			expect(@response).to have_http_status(:not_found)
		}.not_to change{School.count}
	end

	it 'is able to DELETE the current school' do
		expect{
			delete :destroy, :id => @a.id
			expect(@response).to have_http_status(:no_content)
		}.to change{School.count}.by(-1)
	end
end
