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
  get "cart/create"
  get "cart/new"
  get "cart/show"
  get "cart/update"

  post "create_checkout_session", to: "payments#create_checkout_session"
  get "checkout", to: "payments#stripe_payment"
  get "payment_success", to: "payments#payment_success"
  get "payment_cancelled", to: "payments#payment_cancelled"
end
