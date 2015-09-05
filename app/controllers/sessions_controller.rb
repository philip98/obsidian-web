class SessionsController < Devise::SessionsController
	respond_to :json

	def create
		super do |school|
			token = AuthenticationToken.create(:school => school)
			data = {
				:token => token.secret
				:secret_id => token.secret_id
			}
			render :json => data, :status => 201 and return
		end
	end

	def destroy
		super do
			t = AuthenticationToken.find_by(:secret_id => ActionController::HttpAuthentication::Token.token_and_options(request)[1][:secret_id])
			t.destroy
			AuthenticationToken.where(:created_at < 1.day.ago).destroy_all
		end
	end
end