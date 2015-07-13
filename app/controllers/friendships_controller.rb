class FriendshipsController < ApplicationController
	def create
		@friendship = Friendship.new(friendship_params)
		if @friendship.save
			flash[:success] = "Friend request sent!"
		else
			flash[:warning] = "Something went wrong"
		end
		redirect_to newsfeed_path
	end

private

	def friendship_params
		params.require(:friendship).permit(:requestee_id, :requestor_id)
	end
end
