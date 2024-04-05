class MatchesController < ApplicationController
include LoggedInRestrictions
include SessionsHelper
  def index
    store_last_page
    @matches = Like.where(liker_id: Like.where(liker_id: current_user.id).pluck(:liked_id), liked_id: current_user.id).paginate(page: params[:page]).per_page(10)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
