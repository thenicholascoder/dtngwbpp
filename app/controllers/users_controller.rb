class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    uploaded_file = params[:user][:image]
    response = Cloudinary::Uploader.upload(uploaded_file)
    photo = Photo.new(link: response['secure_url'])
    photo.save

    if @user.save
      new_user_photo = UserPhoto.new(user_id: @user.id, photo_id: photo.id)
      new_user_photo.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Dating Web App!"
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
    flash[:success] = "User was successfully destroyed."
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :mobile, :email, :birthdate, :gender, :sexual_orientation, :gender_interest, :country, :state, :city, :school, :bio, :is_admin, :password, :password_confirmation)
    end
end
