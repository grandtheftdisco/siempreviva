Rails.application.routes.draw do

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "marketing#home"



  get "/contact", to: "marketing#contact"
  get "/learn", to: "marketing#learn"
  get "/gallery", to: "marketing#gallery"
  get "/our-farms", to: "marketing#our_farms"

  resources :products, only: [ :index, :show ]
  
  get "carts/show/:id", to: "carts#show", as: :cart

  resources :cart_items, only: [:create, :destroy ] 
    
  resources :checkouts, only: [ :new, :create, :show ]
  
  # TODO - fix the checkouts#show route to mask the session id/client secret
  # TODO - remove that from the params in CheckoutsController
end