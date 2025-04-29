class CheckoutsController < ApplicationController
  
  def new
    @cart = Current.cart
  end
  
  def create
    # 1. Fetch the current cart and calculate the total amount of it
    @cart = Current.cart

    # 2. Create a PaymentIntent
      # CONSIDERATIONS:
      # a. DONE - if the amount changes, be sure to update the PI's amount
      # b. reuse the same PaymentIntent if the checkout process is interrupted and resumed later 
      # c. DONE - Make sure that this PaymentIntent gets associated with the current Checkout session
    
    @payment_intent = Stripe::PaymentIntent.create({
      amount: @cart.total_amount,
      currency: 'usd',
      automatic_payment_methods: { enabled: true },
      metadata: { cart_id: @cart.id }      
    })

    Rails.logger.debug "payment_intent: #{@payment_intent}"
    # 3. Create a record in your database to track this checkout
    checkout = Checkout.create(
      payment_intent_id: @payment_intent.id,
      cart_id: @cart.id,
      status: 'pending',
      stripe_customer_id: 'test_customerid123',
    )

    # 4. Return the client secret to the frontend
      # a. this will set up payment collection
    render json: {
     clientSecret: @payment_intent.client_secret,
     checkoutId: checkout.id
    }
  end
end