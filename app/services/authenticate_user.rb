# frozen_string_literal: true

# Authenticates a user and returns a JWT token.
class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: @email)
    return user if user&.authenticate(@password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
