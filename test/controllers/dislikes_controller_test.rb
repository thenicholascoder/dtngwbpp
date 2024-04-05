require "test_helper"

class DislikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get dislikes_create_url
    assert_response :success
  end
end
