class CreateBooks < ActiveRecord::Migration
	def change
		create_table :books do |t|
			t.column :isbn, :string
			t.column :title, :string
			t.column :form, :string

			t.timestamps null: false
		end
		add_index :books, :isbn, :unique => true
	end
end
