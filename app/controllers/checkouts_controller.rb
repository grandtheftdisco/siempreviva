class CheckoutsController < ApplicationController
  
  def new
    @cart = Current.cart

    @session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: [{
        price:'price_1RJKDAC2evWDh2V2p8E2Uo8W', # replace w actual price_id
        quantity: 1, # replace w actual quantity of cart_item
      }],
      mode: 'payment',
      return_url: checkout_success_url,
      expand: ['line_items']
    })
  end
  
  def create
    @cart = Current.cart
    determine_if_payment_intent_already_exists(@cart)
    
    

    Rails.logger.info "Checkout Session created: #{@session.id}"
    Rails.logger.info "Line items: #{@session.line_items.inspect if @session.line_items}"

    if @session.line_items.nil?
      Rails.logger.warn "No line items returned in the Checkout Session"
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

  def show # nee `return`
    @session = Stripe::Checkout::Session.retrieve(params[:id])
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