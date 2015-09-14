class SessionsController < Devise::SessionsController
	respond_to :json
	prepend_before_filter :require_no_authentication, :only => :create

	def new
	end

	def create
		respond_to do |format|
			format.json do
				logger.debug "name: #{params['name']}"
				logger.debug "pw: #{params['password']}"
				self.resource = School.find_by_name(params['name'])
				unless resource && params['password'] && Devise::Encryptor.compare(Devise, 
					resource.encrypted_password, params['password'])
					return failure
				end
				token = AuthenticationToken.create(:school => resource)
				sign_in(resource_name, resource)
				data = {
					:token => token.secret,
					:secret_id => token.secret_id,
					:school_id => self.resource.id
				}
				render :json => data, :status => :created
			end
		end
	end

	def destroy
		super do
			t = AuthenticationToken.find_by(:secret_id => ActionController::HttpAuthentication::Token.token_and_options(request)[1][:secret_id])
			t.destroy if t
			AuthenticationToken.where('created_at < ?', 1.day.ago).destroy_all
			render :nothing => true, :status => :ok and return
		end
	end

	def failure
		warden.custom_failure!
		render :json => {:success => :false, :errors => ["Login credentials failed"]}, :status => 401 and return
	end
end