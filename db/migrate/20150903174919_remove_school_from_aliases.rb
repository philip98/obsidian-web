class RemoveSchoolFromAliases < ActiveRecord::Migration
	def change
		remove_column :aliases, :school_id
	end
end
