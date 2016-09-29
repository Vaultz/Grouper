Rails.application.routes.draw do
  get 'workshops/preview'

  resources :workshops
  get 'home/index'

  devise_for :users
  root :to => "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
