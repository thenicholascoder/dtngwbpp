class LikesController < ApplicationController
include LoggedInRestrictions
include SessionsHelper
  def create
    unless Like.exists?(liker_id: current_user.id, liked_id: params[:liked_id])
      @like = current_user.outgoing_likes.build(liked_id: params[:liked_id])
      if @like.save
        flash[:success] = "You have successfully liked the user."
      else
        flash[:error] = "Failed to like user."
      end
      @like.errors.full_messages
    else
      flash[:warning] = "You have already liked this user."
    end
    redirect_to root_path
  end
end
