class MessagesController < ApplicationController
  include LoggedInRestrictions
  include SessionsHelper
  before_action :set_users, only: [:show, :create]
  before_action :update_unread_messages, only: [:show, :create]

  def show
    store_last_page
    @message = Message.new
    @messages = Message.where(sender_id: [params[:user_id], current_user.id]).where(recipient_id: [params[:user_id], current_user.id]).order(created_at: :asc)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      redirect_to show_user_message_path(user_id: params[:user_id])
    else
      puts "message is saved and this is the error #{@message.errors.full_messages}"
      render :new
    end
  end

  def index
    store_last_page
    @matches = Like.where(liker_id: Like.where(liker_id: current_user.id).pluck(:liked_id), liked_id: current_user.id)
  end

  private

  def message_params
    params.require(:message).permit(:body, :recipient_id)
  end

  def set_users
    @users = User.where.not(id: current_user.id)
    @recipient = User.find(params[:recipient_id]) if params[:recipient_id]
  end

  def update_unread_messages
    Message.where(recipient_id: current_user.id).where(sender_id: params[:user_id]).update(seen: true)
  end
end
