Rails.application.routes.draw do
	root "static#home"
	get "about" => "static#about"
	get "contact" => "static#contact"
	get "help" => "static#help"

	resources :schools, :only => [:new, :create, :edit, :update, :destroy]
end
