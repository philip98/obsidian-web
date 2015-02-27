class CreateAliases < ActiveRecord::Migration
	def change
		create_table :aliases do |t|
			t.column :name, :string
			t.references :book
			t.references :school
		end
		add_index :aliases, [:school_id, :name]
		add_index :aliases, [:school_id, :book_id]
	end
end
