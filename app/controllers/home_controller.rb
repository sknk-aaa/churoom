class HomeController < ApplicationController
  def top #曜日と時限をday,timeに格納（例:木,4）
    
    require 'date'
    week = ['日','月','火','水','木','金','土' ]
    day=week[Date.today.wday].to_s #曜日を取得

    now = Time.zone.now
    time= case now #現在の時限を取得、講義時間外ならnilを返す
          when Time.zone.now.change(hour: 8,  min: 50)...Time.zone.now.change(hour: 10, min: 40)
            1
          when Time.zone.now.change(hour: 10, min: 40)...Time.zone.now.change(hour: 12, min: 30)
            2
          when Time.zone.now.change(hour: 12, min: 30)...Time.zone.now.change(hour: 15, min: 00)
            3
          when Time.zone.now.change(hour: 15, min: 00)...Time.zone.now.change(hour: 16, min: 50)
            4
          when Time.zone.now.change(hour: 16, min: 50)...Time.zone.now.change(hour: 18, min: 40)
            5
          else
            nil
          end

  end

  def about
  end

  def contact
  end
  
end
