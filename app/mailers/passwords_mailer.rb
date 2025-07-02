class PasswordsMailer < ApplicationMailer
  # ADMIN RENAME - currently renaming stuff user >> admin BUT leaving this in case I can use it generically across classes
  def reset(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end
end
