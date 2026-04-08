require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get time" do
    get result_time_url(day: "Mon", time: "1")
    assert_response :success
  end

  test "result_room highlights the current slot" do
    travel_to Time.zone.parse("2026-04-08 09:30:00") do
      get result_room_url(number: "5133")
    end

    assert_response :success
    assert_includes @response.body, '<td class="result-room__current-slot">〇</td>'
  end
end
