class CheckoutsController < ApplicationController
  skip_before_action :require_authentication
  
  def new
    @cart = validate_cart_and_handle_removals
    @total = CartService::CalculateCart.call(cart: @cart)
  end
  
  def create
  end

  def show
    checkout = Checkout.find_by(stripe_checkout_session_id: params[:id])

    if !checkout
      Rails.logger.error "\e[0;91mNo checkout found with Stripe Session ID: #{params[:id]}\e[0"
      return render plain: "Checkout not found", status: :not_found
    end

    begin
      session_id = checkout.stripe_checkout_session_id
      @session = Stripe::Checkout::Session.retrieve(session_id) if session_id.present?
    rescue Stripe::InvalidRequestError => e
      Rails.logger.error "\e[0;92m-----x----- Failed to retrieve Checkout Session: #{e.message}\e[0"
      return render plain: "Invalid Checkout Session", status: :not_found
    end

    # !! Calling this service here, instead of inside the event router in
      # the WebhooksCtrlr, because in order to delete the cart, you need
      # the current session cookie. The WebhooksCtrlr does not have session info,
      # so it would have required sending metadata to Stripe and then querying
      # for it.
    if @session.payment_status == 'paid'
      begin
        PaymentHandlingService::HandleSuccessfulPayment.call(checkout_session: @session,
                                                             cart: @cart)
      rescue => e
        Rails.logger.error "Error in PaymentHandlingService: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
      end
      # no redirect here, since you use the Stripe Checkout Session ID in your URLs
      # redirect is only necessary if you want to use postgres db's Checkout id for local Checkout lookup
    elsif @session.status == 'complete' && @session.payment_status == 'processing'
      # async payment in progress
    elsif @session.status == 'expired'
      flash.now[:alert] = "Oops! This checkout session has expired. Don't worry - your card hasn't been charged. Try checking out again! 🙂"
      redirect_to new_checkout_path
    else
      Rails.logger.debug "\e[0;92m--------x-------You have an unhandled sitch in CheckoutsController....\e[0"
    end
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