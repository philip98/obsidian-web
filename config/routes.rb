Rails.application.routes.draw do
	devise_for :schools, :controllers => {:sessions => "sessions"}
	jsonapi_resources :students
	jsonapi_resources :teachers
	jsonapi_resources :books
end
