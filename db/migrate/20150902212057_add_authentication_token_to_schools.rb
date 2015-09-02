class AddAuthenticationTokenToSchools < ActiveRecord::Migration
	def change
		add_column :schools, :authentication_token, :string
		rename_column :schools, :email, :name
	end
end
