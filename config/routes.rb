Rails.application.routes.draw do
  root "homepages#index"

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  resources :drivers do
    resources :trips, only: [:index]
  end

  resources :passengers
  resources :drivers
  resources :trips, except: [:new, :create]
end
