class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_days_dic
  def set_days_dic
    @days_dic = {
      "Mon" => "月", "Tue" => "火", "Wed" => "水",
      "Thu" => "木", "Fri" => "金", "Sat" => "土",
      "Sun" => "日"
    }
  end
end
