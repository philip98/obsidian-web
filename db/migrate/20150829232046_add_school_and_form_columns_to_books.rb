class AddSchoolAndFormColumnsToBooks < ActiveRecord::Migration
	def change
		execute "DELETE FROM usages; DELETE FROM books;"
		change_table :books do |t|
			t.references :school
			t.string :form, :null => false, :default => ""
		end
		add_index :books, :school_id
		add_foreign_key :books, :schools, :dependent => :restrict
	end
end
