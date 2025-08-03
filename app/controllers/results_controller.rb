require "csv"
class ResultsController < ApplicationController
  CSV_PATH = Rails.root.join("db", "data", "timetable2025.csv")
  def time
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

  def room
  end
end
