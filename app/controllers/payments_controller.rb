class PaymentsController < ApplicationController
  def create_checkout_session
    require 'stripe'
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    begin
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price: 'price_1RBk28C2evWDh2V2F75tDbJu',
          quantity: 1,
        }],
        mode: 'payment',
        success_url: success_url,
        cancel_url: cancel_url,
      })
      render json: {id: session.id }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: 500
    rescue => e
      render json: { error: 'An unexpected error occured' }, status: 500
    end
  end

  private

  def success_url
    # replace with your actual success url
    "#{request.base_url}/payment_success"
  end

  def cancel_url
    # replace with your actual cancel URL
    "#{request.base_url}/payment_cancelled"
  end

  def stripe_payment
  end
end