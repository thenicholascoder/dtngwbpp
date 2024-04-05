class ProfilesController < ApplicationController
include LoggedInRestrictions
include SessionsHelper
  def show
    store_last_page
    @user = User.find(params[:id])
    @user_photos = UserPhoto.where(user_id: params[:id])
  end

  def index
  end

  def edit
    @user = User.find(params[:id])
    @user_photos = UserPhoto.where(user_id: params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:images] != [""]
      params[:user][:images].each do |image|
        if UserPhoto.where(user_id: params[:id]).count < 5
          next unless image.is_a?(ActionDispatch::Http::UploadedFile)
          cloudinary_upload = Cloudinary::Uploader.upload(image.tempfile, folder: "your_folder_name")
          photo = Photo.create(link: cloudinary_upload['secure_url'])
          user_photo = UserPhoto.create(user_id: params[:id], photo_id: photo.id)
        else
          flash[:danger] = "Maximum of 5 photos are allowed"
        end
      end
    end

    if @user.update(user_params)
      redirect_to profile_path
      flash[:success] = "Profile was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to retrieve_last_page_or_default
    flash[:success] = "Category was successfully destroyed."
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :mobile, :email, :birthdate, :gender, :sexual_orientation, :gender_interest, :country, :state, :city, :school, :bio, :is_admin, :password, :password_confirmation)
    end
end
