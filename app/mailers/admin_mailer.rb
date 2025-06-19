class AdminMailer < ApplicationMailer
  def event_notification(event)
    event = event
    admin_email = grandtheftdisco@gmail.com

    mail to: admin_email, subject: "Unexpected Stripe Event: #{event.object}"
  end
end
