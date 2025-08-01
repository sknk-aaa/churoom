require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get root_url
    assert_response :redirect                 
    assert_redirected_to home_search_path 
  end
end
