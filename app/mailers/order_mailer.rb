class OrderMailer < ApplicationMailer
  def received(order)
    Rails.logger.info "Calling OrderMailer#received"
    @order = order

    mail to: order.customer_email_address, subject: "Your Siempreviva Order Confirmation"
    Rails.logger.info "Confirmation email sent!"
  end
  
  def shipped(order)
    @order = order

    mail to: order.customer_email_address, subject: "Your Siempreviva Order Has Shipped!"
  end
end
