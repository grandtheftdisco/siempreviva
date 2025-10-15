class CheckoutsController < ApplicationController
  skip_before_action :require_authentication

  def new
    @cart = validate_cart_and_handle_removals
    @total = CartService::CalculateCart.call(cart: @cart)
  end

  def create
  end

  def show
    local_checkout_record = Checkout.find_by(stripe_checkout_session_id: params[:id])

    if !local_checkout_record
      Rails.logger.error "\e[101;1mNo local checkout record found with Stripe Session ID: #{params[:id]}\e[0m"
      return render plain: 'Local Checkout record not found', status: :not_found
    end

    begin
      session_id = local_checkout_record.stripe_checkout_session_id
      @session = Stripe::Checkout::Session.retrieve(session_id) if session_id.present?

      if @session.status == 'expired'
        flash.now[:alert] = 'Oops! This checkout session has expired. Don\'t worry - your card hasn\'t been charged. Try checking out again! 🙂'
        redirect_to new_checkout_path
      end

      # Process payment synchronously if webhook hasn't arrived yet
      # This blocks until payment processing is complete, preventing race conditions
      WebhookSynchronizationService::EnsurePaymentProcessed.call(stripe_checkout_session_id: session_id)

      # Now that payment is guaranteed to be processed, fetch the order
      @order = Order.find_by(payment_intent_id: @session.payment_intent)

    rescue Stripe::InvalidRequestError => e
      Rails.logger.error "\e[101;1m-----x----- Failed to retrieve Checkout Session: #{e.message}\e[0m"
      Rails.logger.error "\e[101m ---> Checkout Session ID #{@session&.id || 'not yet assigned' }]"
      return render plain: 'Invalid Checkout Session', status: :not_found
    rescue Stripe::StripeError => e
      Rails.logger.error "\e[101;1m-----x----- Stripe error occurred: #{e.message}\e[0m"
      Rails.logger.error "\e[101m ---> Checkout Session ID #{@session&.id || 'not yet assigned' }]"
      return render plain: 'Payment processing error', status: :service_unavailable
    rescue StandardError => e
      Rails.logger.error "\e[101;1m-----x----- Unexpected error in checkout: #{e.message}\e[0m"
      Rails.logger.error "\e[101m ---> Checkout Session ID #{@session&.id || 'not yet assigned' }]"
      return render plain: 'An unexpected error occurred', status: :internal_server_error
    end
  end

  private

  def validate_cart_and_handle_removals
    @cart, removed_items, price_changes = CartService::ValidateCart.call(cart: @cart)

    alerts = []

    if removed_items.present?
      removed_item_names = removed_items.map(&:name).join(', ')
      alerts << "⚠️ We apologize, but the following items are out of stock, and have been removed from your cart: #{removed_item_names}"
    end

    # This is going to be incredibly rare with a small ecom site, but IF it happens - you're covered!
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