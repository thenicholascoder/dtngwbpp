class Admin::UserManager::UsersController < ApplicationController
  include LoggedInRestrictions
  include AdminRestrictions

  def show
    @user = User.find_by(id: params[:id])
    @user_photos = UserPhoto.where(user_id: params[:id])
    @matches = Like.where(liker_id: Like.where(liker_id: current_user.id).pluck(:liked_id), liked_id: current_user.id).paginate(page: params[:page]).per_page(10)
  end

  def edit
    store_last_page
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
      redirect_to admin_user_manager_user_path
      flash[:success] = "Profile was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_manager_user_path
    flash[:success] = "User was successfully destroyed."
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :mobile, :email, :birthdate, :gender, :sexual_orientation, :gender_interest, :country, :state, :city, :school, :bio, :is_admin, :password, :password_confirmation)
    end
end
