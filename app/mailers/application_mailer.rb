class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  default reply_to: "no-reply@email.codingjosh.com"
  layout "mailer"
end
