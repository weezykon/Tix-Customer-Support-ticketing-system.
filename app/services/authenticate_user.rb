# frozen_string_literal: true

# Authenticates a user and returns a JWT token.
class AuthenticateUser
  prepend SimpleCommand
  include ActiveModel::Model

  def self.human_attribute_name(attr, options = {})
    attr.to_s.humanize
  end

  attr_reader :authenticated_user, :result # Add attr_reader for the authenticated user

  def initialize(email, password)
    super()
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: @email)
    if user&.authenticate(@password)
      @authenticated_user = user # Store the authenticated user
      @result = JsonWebToken.encode(user_id: user.id) # Store the token in @result
    else
      errors.add :user_authentication, 'invalid credentials'
    end
    self # Return self (the command object)
  end
end
