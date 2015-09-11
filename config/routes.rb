Rails.application.routes.draw do
	devise_for :schools, :skip => [:registrations, :confirmations], :controllers => {:sessions => 'sessions'}
	jsonapi_resources :schools
	jsonapi_resources :students
	jsonapi_resources :teachers
	jsonapi_resources :books
	jsonapi_resources :aliases
	jsonapi_resources :lendings
	jsonapi_resources :base_sets
end
