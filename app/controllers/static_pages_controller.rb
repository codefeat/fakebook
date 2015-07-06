class StaticPagesController < ApplicationController
	skip_before_action :require_login
	def home
		if user_signed_in?
			redirect_to timeline_path
		end	
	end
	
end
