class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :warning, :validation_errors

  # Add current_user to the view
  helper_method :current_user

  # Add the current_user to the controller
  attr_reader :current_user

  def current_user
    # If the user is already set, just return it
    return @current_user if @current_user

    # If the user is not set, but the session is, then find the user
    @current_user = User.find(session[:user_id]) if session[:user_id]

    # Return the user
    @current_user
  end

  def enroll_user_with_totp
    # If the user is not enrolled with TOTP, then redirect to the enrollment page
    return if request.path == '/totp_enroll' || request.path == "/logout"

    redirect_to "/totp_enroll" unless current_user.nil? || current_user&.totp_enabled?
  end

  def verify_totp_after_login
    # If the user is not enrolled with TOTP, then redirect to the verification page
    return if request.path == '/totp_verify' || request.path == "/logout" || request.path == "/totp_enroll"

    # TODO: check session if we've already verified the TOTP
    redirect_to "/totp_verify" unless current_user.nil? || session[:totp_verified]
  end

  before_action :enroll_user_with_totp
  before_action :verify_totp_after_login
end
