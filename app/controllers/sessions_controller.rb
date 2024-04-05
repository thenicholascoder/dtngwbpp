class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      puts "the value of params[:session][:remember_me] == '1' ? remember(user) : forget(user) is #{params[:session][:remember_me] == '1' ? remember(user) : forget(user)}"
      log_in user
      redirect_to root_path, turbolinks: false
      flash[:success] = 'Welcome to Dating Web App!'
    else
      # Create an error message.
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
    flash[:success] = "Logged out successfully."
  end
end
