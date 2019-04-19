Rails.application.routes.draw do
  root "homepages#index"

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  get "drivers/unavailable", to: "drivers#not_found", as: :driver_not_found

  resources :drivers do
    resources :trips, only: [:index]
  end

  resources :passengers
  resources :drivers
  resources :trips, except: [:new, :create]

  patch "trips/:id/rate", to: "trips#add_rating", as: :add_trip_rating
  patch "drivers/:id/available", to: "drivers#toggle_available", as: :toggle_available_driver
end
