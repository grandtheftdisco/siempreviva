class CheckoutsController < ApplicationController
  
  def new
  end
  
  def create
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: 'Your Product',
          },
          unit_amount: 2000,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: success_url,
      cancel_url: cancel_url,
    })

    render json: { id: @session.id }
  end

  private

  def success_url
    "#{request.base_url}/payment_success"
  end

  def cancel_url
    "#{request.base_url}/payment_cancelled"
  end
end
