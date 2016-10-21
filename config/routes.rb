Rails.application.routes.draw do

  resources :liens
  get 'promo/' => 'promo#index'

  # Module SOS
  get 'alerts/index'
  post 'alerts/create'

  #Workshops routes, cannot use ressoures because we want to know the promo year
  get 'workshops/addto'
  get 'workshops/switchto'
  get ':year/workshop/:id' => 'workshops#show', as: 'workshop', :defaults => { :year => Time.now.to_s(:school_year) }
  get ':year/workshops' => 'workshops#index', as: 'workshops', :defaults => { :year => Time.now.to_s(:school_year) }
  get ':year/workshops/edit/:id'=> 'workshops#edit', as: 'edit_workshop', :defaults => { :year => Time.now.to_s(:school_year) }
  delete ':year/workshops/:id'=> 'workshops#destroy',as: 'delete_workshop', :defaults => { :year => Time.now.to_s(:school_year) }
  put ':year/workshops/:id'=> 'workshops#update',as: 'update_workshop', :defaults => { :year => Time.now.to_s(:school_year) }
  patch ':year/workshops/:id'=> 'workshops#update',:defaults => { :year => Time.now.to_s(:school_year) }



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
