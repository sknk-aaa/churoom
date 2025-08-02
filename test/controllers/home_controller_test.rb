require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include ActiveSupport::Testing::TimeHelpers

  test "時間外は検索画面へリダイレクトされること" do
    travel_to Time.zone.local(2025, 8, 4, 7, 0, 0) do
      get root_path
      assert_redirected_to home_search_path
    end
  end

  test "授業時間内は結果ページへリダイレクトされること" do
    travel_to Time.zone.local(2025, 8, 2, 15, 0, 0) do
      get root_path
      assert_redirected_to result_time_path(day: "Sat", time: "4")
    end
  end
end
