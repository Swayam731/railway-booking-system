Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'trains/new'
  # get 'trains/create'
  # get 'trains/show'
  # get 'trains/edit'
  # get 'trains/update'
  # get 'trains/destroy'

  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "homes#index"

  resources :homes

  resources :payments
  # get '/search', to: 'trains#search'

  resources :trains do
    # resources :tickets, only: [:show, :create, :destroy]
    collection do
      get 'search'
      get 'search_result'
    end
  end
  resources :tickets

  resources :passengers

  devise_for :users do
    resources :tickets
  end

end
