Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', omniauth_callbacks: 'auth/callbacks' }
  resources :users
  root "pages#index"
end
