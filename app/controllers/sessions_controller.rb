class SessionsController < Devise::SessionsController
	respond_to :json
	skip_before_filter :verify_signed_out_user

	def new
	end

	def create
		self.resource = School.find_by_name(params['name'].downcase)
		unless resource && params['password'] && Devise::Encryptor.compare(Devise,
			resource.encrypted_password, params['password'])
			return failure
		end
		token = AuthenticationToken.create(:school => resource)
		AuthenticationToken.where('created_at < ?', 1.day.ago).destroy_all
		sign_in(resource_name, resource)
		data = {
			:token => token.secret,
			:secret_id => token.secret_id,
			:school_id => self.resource.id
		}
		render :json => data, :status => :created
	end

	def destroy
		token = ActionController::HttpAuthentication::Token.token_and_options(request)
		t = AuthenticationToken.find_authenticated :secret_id => token[1][:secret_id],
			:secret => token[0]
		t.destroy if t
		AuthenticationToken.where('created_at < ?', 1.day.ago).destroy_all
		render :nothing => true, :status => :ok and return
	end

	def failure
		warden.custom_failure!
		render :json => {:success => :false, :errors => ["Login credentials failed"]}, :status => 401 and return
	end
end
