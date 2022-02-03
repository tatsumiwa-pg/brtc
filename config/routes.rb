Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'consultations#index'
  resources :consultations, shallow: true do
    resources :answers, only: [:index, :new, :create, :show], shallow: true do
      resources :ans_comments, only: :create
    end
    resources :reconciliations, only: [:index, :new, :create]
    resources :cons_comments, only: :create
  end
end
