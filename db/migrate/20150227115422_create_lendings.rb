class CreateLendings < ActiveRecord::Migration
	def change
		create_table :lendings do |t|
			t.references :person, :polymorphic => true, :index => true
			t.references :book

			t.timestamps null: false
		end
		add_index :lendings, :book_id
		add_foreign_key :lendings, :books, :dependent => :delete
	end
end
