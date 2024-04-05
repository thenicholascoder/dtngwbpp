require "test_helper"

class UserPhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get delete" do
    get user_photos_delete_url
    assert_response :success
  end
end
