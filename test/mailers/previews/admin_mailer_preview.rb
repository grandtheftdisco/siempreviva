# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/event_notification
  def event_notification
    AdminMailer.event_notification
  end
end
