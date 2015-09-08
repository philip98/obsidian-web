require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
	before :all do
		School.destroy_all
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

	it 'is able to create a record' do
		data = {
			:data => {
				:type => :teachers,
				:attributes => {
					:name => 'abcd'
				}
			}
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			post :create, data
			expect(@response).to have_http_status(:created)
		}.to change{Teacher.count}.by(1)
	end

	it 'is able to update a record' do
		data = {
			:data => {
				:type => :teachers,
				:id => @c.id,
				:attributes => {
					:name => 'asfbf'
				}
			},
			:id => @c.id
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		patch :update, data
		expect(@response).to have_http_status(:ok)
	end

	it 'is able to DELETE a record' do
		expect{
			delete :destroy, :id => @c.id
		}.to change{Teacher.count}.by(-1)
		expect(response).to have_http_status(:no_content)
	end

	it 'destroys only authorised records' do
		expect{
			delete :destroy, :id => @d.id
		}.not_to change{Teacher.count}
		expect(response).to have_http_status(:not_found)
	end
end
