class SchoolResource < JSONAPI::Resource
	attributes :name, :password

	def fetchable_fields
		super - [:password]
	end

	def sortable_fields context
		super - [:password]
	end

	def self.records options = {}
		Rails.logger.debug "options=#{options.inspect}"
		if options[:context][:current_school]
			Rails.logger.debug "current_school.id = #{options[:context][:current_school].id}"
			_model_class.where(:id => options[:context][:current_school].id)
		else
			Rails.logger.debug "None"
			School.none
		end
	end
end