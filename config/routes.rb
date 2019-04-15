Rails.application.routes.draw do
  resources :passengers
  resources :drivers
  resources :trips, except: [:index, :new]
end
