require "test_helper"

class ResultControllerTest < ActionDispatch::IntegrationTest
  test "should get time" do
    get results_time_url(day: "Mon", time: "1")
    assert_response :success
  end
end
