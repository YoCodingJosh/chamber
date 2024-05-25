class User < ApplicationRecord
  has_secure_password

  # Validate username
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/, length: { minimum: 3, maximum: 20 } }

  # Validate email
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def confirmation_url
    if confirmation_token.nil?
      return nil
    end

    # TODO: interpolate the host and port
    "/register/confirm/#{id}/#{confirmation_token}"
  end
end
