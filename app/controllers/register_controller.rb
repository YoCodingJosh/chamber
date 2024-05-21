class RegisterController < ApplicationController
  before_action :validate_cloudflare_turnstile, only: [:register]

  def index
    # TODO: check if the user is already logged in and redirect them if they are.

    @user ||= User.new
  end

  def register
  end
end
