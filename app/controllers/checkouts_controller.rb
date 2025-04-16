class CheckoutsController < ApplicationController
  
  def new
  end
  
  def create
    # 1. Fetch the current cart and calculate the total amount of it
    cart = current_user.cart
    amount = cart.total_amount

    # 2. Create a PaymentIntent
      # CONSIDERATIONS:
      # a. if the amount changes, be sure to update the PI's amount
      # b. reuse the same PaymentIntent if the checkout process is interrupted and resumed later 
      # c. Make sure that this PaymentIntent gets associated with the current Checkout session
    payment_intent = Stripe::PaymentIntent.create({
      amount: amount,
      currency: 'usd',
      automatic_payment_methods: { enabled: true },
      metadata: { cart_id: cart.id }
    })

    # 3. Create a record in your database to track this checkout
    checkout = Checkout.create(
      user: current_user,
      cart: cart,
      amount: amount,
      payment_intent_id: payment_intent.id,
      status: 'pending'
    )
    
    # 4. Return the client secret to the frontend
      # a. this will set up payment collection
    render json: {
      clientSecret: payment_intent.client_secret,
      checkoutId: checkout.id
    }
  end

  private

  def success_url
    "#{request.base_url}/payment_success"
  end

  def cancel_url
    "#{request.base_url}/payment_cancelled"
  end
end
