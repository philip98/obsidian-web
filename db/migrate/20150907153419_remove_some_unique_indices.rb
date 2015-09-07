class RemoveSomeUniqueIndices < ActiveRecord::Migration
	def change
		remove_index :aliases, :name => 'index_aliases_on_school_id_and_name'
		remove_index :schools, :name => 'index_schools_on_name'
	end
end
