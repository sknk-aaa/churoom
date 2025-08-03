Rails.application.routes.draw do
  root to: "searches#index", as: :search

  get "filter" => "searches#filter", as: :search_filter

  get "search/room" => "searches#result_room", as: :result_room
  get "search/time/:day/:time" => "searches#result_time",  as: :result_time

  get "about" => "pages#about", as: :about
  get "contact" => "pages#contact", as: :contact
end
