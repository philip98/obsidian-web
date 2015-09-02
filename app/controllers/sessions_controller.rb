class SessionsController < Devise::SessionsController
	respond_to :json

	def create
		super do |school|
			data = {
				:token => school.authentication_token,
				:name => school.name
			}
			render :json => data, :status => 201 and return
		end
	end
end