class HomeController < ApplicationController
  include SessionsHelper

  def index
    if current_user
      likes = Like.where(liker: current_user.id).pluck(:liked_id)
      dislikes = Dislike.where(disliker: current_user.id).pluck(:disliked_id)
      judged_users = likes + dislikes
      judged_users_uniq = judged_users.uniq
      @filtered_user = User.where(gender: current_user.gender_interest).where.not(id: judged_users_uniq).order("RANDOM()").limit(1).first
    end
  end
end
