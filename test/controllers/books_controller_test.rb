require 'test_helper'

class BooksControllerTest < ActionController::TestCase
	def setup
		@school = schools(:mgm)
		@book = books(:ls11)
		@other_school = schools(:test)
	end

	test "should get index" do
		log_in_as(@school)
		should_get :index
	end

	test "should get show" do
		log_in_as(@school)
		should_get :show, :id => @book
	end

	test "should get new" do
		log_in_as(@school)
		should_get :new
	end

	test "should redirect when not logged in" do
		should_not_get :index
		should_not_get :show, :id => @book
		should_not_get :new
	end

	test "should redirect when logged in as wrong school" do
		log_in_as(@other_school)
		should_not_get :show, :id => @book
	end
end
