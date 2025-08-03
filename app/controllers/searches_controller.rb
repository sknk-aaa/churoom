require "csv"
class SearchesController < ApplicationController
        CSV_PATH = Rails.root.join("db", "data", "timetable2025.csv")

  def index # 講義時間内であれば「現在の空き教室はこちら」を表示
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

  def result_time
    @day = params[:day]
    @time = params[:time].to_i


    table = CSV.table(CSV_PATH, encoding: "SJIS:UTF-8")

    occupied_rows = table.select do |row|
      row[:day] == @day && row[:time] == @time
    end
    occupied_rooms = occupied_rows.map do |row|
      row[:number].to_s
    end

    all_rooms = %w[
      5133 5134 5135 5136 5137 5138
      5233 5234 5235 5236
      5333 5334 5335 5336
      5533 5534
      6209 6210
      6301 6302 6309 6317 6318 6325 6326
      6401 6402 6405 6409 6410 6413 6417 6418 6421 6425 6426 6429
    ]
    @available_rooms = all_rooms - occupied_rooms
  end

  def filter # 検索ページからのフィルター機能
    redirect_to result_time_path(
      day:  params[:day],
      time: params[:time]
    )
  end

  def result_room # 検索ページからの教室検索機能
  end
end
