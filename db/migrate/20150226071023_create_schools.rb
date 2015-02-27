class CreateSchools < ActiveRecord::Migration
	def change
		create_table :schools do |t|
			t.column :name, :string
			t.column :password_digest, :string

			t.timestamps null: false
		end
		add_index :schools, :name, :unique => true
	end
end
