Rails.application.routes.draw do
  root to: "static_pages#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api do
    resources :users, only: :show, defaults: { format: :json }
    resources :properties, only: [:index, :show], defaults: { format: :json }
  end

end
