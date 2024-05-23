class RegisterController < ApplicationController
  before_action :validate_cloudflare_turnstile, only: [:register]

  def index
    # TODO: check if the user is already logged in and redirect them if they are.

    @user ||= User.new

    # Clear all the flash messages
    flash.clear
  end

  def register
    # TODO: check if the user is already logged in and redirect them if they are.

    @user = User.new(user_params)

    if @user.invalid?
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render "register/index", status: 400
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
