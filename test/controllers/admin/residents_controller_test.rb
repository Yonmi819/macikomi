require "test_helper"

class Admin::ResidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_residents_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_residents_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_residents_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_residents_update_url
    assert_response :success
  end
end
