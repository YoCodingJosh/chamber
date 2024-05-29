class LoginController < ApplicationController
  def index
  end

  def login
    @login = LoginRequest.new(login_params)

    if @login.invalid?
      flash.now[:error] = "Could not log in! Please fix the validation errors and try again."
      flash.now[:validation_errors] = @login.errors
      render "login/index", status: 400

      return
    end

    user = User.find_by(email: @login.email)

    if user.nil?
      flash.now[:error] = "Credentials are invalid!"
      render "login/index", status: 404
      return
    end

    if user.authenticate(@login.password)
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully!"
      redirect_to "/home"
    else
      flash.now[:error] = "Credentials are invalid!"
      render "login/index", status: 404
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Logged out successfully!"
    redirect_to "/login"
  end

  def forgot_password
  end

  def reset_password
  end
end
