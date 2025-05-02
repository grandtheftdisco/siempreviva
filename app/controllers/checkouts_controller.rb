class CheckoutsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[ new create ]

  def new
    Rails.logger.info "$$$ CheckoutsCtrlr used CurrentCart in its #new action"
  end
  
  def create
    Rails.logger.info "$$$ CheckoutsCtrlr used CurrentCart in its #new action"
    determine_if_payment_intent_already_exists(@cart)
    
    checkout = Checkout.create(
      payment_intent_id: @payment_intent.id,
      cart_id: @cart.id,
      status: 'pending',
      stripe_customer_id: 'test_customerid123',
    )

    render json: {
     clientSecret: @payment_intent.client_secret,
     checkoutId: checkout.id
    }
  end

  private

  def determine_if_payment_intent_already_exists(cart)
    @existing_intent = Checkout.find_by(
      cart_id: cart.id, 
    )

    @payment_intent = if @existing_intent
                        validate_intent(@existing_intent.payment_intent_id)
                      else
                        create_new_payment_intent
                      end
  end

  def validate_intent(existing_intent_id)
    begin
      @payment_intent = Stripe::PaymentIntent.retrieve(
        existing_intent_id
      )

      # checks for expired PaymentIntents
      if Time.now - @payment_intent.created > 24.hours
        create_new_payment_intent
      end

      unless @payment_intent.amount == @cart.total_amount
        Stripe::PaymentIntent.update(
          @payment_intent.id, 
          amount: @cart.total_amount
        )
      end

    rescue Stripe::InvalidRequestError
      create_new_payment_intent
    end
  end

  def create_new_payment_intent
    @payment_intent = Stripe::PaymentIntent.create({
      amount: @cart.total_amount,
      currency: 'usd',
      automatic_payment_methods: { enabled: true },
      metadata: { cart_id: @cart.id }      
    })
  end
end