class User < ApplicationRecord
  has_secure_password

  # Validate username
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/, message: 'Invalid username!', length: { minimum: 3, maximum: 20, message: 'Incorrect username length!' } }

  # Validate email
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Invalid email address!' }

  # Validate password
  validates :password, presence: true, length: { minimum: 8, message: 'Incorrect password length!' }
end
