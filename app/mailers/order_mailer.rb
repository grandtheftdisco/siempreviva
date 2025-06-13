class OrderMailer < ApplicationMailer
  def received(order)
    @order = order
    mail to: order.customer_email_address, subject: "Your Siempreviva Order Confirmation"
  end
  
  def shipped(order)
    @order = order
    mail to: order.customer_email_address, subject: "Your Siempreviva Order Has Shipped!"
  end
end
