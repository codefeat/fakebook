class PostsController < ApplicationController
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
		redirect_to timeline_path

	end
end

private

def post_params
	params.require(:post).permit(:content)
end