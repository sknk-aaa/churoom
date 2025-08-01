Rails.application.routes.draw do
  root to: 'home#index'

  get "search" => "home#search", as: :home_search
  get "about" => "home#about", as: :home_about
  get "contact" => "home#contact", as: :home_contact
  get "filter" => "home#filter", as: :home_filter

  get "result/room" => "result#room", as: :result_room
  get "result/:day/:time" => "result#time",  as: :result_time

end
