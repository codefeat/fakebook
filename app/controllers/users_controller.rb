class UsersController < ApplicationController
	
skip_before_action :require_login, :only => [:new, :create, :timeline]

	def timeline
		@user = current_user
	end

private

end
