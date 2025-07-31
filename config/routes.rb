Rails.application.routes.draw do
  get "result/time"
  get "/" => "home#top", as: :home_top
  get "about" => "home#about", as: :home_about
  get "contact" => "home#contact", as: :home_contact
end
