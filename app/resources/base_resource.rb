class BaseResource < JSONAPI::Resource
	abstract

	before_create :authorise!
	before_remove :authorise!
	before_update :authorise!

	def authorise!
		raise ForbiddenResource unless authorised?
	end

	def authorised?
		model and context and model.owner.id == context[:current_school].id
	end

	class << self
		def records(options = {})
			options[:context][:current_school].public_send(@_model_name.tableize)
		end
	end
end

class ForbiddenResource < JSONAPI::Exceptions::Error
	def errors
		[JSONAPI::Errors.new(:code => JSONAPI::FORBIDDEN,
				:status => :forbidden)]
	end
end