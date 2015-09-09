require 'rails_helper'

RSpec.describe BooksController, type: :controller do
	before :all do
		School.destroy_all
		@a = create :school, :name => 'BooksController'
		@b = create :school, :name => 'Other'
		@c = create :book, :school => @a
		@d = create :book, :school => @b
	end

	after :all do
		Book.destroy_all
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
				:type => :books,
				:attributes => {
					:isbn => '8237682734683',
					:title => 'aasfh',
					:form => 8
				}
			}
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			post :create, data
			expect(@response).to have_http_status(:created)
		}.to change{Book.count}.by(1)
	end

	it 'is able to update a record' do
		data = {
			:data => {
				:type => :books,
				:id => @c.id,
				:attributes => {
					:form => 10
				}
			},
			:id => @c.id
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			patch :update, data
			expect(@response).to have_http_status(:ok)
			@c.reload
		}.to change{@c.form}
	end

	it 'is not able to update a different school\'s record' do
		data = {
			:data => {
				:type => :books,
				:id => @d.id,
				:attributes => {
					:title => 'sufdhksdf'
				}
			},
			:id => @d.id
		}
		@request.accept = 'application/vnd.api+json'
		@request.headers['Content-Type'] = 'application/vnd.api+json'
		expect{
			patch :update, data
			expect(@response).to have_http_status(:not_found)
			@d.reload
		}.not_to change{@d.title}
	end

	it 'is able to DELETE a record' do
		expect{
			delete :destroy, :id => @c.id
			expect(@response).to have_http_status(:no_content)
		}.to change{Book.count}.by(-1)
	end

	it 'destroys only authorised records' do
		expect{
			delete :destroy, :id => @d.id
			expect(@response).to have_http_status(:not_found)
		}.not_to change{Book.count}
	end
end
