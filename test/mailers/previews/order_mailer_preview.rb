# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/received
  def received
    order = Order.last || Order.first
    OrderMailer.received(order)
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/shipped
  def shipped
    order = Order.last || Order.first
    OrderMailer.shipped(order)
  end
end
