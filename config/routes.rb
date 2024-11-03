Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  #Users
  # devise_for :users
  
  # # This line will generate all the RESTful routes for the UsersController
  # resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  # # Define the root path route ("/")
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  devise_for :users

  
  devise_scope :user do
    authenticated :user do
      root to: "users#index", as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root

    end
  end

end
