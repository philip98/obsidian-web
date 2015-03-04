class CreateBaseSets < ActiveRecord::Migration
	def change
		create_table :base_sets do |t|
			t.references :student
			t.references :book

			t.timestamps null: false
		end
		add_index :base_sets, [:student_id, :book_id], :unique => true
		add_index :base_sets, :book_id
		add_index :base_sets, :student_id
		add_foreign_key :base_sets, :students, :dependent => :restrict
		add_foreign_key :base_sets, :books, :dependent => :delete
	end
end
