Rails.application.routes.draw do
  root to: "home#search", as: :home_search
  get "about" => "home#about", as: :home_about
  get "contact" => "home#contact", as: :home_contact
  get "filter" => "home#filter", as: :home_filter

  get "results/room" => "results#room", as: :results_room
  get "results/:day/:time" => "results#time",  as: :results_time
end
