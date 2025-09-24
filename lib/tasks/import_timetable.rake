namespace :import do
  desc "Replace occupancies with CSV data (full refresh)"

  task timetable: :environment do
    require "csv"

    file = Rails.root.join("db", "data", "timetable.csv")
    rows=0

    ActiveRecord::Base.transaction do
      Occupancy.delete_all

      CSV.foreach(file, headers: true, encoding: "SJIS:UTF-8") do |row|
        day    = row["day"]&.strip
        time   = row["time"].to_i
        number = row["number"].to_s.strip

        rows+=1

        next if day.blank? || time.zero? || number.blank?
        Occupancy.find_or_create_by!(day:, time:, number:)
      end
    end

    puts " #{rows}が登録されました"
  end
end