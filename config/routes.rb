Rails.application.routes.draw do
  devise_for :users
  root to: 'consultations#index'
  resources :consultations, only: :index
end
