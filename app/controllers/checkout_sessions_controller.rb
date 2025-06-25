class CheckoutSessionsController < ApplicationController
  def create
    line_items = @updated_cart.cart_items.map do |item|
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
      cart_id: @updated_cart.id,
      status: session.status,
      stripe_customer_id: session.customer,
    )

    render json: {
      clientSecret: session.client_secret,
      checkoutId: checkout.id
    }
  end
end