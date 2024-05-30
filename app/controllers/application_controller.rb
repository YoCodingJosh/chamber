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
end
