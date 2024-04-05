class DislikesController < ApplicationController
include LoggedInRestrictions
include SessionsHelper
  def create
    unless Dislike.exists?(disliker_id: current_user.id, disliked_id: params[:disliked_id])
      @dislike = current_user.outgoing_dislikes.build(disliked_id: params[:disliked_id])
      if @dislike.save
        flash[:success] = "You have successfully disliked the user."
      else
        flash[:error] = "Failed to dislike user."
      end
      @dislike.errors.full_messages
    else
      flash[:warning] = "You have already disliked this user."
    end
    redirect_to root_path
  end
end
