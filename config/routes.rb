Rails.application.routes.draw do

  resources :workshops
  get 'home/index'

  authenticated :user do
    root to: 'workshops#index', as: :authenticated_root
  end

  devise_for :users
  root :to => "home#index"

  resources :create_workshop
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
