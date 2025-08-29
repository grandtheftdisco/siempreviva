class ContactForm < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  # Spam protection
  attribute :nickname, captcha: true

  def headers
    {
      subject: 'Contact Form Test',
      to: 'siemprevivaoils@gmail.com',
      from: %("#{name}" <#{email}>)
    }
  end
end