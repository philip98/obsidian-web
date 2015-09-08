class BaseResource < JSONAPI::Resource
	abstract

	before_create do
		@model.school ||= context[:current_school]
		if @model.school != context[:current_school]
			fail JSONAPI::Exceptions::InvalidFieldValue('school', @model.school_id)
		end		
	end

	class << self 
		def records(options = {})
			options[:context][:current_school].public_send(_model_name.tableize)
		end
	end
end