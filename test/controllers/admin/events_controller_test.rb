require "test_helper"

class Admin::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_events_new_url
    assert_response :success
  end
end
