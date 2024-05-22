class RegisterController < ApplicationController
  before_action :validate_cloudflare_turnstile, only: [:register]

  def index
    # TODO: check if the user is already logged in and redirect them if they are.

    @user ||= User.new
  end

  def register
    # TODO: check if the user is already logged in and redirect them if they are.

    @user = User.new(user_params)

    if @user.invalid?
      # TODO: display a flash message with the errors
      render json: { errors: @user.errors }, status: :bad_request
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
