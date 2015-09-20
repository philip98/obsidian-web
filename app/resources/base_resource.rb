class BaseResource < JSONAPI::Resource
	abstract

	before_create do
		if @model.class.instance_methods.include? :school
			@model.school ||= context[:current_school]
			if @model.school != context[:current_school]
				fail JSONAPI::Exceptions::InvalidFieldValue('school', @model.school_id)
			end
		end	
	end

	class << self 
		def records(options = {})
			if options[:context][:current_school]
				options[:context][:current_school].public_send(_model_name.tableize)
			else
				_model_class.none
			end
		end
	end
end