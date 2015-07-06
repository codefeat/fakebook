class UsersController < ApplicationController

	def timeline
		@user = current_user
	end


end
