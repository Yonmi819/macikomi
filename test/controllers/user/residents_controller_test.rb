require "test_helper"

class User::ResidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_residents_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_residents_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_residents_update_url
    assert_response :success
  end
end
