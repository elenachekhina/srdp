# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :organizations, only: %w[index show]

  constraints subdomain: false do
    root to: 'organizations#index'
    resources :organizations, only: %w[index]

    controller :sessions do
      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end

  constraints subdomain: 'org' do
    namespace :org, path: '/' do
      root to: 'organizations#show'
      resources :organizations, only: %w[show create new] do
        resources :contacts, only: %w[new create edit update destroy show], shallow: true
        resources :addresses, only: %w[new create edit update destroy show], shallow: true
        resources :services, only: %w[new create edit update destroy show], shallow: true
      end

      controller :sessions do
        get 'login', to: 'sessions#new'
        post 'login', to: 'sessions#create'
        delete 'logout', to: 'sessions#destroy'
      end
    end
  end

  # controller :session do
  #   get 'login', to: 'sessions#new'
  #   post 'login', to: 'sessions#create'
  #   delete 'logout', to: 'sessions#destroy'
  # end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "articles#index"
end
