require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "email validation" do
    # Create a new user with an invalid email address
    user = User.new(email: "invalid-email", username: "test", password: "password")

    # Ensure that the user is invalid
    assert_not user.valid?

    # Ensure that the email error is present
    assert_includes user.errors[:email], "Invalid email address!"
  end

  test "username validation" do
    # Create a new user with an invalid username
    user = User.new(email: "example@example.com", username: "????", password: "password")

    # Ensure that the user is invalid
    assert_not user.valid?

    # Ensure that the username error is present
    assert_includes user.errors[:username], "Invalid username!"
  end
end
