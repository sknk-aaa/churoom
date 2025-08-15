Rails.application.routes.draw do
  root to: "searches#index", as: :search

  post "filter" => "searches#filter", as: :search_filter

  get "search/room/:number" => "searches#result_room", as: :result_room
  get "search/time/:day/:time" => "searches#result_time",  as: :result_time

  get "contact/new" => "contacts#new", as: :contact_new
  post "contact",     to: "contacts#create", as: :contact
  get  "contact/thanks", to: "contacts#thanks", as: :contact_thanks

  get "about" => "pages#about", as: :about

  # 本番のヘルスチェック用（production.rbで silence_healthcheck_path="/up" に対応）
  get "up" => "rails/health#show", as: :rails_health_check
  # 存在しないパスへのフォールバック（404ページ）
  match "*path", to: "application#render_404", via: :all
end
