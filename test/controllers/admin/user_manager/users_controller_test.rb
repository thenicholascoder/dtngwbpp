require "test_helper"

class Admin::UserManager::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_user_manager_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_user_manager_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_user_manager_users_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_user_manager_users_destroy_url
    assert_response :success
  end
end
