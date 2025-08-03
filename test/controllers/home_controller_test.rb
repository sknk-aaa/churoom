# app/controllers/home_controller.rb
class HomeControllerTest < ActionDispatch::IntegrationTest
  def search
    now = Time.zone.now
    if lecture_time?(now)
      @current_day  = now.strftime("%a")   # => "Mon","Tue",...,"Sat"
      @current_time = time_slot(now.hour)  # => "1","2",...,"4"
    end
  end

  private

  # 土曜も含めて月曜(1)〜土曜(6)の9時〜18時を「授業時間内」とする例
  def lecture_time?(time)
    (1..6).cover?(time.wday) && (9..18).cover?(time.hour)
  end

  def time_slot(hour)
    case hour
    when 9..10   then "1"
    when 11..12  then "2"
    when 13..14  then "3"
    when 15..16  then "4"
    else             "0"
    end
  end
end
