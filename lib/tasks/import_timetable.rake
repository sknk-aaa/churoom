
# lib/tasks/import_timetable.rake
require "csv"

namespace :import do
  desc "Timetable CSV import"
  task timetable: :environment do
    path = Rails.root.join("db","data","timetable.csv")
    raise "CSV not found: #{path}" unless File.exist?(path)

    map_day = {
      "月"=>"Mon","火"=>"Tue","水"=>"Wed","木"=>"Thu","金"=>"Fri","土"=>"Sat","日"=>"Sun"
    }

    ok = 0; ng = 0
    CSV.foreach(path, headers: true, encoding: "bom|utf-8") do |row|
      begin
        # --- 正規化（BOM/空白/CRLF/全角空白/日本語曜日） ---
        day_raw = row["day"].to_s
        day = day_raw.encode("UTF-8", invalid: :replace, undef: :replace).
                      delete("\uFEFF").strip.gsub(/\s+/, " ")
        day = map_day[day] || day  # 日本語→英語
        # 大文字小文字の差を吸収（必要なら）
        day = day.capitalize  # "mon" → "Mon"

        time = row["time"].to_s.tr("０-９","0-9").to_i
        number = row["number"].to_s.tr("０-９","0-9") # 文字列のまま使うならto_iしない

        # ここはあなたの一意制約に合わせて
        Occupancy.find_or_create_by!(day: day, time: time, number: number)
        ok += 1
      rescue => e
        ng += 1
        Rails.logger.warn "[import][skip] day=#{row['day'].inspect} time=#{row['time'].inspect} number=#{row['number'].inspect} err=#{e.class}: #{e.message}"
      end
    end
    Rails.logger.info "[import] done ok=#{ok} ng=#{ng} total=#{Occupancy.count}"
    puts "[import] done ok=#{ok} ng=#{ng} total=#{Occupancy.count}"
  end
end