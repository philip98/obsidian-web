class CreateTeachers < ActiveRecord::Migration
	def change
		create_table :teachers do |t|
			t.references :school
			t.column :name, :string

			t.timestamps null: false
		end
		add_index :teachers, :school_id
	end
end
