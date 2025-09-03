# frozen_string_literal: true

require 'jwt'

class JsonWebToken
  # Utility class for encoding and decoding JSON Web Tokens (JWT).
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  raise 'Missing SECRET_KEY environment variable for JWT authentication.' unless SECRET_KEY.present?

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  rescue JWT::DecodeError
    nil
  end
end
