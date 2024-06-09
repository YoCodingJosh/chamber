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
        .as_png(resize_exactly_to: 200)
        .to_data_url
  end
end
