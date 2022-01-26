Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'consultations#index'
  resources :consultations, shallow: true do
    resources :answers, only: [:index, :new, :create, :show]
  end
end
