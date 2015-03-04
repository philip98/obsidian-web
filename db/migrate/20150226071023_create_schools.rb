class CreateSchools < ActiveRecord::Migration
	def change
		create_table :schools do |t|
			t.string :name, :unique => true, :null => false 
			t.string :password_digest, :null => false

			t.timestamps null: false
		end
	end
end
