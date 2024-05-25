class RegisterController < ApplicationController
  before_action :validate_cloudflare_turnstile, only: [:register]

  rescue_from RailsCloudflareTurnstile::Forbidden do |exception|
    flash.now[:error] = "Please complete the CAPTCHA to register!"

    @user ||= User.new(user_params) rescue User.new

    render "register/index", status: 400
  end

  def index
    # TODO: check if the user is already logged in and redirect them if they are.

    @user ||= User.new
  end

  def register
    # TODO: check if the user is already logged in and redirect them if they are.

    @user = User.new(user_params)

    if @user.invalid?
      flash.now[:error] = "Could not register! Please fix the validation errors and try again."
      flash.now[:validation_errors] = @user.errors
      render "register/index", status: 400

      return
    end

    @user.confirmation_token = SecureRandom.hex(32)
    @user.confirmation_sent_at = Time.now

    if @user.save
      flash[:success] = "Registration successful! Please check your email to confirm your account."
      redirect_to "/login"
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render "register/index", status: 400
    end
  end

  def confirm
    # TODO: check if the user is already logged in and redirect them if they are.

    request_id = params[:id]
    confirmation_token = params[:confirmation_token]

    user = User.find_by(id: request_id)

    if user.nil?
      flash.now[:error] = "User not found!"

      render "register/index", status: 404
      return
    end

    if user.confirmation_token != confirmation_token
      flash.now[:error] = "Invalid confirmation token!"

      render "register/index", status: 400
      return
    end

    # check if the confirmation token has expired
    if user.confirmation_sent_at < 1.day.ago
      flash.now[:error] = "Confirmation token has expired! Please register again."

      render "register/index", status: 400
      return
    end

    user.confirmed_at = Time.now
    user.confirmation_token = nil
    user.confirmation_sent_at = nil

    if user.save
      flash[:success] = "Account confirmed! You can now login."
      redirect_to "/login"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to "/register"
    end
  end

  private

  def user_params
    # strong parameters
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
