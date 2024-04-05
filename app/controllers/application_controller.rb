class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_unread_messages_count
  helper_method :retrieve_last_page_or_default

  def store_last_page
    session[:last_page] = request.fullpath
  end

  def retrieve_last_page_or_default(default_path: root_path)
    session[:last_page] || default_path
  end

  private

  def set_unread_messages_count
    if current_user
      session[:unread_messages_count] = Message.where(recipient_id: current_user.id).where(seen: false).pluck(:sender_id).uniq.count
    else
      session[:unread_messages_count] = 0
    end
  end
end
