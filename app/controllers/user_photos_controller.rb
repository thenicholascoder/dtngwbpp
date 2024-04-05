class UserPhotosController < ApplicationController
  include LoggedInRestrictions
  def delete
    @user_photo = UserPhoto.find(params[:id])
    @user_photo.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Photo successfully deleted."
  end
end
