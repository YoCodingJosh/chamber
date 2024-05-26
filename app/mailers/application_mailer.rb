class ApplicationMailer < ActionMailer::Base
  default from: "chamber@email.codingjosh.com"
  default reply_to: "no-reply@email.codingjosh.com"
  layout "mailer"
end
