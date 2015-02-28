Rails.application.routes.draw do
	root "static#home"
	get "about" => "static#about"
	get "contact" => "static#contact"
	get "help" => "static#help"
	get "signup" => "schools#new"
	get "login" => "sessions#new"
	post "login" => "sessions#create"
	delete "logout" => "sessions#destroy"

	resources :schools, :only => [:new, :create, :edit, :update, :destroy]
	resources :students
end
