class UsersController < ApplicationController
	
	def timeline
		@post = Post.new
		@user = current_user
		@posts = @user.posts
	end


end
