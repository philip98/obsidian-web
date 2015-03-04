class CreateAliases < ActiveRecord::Migration
	def change
		create_table :aliases do |t|
			t.string :name, :null => false
			t.references :book
			t.references :school
		end
		add_index :aliases, [:school_id, :name], :unique => true
		add_index :aliases, [:school_id, :book_id]
		add_foreign_key :aliases, :books, :dependent => :delete
		add_foreign_key :aliases, :schools, :dependent => :delete
	end
end
