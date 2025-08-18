require "csv"
require "set"
class SearchesController < ApplicationController
  before_action :load_data, only: [ :index, :result_time, :result_room, :filter ]
  CSV_PATH = Rails.root.join("db", "data", "timetable2025.csv")

  def index
    week = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]
    @day=week[Date.today.wday] # 曜日をdayに代入

    now = Time.zone.now
    @time= period_for(now) # 現在の時限をtimeに代入、講義時間外ならnilを返す
    @available_rooms_index = build_available_index(@day, @time)
  end

  def result_time
    @day = params[:day]
    @time = params[:time].to_i
    @available_rooms_index = build_available_index(@day, @time)
  end

  def result_room # 検索ページからの教室検索機能
    @room_number=params[:number].to_s
    @room_data=@table.select { |row|
      row[:number].to_s == @room_number}
  end


def build_available_index(day, time)
    occupied_set = @table
                     .select { |r| r[:day] == day && r[:time] == time }
                     .map    { |r| r[:number].to_s.strip }
                     .to_set

    # all_rooms_index からそのまま差し引く
    idx = Hash.new { |h, b| h[b] = Hash.new { |hh, f| hh[f] = [] } }
    @all_rooms_index.each do |b, floors_h|
      floors_h.each do |f, rooms|
        idx[b][f] = rooms.reject { |n| occupied_set.include?(n) }
      end
    end
    idx
  end

  def period_for(now)
    time= case now  # 現在の時限をtimeに代入、講義時間外ならnilを返す
    when now.change(hour: 8,  min: 50, sec: 0)...now.change(hour: 10, min: 40, sec: 0)
            1
    when now.change(hour: 10, min: 40, sec: 0)...now.change(hour: 12, min: 30, sec: 0)
            2
    when now.change(hour: 12, min: 30, sec: 0)...now.change(hour: 15, min: 00, sec: 0)
            3
    when now.change(hour: 15, min: 00, sec: 0)...now.change(hour: 16, min: 50, sec: 0)
            4
    when now.change(hour: 16, min: 50, sec: 0)...now.change(hour: 18, min: 40, sec: 0)
            5
    else
            nil
    end

    time
    end

  def filter # 検索ページからのフィルター機能
    redirect_to result_time_path(
      day:  params[:day],
      time: params[:time]
    )
  end

  def load_data
    @floors_by_building = { 5 => [ 1, 2, 3, 5 ], 6 => [ 2, 3, 4 ] }
    @days_dic = {
        "Mon" => "月", "Tue" => "火", "Wed" => "水",
        "Thu" => "木", "Fri" => "金", "Sat" => "土",
        "Sun" => "日"
      }
    @table = CSV.table(CSV_PATH, encoding: "SJIS:UTF-8")

    @all_rooms = %w[
        5133 5134 5135 5136 5137 5138
        5233 5234 5235 5236
        5333 5334 5335 5336
        5533 5534
        6209 6210
        6301 6302 6309 6317 6318 6325 6326
        6401 6402 6405 6409 6410 6413 6417 6418 6421 6425 6426 6429
    ]
    index = Hash.new { |h, b| h[b] = Hash.new { |hh, f| hh[f] = [] } }
    @all_rooms.each do |num|
      s = num.to_s.strip
      b = s[0].to_i                  # 号館（先頭1桁）
      f = s[1].to_i                  # 階（2桁目）
      index[b][f] << s
    end
    @all_rooms_index = index
  end
end
