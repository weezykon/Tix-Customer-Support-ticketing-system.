require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password', role: 'customer')
  end

  test "should authenticate with valid credentials" do
    post '/authenticate', params: { email: @user.email, password: 'password' }
    assert_response :success
    assert_not_nil json_response['auth_token']
  end

  test "should not authenticate with invalid credentials" do
    post '/authenticate', params: { email: @user.email, password: 'wrong_password' }
    assert_response :unauthorized
    assert_not_nil json_response['error']
  end

  test "AuthenticateUser service should work" do
    user = User.create(email: 'service_test@example.com', password: 'password', password_confirmation: 'password', role: 'customer')
    command = AuthenticateUser.call(user.email, 'password')
    assert command.success?
    assert_equal user, command.result
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end