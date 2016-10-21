Rails.application.routes.draw do

  # Module SOS
  get 'alerts/index'
  post 'alerts/create'
  get 'workshops/addto'
  get 'workshops/switchto'

  resources :workshops

  get 'home/index'

  authenticated :user do
    root to: 'workshops#index', as: :authenticated_root
  end

  devise_for :users, :controllers => {:registrations => "users/registrations"}
  root :to => "home#index"

  resources :create_workshop
  #get '/workshop/:id/edit' => 'create_workshop#wicked_first', :as => 'edit_workshop'

  # , only: [:show, :update]
  # controller :workshops do
  #   resources :create_workshop, only: :update
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
