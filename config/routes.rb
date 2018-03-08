Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'auth/callbacks' }
  resources :users
  resources :charges, only: [:new, :create]
  resources :books
  root "pages#index"
end
