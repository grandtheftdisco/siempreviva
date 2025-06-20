class AdminMailer < ApplicationMailer
  def event_notification(event)
    @event = event
    admin_email = 'grandtheftdisco@gmail.com'

    mail to: :admin_email, subject: "Unexpected Stripe Event: #{event.object}"
  end

  def payment_issue_notification(checkout_session, payment_intent)
    @checkout_session = checkout_session
    @payment_intent = payment_intent

    mail to: :admin_email, subject: "Unexpected Issue with Payment Intent #{@payment_intent.id}"
  end
end
