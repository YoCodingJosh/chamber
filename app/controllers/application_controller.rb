class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :warning, :validation_errors

  # Add current_user to the view
  helper_method :current_user

  # Add the current_user to the controller
  attr_reader :current_user

  # Add the current_user to the controller
  # This is used in the filters
  def current_user
    # TODO: implement the current_user method
    nil
  end
end
