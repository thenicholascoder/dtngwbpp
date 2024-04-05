class Admin::MatchesManagerController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def index
    @users = User.paginate(page: params[:page]).per_page(10)
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
