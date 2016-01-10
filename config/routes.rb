Rails.application.routes.draw do
  namespace :web do
    root 'base#verify', via: [:get, :post]
    get 'home', to: 'home#index', as: :home
    get 'sign_in', to: 'sessions#create', as: :sign_in
    get 'sign_out', to: 'sessions#destroy', as: :sign_out
  end
end