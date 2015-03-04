class CreateTeachers < ActiveRecord::Migration
	def change
		create_table :teachers do |t|
			t.references :school
			t.string :name, :null => false

			t.timestamps null: false
		end
		add_index :teachers, :school_id
		add_foreign_key :teachers, :schools, :dependent => :restrict
	end
end
