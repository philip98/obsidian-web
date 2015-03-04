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
	get "students/import" => "students#import", :as => "import_students"
	get ":type/:id/lend" => "lendings#new", :as => "new_lending", :type => /students|teachers/
	post ":type/:id/lend" => "lendings#create", :as => "create_lending", :type => /students|teachers/
	get ":type/:id/return" => "lendings#remove", :as => "delete_lending", :type => /students|teachers/
	post ":type/:id/return" => "lendings#destroy", :as => "destroy_lending", :type => /students|teachers/
	get "/books/lookup(.:format)" => "books#lookup", :as => "lookup_book"

	resources :schools, :only => [:new, :create, :edit, :update, :destroy]
	resources :students
end
