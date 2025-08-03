class HomeController < ApplicationController
  def search # 講義時間内であれば「現在の空き教室はこちら」を表示
    week = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]
    @day=week[Date.today.wday] # 曜日をdayに代入

    now = Time.zone.now
    @time= case now  # 現在の時限をtimeに代入、講義時間外ならnilを返す
    when Time.zone.now.change(hour: 8,  min: 50, sec: 0)...Time.zone.now.change(hour: 10, min: 40, sec: 0)
            1
    when Time.zone.now.change(hour: 10, min: 40, sec: 0)...Time.zone.now.change(hour: 12, min: 30, sec: 0)
            2
    when Time.zone.now.change(hour: 12, min: 30, sec: 0)...Time.zone.now.change(hour: 15, min: 00, sec: 0)
            3
    when Time.zone.now.change(hour: 15, min: 00, sec: 0)...Time.zone.now.change(hour: 16, min: 50, sec: 0)
            4
    when Time.zone.now.change(hour: 16, min: 50, sec: 0)...Time.zone.now.change(hour: 18, min: 40, sec: 0)
            5
    else
            nil
    end
  end

  def filter # 検索ページからのフィルター機能
    redirect_to results_time_path(
      day:  params[:day],
      time: params[:time]
    )
  end

  def about
  end

  def contact
  end
end
