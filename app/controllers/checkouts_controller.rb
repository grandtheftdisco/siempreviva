class CheckoutsController < ApplicationController
  def new
    @cart = Current.cart
    @total = CartService::CalculateCart.call(cart: @cart)
  end
  
  def create
    @cart = Current.cart
    @payment_intent = set_payment_intent(@cart)

    line_items = @cart.cart_items.map do |item|
      {
        price: item.product.stripe_price_id,
        quantity: item.quantity
      }
    end

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

  def set_payment_intent(cart)
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
    @total = CartService::CalculateCart.call(cart: @cart)
    begin
      @payment_intent = Stripe::PaymentIntent.retrieve(
        existing_intent_id
      )

      # checks for expired PaymentIntents
      if Time.now - @payment_intent.created > 24.hours
        create_new_payment_intent
      end

      unless @payment_intent.amount == @total
        Stripe::PaymentIntent.update(
          @payment_intent.id, 
          amount: @total
          line_items: line_items
        )
      end

    rescue Stripe::InvalidRequestError
      create_new_payment_intent
    end
  end

  def create_new_payment_intent
    @total = CartService::CalculateCart.call(cart: @cart)
    @payment_intent = Stripe::PaymentIntent.create({
      amount: @total,
      currency: 'usd',
      automatic_payment_methods: { enabled: true },
      metadata: { cart_id: @cart.id },
      line_items: line_items # for my reference; not used by Stripe directly  
    })
  end
end