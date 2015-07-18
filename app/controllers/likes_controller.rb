class LikesController < ApplicationController
  def create
  	@like = Like.create(user_id: params[:user_id], likable_id: params[:likable_id],
  						likable_type: params[:likable_type])
  	if @like.save
  	else
  		flash[:warning] = "Something went wrong"
  	end
  	redirect_to :back
  end

  def destroy
  	@like = Like.find_by(id: params[:id])
  	@like.destroy
  	if @like.save
  	else
  		flash[:warning] = "Something went wrong"
  	end
  	redirect_to :back
  end

private


end
