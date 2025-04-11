Rails.application.routes.draw do
  get "cart_items/create"
  get "cart_items/update"
  get "cart_items/new"
  get "cart_items/destroy"
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
  get "carts/create"
  get "carts/new"
  get "carts/show/:id", to: "carts#show", as: :show_cart
  get "carts/update"
  resources :cart_items

  post "create_checkout_session", to: "payments#create_checkout_session"
  get "checkout", to: "payments#stripe_payment"
  get "payment_success", to: "payments#payment_success"
  get "payment_cancelled", to: "payments#payment_cancelled"
end
