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
		Alias.destroy_all
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

	it 'is able to create a record' do
		data = {
			:data => {
				:type => :aliases,
				:attributes => {
					:name => 'ljwef',
				},
				:relationships => {
					:book => {
						:data => {
							:type => :books,
							:id => @c.id
						}
					}
				}
			}
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			post :create, data
			expect(@response).to have_http_status(:created)
		}.to change{Alias.count}.by(1)
	end

	it 'is able to update a record' do
		data = {
			:data => {
				:type => :aliases,
				:id => @e.id,
				:attributes => {
					:name => 'lefasefg'
				}
			},
			:id => @e.id
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			patch :update, data
			expect(@response).to have_http_status(:ok)
			@e.reload
		}.to change{@e.name}
	end

	it 'is not able to change a different school\'s record' do
		data = {
			:data => {
				:type => :aliases,
				:id => @f.id,
				:attributes => {
					:name => 'eosfijsflji'
				}
			},
			:id => @f.id
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			patch :update, data
			expect(@response).to have_http_status(:not_found)
			@f.reload
		}.not_to change{@f.name}
	end

	it 'is able to DELETE a record' do
		expect{
			delete :destroy, :id => @e.id
			expect(response).to have_http_status(:no_content)
		}.to change{Alias.count}.by(-1)
	end

	it 'destroys only authorised records' do
		expect{
			delete :destroy, :id => @f.id
			expect(response).to have_http_status(:not_found)
		}.not_to change{Alias.count}
	end
end
