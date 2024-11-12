Rails.application.routes.draw do
  # Health Check Endpoint
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Root Path
  root 'posts#index'

  # Static Pages
  get 'my_network', to: 'pages#my_network', as: :my_network
  get 'blog', to: 'pages#blog', as: :blog
  get 'map', to: 'pages#map', as: :map
  get 'about_us', to: 'pages#about_us', as: :about_us

  # Session Management
  resource :session, only: %i[new create destroy]

  # User Management
  resources :users, only: %i[new create show edit update] do
    member do
      get 'phone_verification'
      post 'verify_phone_number'
      get 'resend_phone_verification_code'
      get 'init_update_password'
      put 'update_password'
    end
    resource :avatar, only: %i[create update destroy]
  end

  # Password Recovery
  resource :password_recovery, only: %i[new create edit update] do
    member do
      get 'resend_code'
    end
  end

  resources :posts do
    resources :likes, only: [:index, :create]
    resources :comments, only: [:index, :create, :delete]
  end
end
