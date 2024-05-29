require "test_helper"

class RegisterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/register'
    assert_response :success
  end

  test "should post create" do
    post '/register', params: { user: { email: "coolemail@email.com", password: "password", password_confirmation: "password", username: "coolusername" } }

    # Print the response body for debugging
    puts @response.body

    assert_redirected_to "/login"
  end

  test "should not post create" do
    # TODO: test missing cloudflare token, trying to pass in the 'mocked' token or a real dummy token doesn't work.

    # invalid form fields
    post '/register', params: { user: { email: "", password: "", password_confirmation: "", username: "" } }
    assert_response 400

    # bad email
    post '/register', params: { user: { email: "invalid-email", password: "password", password_confirmation: "password", username: "moo" } }
    assert_response 400

    # mismatched passwords
    post '/register', params: { user: { email: "joshiscool@josh.co", password: "password", password_confirmation: "password1", username: "joshiscool" } }
    assert_response 400
  end
end
