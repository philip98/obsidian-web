class BaseResource < JSONAPI::Resource
	abstract

	class << self
		def records(options = {})
			options[:context][:current_school].public_send(_model_name.tableize)
		end
	end
end