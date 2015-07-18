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

	def notifications
		@user = current_user
		@notifications = @user.notifications
	end

	def friend_list
		@user = current_user
		@friends = current_user.get_friends
	end
end
