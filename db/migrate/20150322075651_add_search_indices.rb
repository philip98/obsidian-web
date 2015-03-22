class AddSearchIndices < ActiveRecord::Migration
	def change
		add_index :students, :name
		add_index :teachers, :name
		add_index :books, :title
	end
end
