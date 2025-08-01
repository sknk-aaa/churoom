Rails.application.routes.draw do
  get "/" => "home#top", as: :home_top
  get "about" => "home#about", as: :home_about
  get "contact" => "home#contact", as: :home_contact
  get "result/time" => "result#time", as: :result_time
  get "result/room" => "result#room", as: :result_room

end
