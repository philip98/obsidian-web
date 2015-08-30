class DropUsages < ActiveRecord::Migration
	def change
		drop_table :usages
	end
end
