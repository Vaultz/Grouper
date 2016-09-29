Rails.application.routes.draw do
  post 'workshops/preview'

  resources :workshops
  get 'home/index'

  authenticated :user do
    root to: 'workshops#index', as: :authenticated_root
  end

  devise_for :users
  root :to => "home#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
