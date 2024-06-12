class UserController < ApplicationController
  def enroll_totp
    if current_user.nil? || current_user.totp_enabled
      redirect_to "/"
      return
    end

    totp = ROTP::TOTP.new(current_user.totp_secret, issuer: "Chamber")

    @qr_code =
      RQRCode::QRCode
        .new(totp.provisioning_uri(current_user.email))
        .as_png(resize_exactly_to: 250)
        .to_data_url

    @manual_code = totp.secret
  end

  def confirm_totp
    if current_user.nil? || current_user.totp_enabled
      redirect_to "/"
      return
    end

    totp = ROTP::TOTP.new(current_user.totp_secret)

    if totp.verify(params[:code])
      current_user.totp_enabled = true
      current_user.save

      flash[:success] = "TOTP enabled!"
      redirect_to "/"
    else
      flash[:error] = "Invalid TOTP code!"
      redirect_to "/totp_enroll"
    end
  end
end
