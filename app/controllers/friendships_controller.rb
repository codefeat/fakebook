class FriendshipsController < ApplicationController

	before_action :authorize_is_requestee, only: [:accept, :destroy]

	def create
		@friendship = Friendship.new(friendship_params)
		if @friendship.save
			flash[:success] = "Friend request sent!"
		else
			flash[:warning] = "Something went wrong"
		end
		redirect_to newsfeed_path
	end

	def destroy
		@friendship = Friendship.find(params[:id])
		@friendship.destroy
		if @friendship.save
			flash[:success] = "Freind request deleted"
		else
			flash[:warning] = "Something went wrong"
		end
		redirect_to newsfeed_path
	end

	def accept
		@friendship = Friendship.find(params[:id])
		@friendship.accepted = true
		if @friendship.save
			flash[:success] = "Friend request accepted!"
		else
			flash[:warning] = "Something went wrong"
		end
		redirect_to notifications_path
	end

private

	def friendship_params
		params.require(:friendship).permit(:requestee_id, :requestor_id)
	end

	def authorize_is_requestee
		unless Friendship.find(params[:id]).requestee_id == current_user.id
			flash[:warning] = "You are unable to do that"
			redirect_to root_path
		end
	end

end
