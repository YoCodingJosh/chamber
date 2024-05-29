class LoginRequest
  # this is a "dumb" model, it doesn't have a database table
  # it's just a way to validate the login form

  include ActiveModel::Model

  attr_accessor :username_email, :password

  validates :username_email, presence: true
  validates :password, presence: true
  end
