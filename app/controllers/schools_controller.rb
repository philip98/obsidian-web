class SchoolsController < ApplicationController
	skip_before_action :authenticate_from_token!, :only => :create
end