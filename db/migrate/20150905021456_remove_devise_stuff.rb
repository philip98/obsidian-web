class RemoveDeviseStuff < ActiveRecord::Migration
	def change
		remove_column :schools, :reset_password_token, :string
		remove_column :schools, :reset_password_sent_at, :datetime
		remove_column :schools, :remember_created_at, :datetime
		remove_column :schools, :sign_in_count, :integer
		remove_column :schools, :current_sign_in_at, :datetime
		remove_column :schools, :last_sign_in_at, :datetime
		remove_column :schools, :current_sign_in_ip, :string
		remove_column :schools, :last_sign_in_ip, :string
		remove_column :schools, :authentication_token, :string
	end
end
