require "test_helper"

class ResultControllerTest < ActionDispatch::IntegrationTest
  test "should get time" do
    get result_time_url
    assert_response :success
  end
end
