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
      @cart = validate_cart_and_handle_removals
      @total = CartService::CalculateCart.call(cart: @cart)
      # flash.now alert "that checkout session expired - try checking out again - your card didnt get charged"
      render :new # could redirect - check if stripe needs a full new render or if a redirect is sufficient 
      # if you redirect, you dont need all the repetition of the code from #new above
    end
  end

  def show
    # set the vars you need in the view
  end

  private
  
  def validate_cart_and_handle_removals
    @cart, removed_items = CartService::ValidateCartItemInventory.call(cart: @cart)

    if removed_items.present?
      flash.now[:alert] = "We apologize, but the following items are out of stock, and have been removed from your cart: " + removed_items.map { |item| item.name }.join(', ')
    end
    @cart
  end
end