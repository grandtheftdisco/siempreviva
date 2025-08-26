class ContactForm < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  # spam protection
  attribute :nickname, captcha: true 
  
  def headers
    {
      subject: "Contact Form Test",
      to: "grandtheftdisco@gmail.com",
      from: %("#{name}" <#{email}>)
    }
  end
end