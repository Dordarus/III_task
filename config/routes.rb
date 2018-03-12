Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'auth/callbacks' }
  resources :users
  resources :charges, only: [:new, :create]
  resources :books
  resources :topics, except: [:index]
  
  patch '/associations' => 'associations#update'
  delete '/associations' => 'associations#destroy'

  root "pages#index"
end
