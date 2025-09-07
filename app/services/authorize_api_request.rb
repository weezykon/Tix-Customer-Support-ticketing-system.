# frozen_string_literal: true

# Authorizes API requests by validating JWT tokens.
class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
    super()
  end

  def call
    @result = user
    self
  end

  private

  attr_reader :headers

  def user
    user_id = decoded_auth_token[:user_id] if decoded_auth_token
    Rails.logger.debug "User ID from token: #{user_id}"
    @user ||= User.find(user_id) if user_id
    Rails.logger.debug "User found: #{@user.present?}"
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    token = http_auth_header
    Rails.logger.debug "Token extracted: #{token}"
    @decoded_auth_token ||= JsonWebToken.decode(token)
  end

  def http_auth_header
    Rails.logger.debug "Authorization header: #{headers['Authorization']}"
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    errors.add(:token, 'Missing token')
    nil
  end
end
