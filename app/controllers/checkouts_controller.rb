class CheckoutsController < ApplicationController
  skip_before_action :require_authentication
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
    @session = Stripe::Checkout::Session.retrieve(params[:id])
  end

  private
  
  def validate_cart_and_handle_removals
    @cart, removed_items, price_changes = CartService::ValidateCart.call(cart: @cart)

    alerts = []

    if removed_items.present?
      alerts << "⚠️ We apologize, but the following items are out of stock, and have been removed from your cart: " + removed_items.map { |item| item.name }.join(', ')
    end

    # this is going to be incredibly rare with a small ecom site, but IF it happens - you're covered!
    if price_changes.present?
      price_changes.each do |change|
        item = change[:item]
        old_price = format('%.2f', change[:old_price] / 100.0)
        new_price = format('%.2f', change[:new_price] / 100.0)

        alerts << "⚠️ We're updating our inventory right now! Heads up: The price of #{item.name} has changed from $#{old_price} to $#{new_price} since it was added to your cart."
      end
    end

    flash.now[:alert] = alerts.join('<br/><br/>').html_safe if alerts.any?

    @cart
  end
end