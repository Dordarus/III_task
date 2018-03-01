Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', omniauth_callbacks: 'auth/callbacks' }
  resources :users
  resources :charges, only: [:new, :create]
  get 'thanks', to: 'charges#thanks', as: 'thanks'
  root "charges#new"
end
