Rails.application.routes.draw do
  root to: 'web/home#index'
  namespace :web do
    root 'base#verify', via: [:get, :post]
    get 'home', to: 'home#index', as: :home
    get 'follow', to: 'home#follow', as: :follow
    get 'restore', to: 'home#restore', as: :restore
    resources :travels do
      resources :deals
      new do
        get :set_destinations
      end
      collection do
        get :owned
      end
    end
    resources :deals do
      collection do
        get :owned
      end
      member do
        get :buy_form
        patch :buy
        put :abort
      end
    end
    get 'force_sign_in', to: 'sessions#force_new', as: :force_sign_in
    post 'force_sign_in', to: 'sessions#force_create'
    post 'force_sign_up', to: 'users#create_faker', as: :force_sign_up
    get 'sign_in', to: 'sessions#create', as: :sign_in
    get 'sign_out', to: 'sessions#destroy', as: :sign_out
    resources :errors do
      collection do
        get :error_404
        get :error_500
      end
    end
    unless Rails.application.config.consider_all_requests_local
      get '*not_found', to: 'errors#error_404'
    end
  end
end