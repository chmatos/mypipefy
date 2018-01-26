Rails.application.routes.draw do
  resources :home, only: [:index]
  root to: 'home#index'
  get 'fetch_new_data', action: :fetch_new_data, controller: 'home'
end
