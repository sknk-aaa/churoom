# lib/tasks/import_timetable.rake
require "csv"

namespace :import do
  desc "Timetable CSV import"
  task timetable: :environment do
    path = Rails.root.join("db", "data", "timetable.csv")
    raise "CSV not found: #{path}" unless File.exist?(path)

    map_day = {
      "月"=>"Mon","火"=>"Tue","水"=>"Wed","木"=>"Thu","金"=>"Fri","土"=>"Sat","日"=>"Sun"
    }

    puts "[import] start: #{path}"
    Occupancy.delete_all  # ← 学期ごとに全入替する場合は必須

    ok = 0; ng = 0
    CSV.foreach(path, headers: true, encoding: "SJIS:UTF-8") do |row|
      begin
        # --- 正規化 ---
        day_raw = row["day"].to_s
        day = day_raw.delete("\uFEFF").strip
        day = map_day[day] || day
        day = day.capitalize

        time   = row["time"].to_s.tr("０-９","0-9").to_i
        number = row["number"].to_s.tr("０-９","0-9").strip

        Occupancy.create!(day:, time:, number:)  # 重複はunique制約で弾かれる
        ok += 1
      rescue => e
        ng += 1
        puts "[import][skip] #{row.inspect} err=#{e.class}: #{e.message}"
      end
    end
    puts "[import] done ok=#{ok} ng=#{ng} total=#{Occupancy.count}"
  end
end
