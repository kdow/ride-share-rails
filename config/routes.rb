Rails.application.routes.draw do
  root "homepages#index"
  
  resources :passengers
  resources :drivers
  resources :trips, except: [:index, :new]
end
