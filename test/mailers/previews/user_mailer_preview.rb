# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/confirmation_email
  def confirmation_email
    UserMailer.with(user: User.where.not(confirmation_token: nil).first).confirmation_email
  end
end
