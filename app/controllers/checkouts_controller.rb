class CheckoutsController < ApplicationController
  def new
    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]
    Rails.logger.info "Stripe API key set: #{Stripe.api_key.present?}"
    @cart = Current.cart
    @total = CartService::CalculateCart.call(cart: @cart)
  end
  
  def create
    @cart = Current.cart
    line_items = @cart.cart_items.map do |item|
      product = Stripe::Product.retrieve(
        { id: item.stripe_product_id, expand: ['default_price'] }
      )

      {
        price: product.default_price.id,
        quantity: item.quantity
      }
    end

    # so Rails will interpret the URL helper properly
    return_url = checkout_url('CHECKOUT_SESSION_ID')
    return_url = return_url.gsub('CHECKOUT_SESSION_ID', '{CHECKOUT_SESSION_ID}')
    
    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: line_items,
      mode: 'payment',
      return_url: return_url
    })

    # for my db
    checkout = Checkout.create(
      payment_intent_id: 'test_paymentid12534',
      cart_id: @cart.id,
      status: 'pending',
      stripe_customer_id: 'test_customerid123',
    )

    render json: {
      clientSecret: session.client_secret,
      checkoutId: checkout.id
    }
  end

  def show
    @session = Stripe::Checkout::Session.retrieve(params[:id])

    if @session.status == 'complete'
      redirect_to checkout_success_url
      # handle successful payment
      # update db
      # send confirmation email
    elsif @session.status == 'expired'
      render :new
    end
  end
end