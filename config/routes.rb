Rails.application.routes.draw do
  root "home#index"
  get 'user_photos/delete'
  resources :users
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :photos, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :profiles, only: [:show, :index, :edit, :update, :destroy]
  resources :likes, only: [:create]
  resources :dislikes, only: [:create]
  resources :matches, only: [:index]
  resources :admin, only: [:index]
  resources :messages, only: [:show, :create, :index]
  get '/messages/:user_id/show', to: 'messages#show', as: 'show_user_message'

  namespace :admin do
    resources :matches_manager, only: [:index]
    resources :user_manager, only: [:index]
  end

  namespace :admin do
    namespace :user_manager do
      resources :users, only: [:show, :edit, :update, :destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
