class ProfilesController < ApplicationController

	before_action :authorize_correct_user, :only => [:edit, :update]

	def edit
		@profile = User.find(params[:id]).profile
	end

	def update
		@profile = User.find(params[:id]).profile
		if @profile.update_attributes(profile_params)
			flash[:success] = "Profile updated successfully"
			redirect_to profile_path
		else
			flash[:error] = "Something happened"
			redirect_to edit_profile_path
		end
	end

	def show
		@user = User.find(params[:id])
		@profile = @user.profile
		@post = Post.new
		@posts = @user.posts
	end

private

	def profile_params
		params.require(:profile).permit(:location, :gender, :birthday, :avatar)
	end

end
