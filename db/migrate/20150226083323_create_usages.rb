class CreateUsages < ActiveRecord::Migration
	def change
		create_table :usages do |t|
			t.references :school
			t.references :book
		end
		add_index :usages, [:school_id, :book_id], :unique => true
		add_index :usages, :school_id
		add_index :usages, :book_id
	end
end
