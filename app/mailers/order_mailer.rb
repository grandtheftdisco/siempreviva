class OrderMailer < ApplicationMailer
  def received(order)
    order_info_setup(order)

    mail to: @order.customer_email_address, subject: "Your Siempreviva Order Confirmation"
  end
  
  def shipped(order)
    order_info_setup(order)
    @tracking_number = order.tracking_number

    mail to: @order.customer_email_address, subject: "Your Siempreviva Order Has Shipped!"
  end

  def refunded(order)
    order_info_setup(order)
    Rails.logger.debug "[=[=[ #{@order.inspect} ]=]=]"
    fetch_refund_info(@order)

    mail to: @order.customer_email_address, subject: "Your Order Has Been Refunded"
  end

  private

  def order_info_setup(order)
    @order = order
    @customer = fetch_customer_name(@order)
  end

  def fetch_customer_name(order)
    payment_intent = Stripe::PaymentIntent.retrieve(order.payment_intent_id)
    customer = Stripe::Customer.retrieve(payment_intent.customer)
    customer.name.split.first
  end

  def fetch_refund_info(order)
    payment_intent = Stripe::PaymentIntent.retrieve(order.payment_intent_id)
    charge_id = payment_intent.latest_charge
    
    # grabs all possible refunds in the event of multiple
    refunds = Stripe::Refund.list({ charge: charge_id })

    # most likely the first/sole refund will be what you're looking for
    @refund = refunds.data.first
  end
end
