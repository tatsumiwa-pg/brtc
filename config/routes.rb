Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'consultations#index'
  resources :consultations do
    resources :answers, only: [:new]
  end
end
