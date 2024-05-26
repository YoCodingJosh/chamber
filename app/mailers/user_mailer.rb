class UserMailer < ApplicationMailer
  default from: "chamber@email.codingjosh.com"

  def confirmation_email
    @user = params[:user]

    mail(to: @user.email, subject: "Please confirm your new Chamber account!")
  end
end
