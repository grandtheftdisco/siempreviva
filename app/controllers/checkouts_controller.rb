class CheckoutsController < ApplicationController
  def new
    @updated_cart = validate_cart_and_handle_removals
    @total = CartService::CalculateCart.call(cart: @updated_cart)
  end
  
  def create
    @updated_cart = validate_cart_and_handle_removals
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

  private
  
  def validate_cart_and_handle_removals
    updated_cart, removed_items = CartService::ValidateCartItemInventory.call(cart: @cart)

    if removed_items.present?
      flash[:alert] = "We apologize, but the following items are out of stock, and have been removed from your cart: " + removed_items.map { |item| item.name }.join(', ')
      redirect_to new_checkout_path
    end
    updated_cart
  end
end