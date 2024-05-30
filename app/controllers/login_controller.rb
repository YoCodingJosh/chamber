class LoginController < ApplicationController
  def index
    if current_user
      redirect_to "/"
      return
    end

    @login = LoginRequest.new
  end

  def login
    if current_user
      redirect_to "/"
      return
    end

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

    if user.confirmed_at.nil?
      flash.now[:error] = "Account is not confirmed! Please check your email for the confirmation link."
      render "login/index", status: 403
      return
    end

    reset_session

    if user.authenticate(@login.password)
      session[:user_id] = user.id
      redirect_to "/"
    else
      flash.now[:error] = "Credentials are invalid!"
      render "login/index", status: 404
    end
  end

  def logout
    reset_session

    flash[:success] = "Logged out successfully!"
    redirect_to "/login"
  end

  def forgot_password
  end

  def reset_password
  end

  private def login_params
    params.require(:login_request).permit(:email, :password)
  end
end
