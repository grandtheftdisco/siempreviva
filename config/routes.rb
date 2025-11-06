Rails.application.routes.draw do
  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "marketing#home"

  get "/contact", to: "contact_form#new", as: :contact
  get "/learn", to: "marketing#learn"
  get "/gallery", to: "marketing#gallery"
  get "/our-farms", to: "marketing#our_farms"

  resources :products, only: [ :index, :show ]
  
  get "my-bag", to: "carts#show", as: :cart

  resources :cart_items, only: [:create, :update, :destroy ] 
    
  resources :checkouts, only: [ :new, :create, :show ]
  post '/checkout_sessions', to: 'checkout_sessions#create'

  post 'webhooks', to: 'webhooks#create'

  namespace :admins do 
    resources :orders, only: [ :create, :show, :edit, :update, :index ] do
      collection do
        get :archive, as: :archive
      end
    end
    resources :admins, path: '', only: [ :new, :create, :show ]
  end

  get '/admin_login', to: 'sessions#new', as: :admin_login
  resources :contact_form, only: [ :new, :create ]
end