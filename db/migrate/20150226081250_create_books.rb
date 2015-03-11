class CreateBooks < ActiveRecord::Migration
	def change
		create_table :books do |t|
			t.string :isbn, :unique => true, :null => false
			t.string :title, :null => false

			t.timestamps null: false
		end
		add_index :books, :isbn
	end
end
