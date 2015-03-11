Rails.application.routes.draw do
	root "static#home"
	get "about" => "static#about"
	get "contact" => "static#contact"
	get "help" => "static#help"
	get "signup" => "schools#new"
	get "login" => "sessions#new"
	post "login" => "sessions#create"
	delete "logout" => "sessions#destroy"
	get "students/class/:class" => "students#show_class", :as => "show_class"
	get ":type/:id/lend" => "lendings#new", :as => "new_lending", :defaults => {:base_set => false}, 
		:type => /students|teachers/
	post ":type/:id/lend" => "lendings#create", :defaults => {:base_set => false},
		:type => /students|teachers/
	get ":type/:id/return" => "lendings#remove", :as => "delete_lending", :defaults => {:base_set => false},
		:type => /students|teachers/
	post ":type/:id/return" => "lendings#destroy", :defaults => {:base_set => false},
		:type => /students|teachers/
	get "students/:id/lend_base" => "lendings#new", :as => "new_base_lending", :defaults => {:base_set => true,
		:type => "students"}
	post "students/:id/lend_base" => "lendings#create", :defaults => {:base_set => true, :type => "students"}
	get "students/:id/return_base" => "lendings#remove", :as => "delete_base_lending", :defaults => {:base_set => true,
		:type => "students"}
	post "students/:id/return_base" => "lendings#destroy", :defaults => {:base_set => true, :type => "students"}
	get "books/lookup(.:format)" => "books#lookup", :as => "lookup_book"

	resources :schools, :only => [:new, :create, :edit, :update, :destroy]
	resources :students do
		collection do
			get :import
		end
	end
	resources :teachers
	resources :books, :only => [:new, :create, :index, :destroy] do
		collection do
			get :lookup
		end
	end
end
