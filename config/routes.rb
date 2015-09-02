Rails.application.routes.draw do
	devise_for :schools, :controllers => {:sessions => "sessions"}
	root :to => redirect('docs')

	get "query" => "schools#query"
	get "about" => "static#about"
	get "contact" => "static#contact"
	get "help" => "static#help"
	get "signup" => "schools#new"
	get "login" => "sessions#new"
	post "login" => "sessions#create"
	delete "logout" => "sessions#destroy"
	get "students/class/:class" => "students#show_class", :as => "show_class"

	concern :lendable do 
		resources :lendings, :only => [:new, :create] do
			get :withdraw, :on => :collection
			delete :destroy, :on => :collection
		end
	end

	resources :schools, :only => [:new, :create, :edit, :update, :destroy]
	resources :students, :concerns => [:lendable] do
		resources :base_sets, :only => [:new, :create] do
			get :withdraw, :on => :collection
			delete :destroy, :on => :collection
		end

		collection do
			get :import, :action => :import
			post :import, :action => :import_students
			post :mass_edit
		end
	end

	resources :teachers, :concerns => [:lendable]

	resources :books, :only => [:show, :new, :create, :index, :destroy] do
		collection do
			get :lookup
		end
	end

	resources :aliases, :only => [:index, :new, :create, :destroy]
end
