Rails.application.routes.draw do
  namespace :web do
    root 'base#verify', via: [:get, :post]
    get 'home', to: 'home#index', as: :home
  end
end