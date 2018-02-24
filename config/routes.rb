Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'auth/callbacks' }
  resources :users, only: [:show, :edit]
  root "pages#index"
end
