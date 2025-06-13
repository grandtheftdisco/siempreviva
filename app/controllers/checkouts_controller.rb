class CheckoutsController < ApplicationController
  def new
    @total = CartService::CalculateCart.call(cart: @cart)
  end
  
  def create
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
      stripe_checkout_session_id: session.id,
      cart_id: @cart.id,
      status: 'open',
      stripe_customer_id: 'test_customerid123',
    )

    render json: {
      clientSecret: session.client_secret,
      checkoutId: checkout.id
    }
  end

  def show
    session = Stripe::Checkout::Session.retrieve(params[:id])
    checkout = Checkout.find_by(stripe_checkout_session_id: session.id)

    if session.status == 'complete'
      @cart.destroy! # will implement soft deletion in near future
      checkout.update!(status: 'complete')
      redirect_to checkout_success_url
    elsif session.status == 'expired'
      render :new
    end
  end
end