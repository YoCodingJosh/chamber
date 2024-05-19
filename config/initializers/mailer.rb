# if we're in production, set the Resend API key with the environment variable.
if Rails.env.production?
  Resend.api_key = ENV['RESEND_API_KEY']
end
