Rails.application.routes.draw do

  resources :liens
  get 'promo/' => 'promo#index'

  # Module SOS
  get 'alerts/index'
  post 'alerts/create'

  #Workshops routes, cannot use ressoures because we want to know the promo year
  get 'workshops/addto'
  get 'workshops/switchto'
  get 'workshops/:year/:id' => 'workshops#show', as: 'workshop', :defaults => { :year => Time.now.to_s(:school_year) }
  get 'workshops/:year' => 'workshops#index', as: 'workshops', :defaults => { :year => Time.now.to_s(:school_year) }
  get 'workshops/edit/:year/:id'=> 'workshops#edit', as: 'edit_workshop', :defaults => { :year => Time.now.to_s(:school_year) }
  delete 'workshops/:year/:id'=> 'workshops#destroy'
  put 'workshops/:year/:id'=> 'workshops#update'
  patch 'workshops/:year/:id'=> 'workshops#update', as: 'update_workshop'



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
