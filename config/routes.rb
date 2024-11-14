Rails.application.routes.draw do
  get "reviews/new"
  get "reviews/create"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  devise_scope :user do
    # Set the root path to the Devise login page
    root to: "devise/sessions#new"
  end

  resources :home
  # Nesting ratings under specific games
  resources :games, only: [:index, :show] do
    resources :ratings, only: [:new, :create]
  end
  # Nesting friends under specific users
  resources :users, only: [:show] do
    # Nesting friends under users
    resources :friends, only: [:index, :show, :new, :create]
  end
  #resources :users, only: [:show]
  #get 'users/:id/friends', to: 'users#friends', as: 'friends'
  resources :rating
end
