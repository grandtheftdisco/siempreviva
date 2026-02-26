Rails.application.routes.draw do
  root "marketing#home"
  get "up" => "rails/health#show", as: :rails_health_check

  # Marketing
  # TODO -namespace and/or scope these


  controller :marketing do
    get :learn
    get :gallery
    get :our_farms, as: "our-farms"
  end

  # Contact
  resources :contact_form, path: "contact", only: [ :create, :new ]

  # Carts
  get "my-bag", to: "carts#show", as: :cart

  # Cart Items
  resources :cart_items, only: [:create, :update, :destroy ] 

  # Checkouts
  resources :checkouts, only: [ :new, :create, :show ]

  # Webhook endpoints
  post 'stripe/webhooks', to: 'stripe/webhooks#create'
  post 'cloudinary/webhooks', to: 'cloudinary/webhooks#create'
  
  # Checkout Sessions (Stripe)
  resources :checkout_sessions, only: [ :create ]

  # Products
  resources :products, only: [ :index, :show ]

  # Admin
  namespace :admins do 
    resources :orders, only: [ :show, :edit, :update, :index ] do
      collection do
        get :archive, as: :archive
      end
    end
    resources :admins, path: '', only: [ :new, :create, :show ]
  end

  # Sessions & Passwords (Admin login)
  resource :sessions, only: [ :create, :destroy ] do
    get '/admin_login', to: 'sessions#new', as: :admin_login
  end
  resources :passwords, param: :token, only: [ :new, :create, :update, :edit ]

  # Webhooks
  resources :webhooks, only: [ :create ]
end