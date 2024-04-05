require "test_helper"

class Admin::UserManagerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_user_manager_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_user_manager_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_user_manager_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_user_manager_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_user_manager_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_user_manager_destroy_url
    assert_response :success
  end
end
