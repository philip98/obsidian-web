class CreateStudents < ActiveRecord::Migration
	def change
		create_table :students do |t|
			t.references :school
			t.column :name, :string
			t.column :graduation_year, :integer
			t.column :class_letter, :string

			t.timestamps null: false
		end
		add_index :students, :school_id
	end
end
