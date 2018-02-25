Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', omniauth_callbacks: 'auth/callbacks' }
  resources :users, only: [:show, :edit]
  root "pages#index"
end
