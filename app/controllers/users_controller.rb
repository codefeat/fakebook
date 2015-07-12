class UsersController < ApplicationController
	
	def index
  		@users = User.all
  		@user = current_user
  		@post = Post.new
  	end

	def newsfeed
		@post = Post.new
		@user = current_user
		@posts = @user.posts
	end


end
