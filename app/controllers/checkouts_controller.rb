class CheckoutsController < ApplicationController
  def new
    @cart = validate_cart_and_handle_removals
    @total = CartService::CalculateCart.call(cart: @cart)
  end
  
  def create
    session = Stripe::Checkout::Session.retrieve(params[:id])
    checkout = Checkout.find_by(stripe_checkout_session_id: session.id)

    if session.status == 'complete'
      @cart.destroy! # will implement soft deletion in near future
      checkout.update!(status: 'complete')
      redirect_to checkout
    elsif session.status == 'expired'
      flash.now[:alert] = "Oops! This checkout session has expired. Don't worry - your card hasn't been charged. Try checking out again! 🙂"
      redirect_to new_checkout_path
    end
  end

  def show
    # set the vars you need in the view
  end

  private
  
  def validate_cart_and_handle_removals
    @cart, removed_items = CartService::ValidateCart.call(cart: @cart)

    if removed_items.present?
      flash.now[:alert] = "We apologize, but the following items are out of stock, and have been removed from your cart: " + removed_items.map { |item| item.name }.join(', ')
    end

    @cart
  end
end