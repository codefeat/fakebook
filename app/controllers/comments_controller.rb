class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.create(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "Comment added"
		else
			flash[:error] = "Something happened."
		end
		redirect_to newsfeed_path
	end

private

	def comment_params
		params.require(:comment).permit(:content, :post_id)
	end
end
