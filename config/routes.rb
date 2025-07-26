Rails.application.routes.draw do
  get "/" => "home#top", as: :home_top
end
