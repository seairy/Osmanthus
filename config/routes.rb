Rails.application.routes.draw do
  root to: 'web/home#index'
  namespace :web do
    root 'base#verify', via: [:get, :post]
    get 'home', to: 'home#index', as: :home
    resources :travels do
      new do
        get :set_destinations
      end
    end
    get 'force_sign_in', to: 'sessions#force_new', as: :force_sign_in
    post 'force_sign_in', to: 'sessions#force_create'
    post 'force_sign_up', to: 'users#create_faker', as: :force_sign_up
    get 'sign_in', to: 'sessions#create', as: :sign_in
    get 'sign_out', to: 'sessions#destroy', as: :sign_out
  end
end