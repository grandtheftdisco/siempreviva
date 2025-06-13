class OrderMailer < ApplicationMailer
  def received(order)
    order_info_setup

    mail to: @order.customer_email_address, subject: "Your Siempreviva Order Confirmation"
  end
  
  def shipped(order)
    order_info_setup
    @tracking_number = order.tracking_number

    mail to: order.customer_email_address, subject: "Your Siempreviva Order Has Shipped!"
  end

  private

  def order_info_setup
    @order = order
    @customer = fetch_customer_name(@order)
  end

  def fetch_customer_name(order)
    payment_intent = Stripe::PaymentIntent.retrieve(order.payment_intent_id)
    customer = Stripe::Customer.retrieve(payment_intent.customer)
    customer_full_name = customer.name.split
    customer_first_name = customer_full_name[0]
  end
end
