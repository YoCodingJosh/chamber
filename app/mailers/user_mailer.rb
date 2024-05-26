class UserMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]

    mail(to: @user.email, subject: "Please confirm your new Chamber account!")
  end
end
