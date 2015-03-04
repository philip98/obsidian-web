class CreateStudents < ActiveRecord::Migration
	def change
		create_table :students do |t|
			t.references :school
			t.string :name, :null => false
			t.integer :graduation_year, :null => false
			t.string :class_letter, :string

			t.timestamps null: false
		end
		add_index :students, :school_id
		add_foreign_key :students, :schools, :dependent => :restrict
	end
end
