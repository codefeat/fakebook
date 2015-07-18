class PostsController < ApplicationController
	before_action :correct_user, :only => [:destroy]
	
	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			flash[:success] = "Post successful"
		else
			flash[:error] = "Something went wrong"
		end
		redirect_to :back

	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Post deleted"
		redirect_to :back
	end
end

private

	def post_params
		params.require(:post).permit(:content)
	end

	def correct_user
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_url if @post.nil?
	end
