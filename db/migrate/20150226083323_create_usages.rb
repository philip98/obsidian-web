class CreateUsages < ActiveRecord::Migration
	def change
		create_table :usages do |t|
			t.references :school
			t.references :book

			t.string :form, :null => false
		end
		add_index :usages, [:school_id, :book_id], :unique => true
		add_index :usages, :school_id
		add_index :usages, :book_id
		add_foreign_key :usages, :schools, :dependent => :delete
		add_foreign_key :usages, :books, :dependent => :delete
	end
end
