RailsCloudflareTurnstile.configure do |c|
  c.site_key = ENV['TURNSTILE_SITE_KEY']
  c.secret_key = ENV['TURNSTILE_SECRET_KEY']
  c.fail_open = true
  c.theme = :light
end
