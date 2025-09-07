# frozen_string_literal: true

module Mutations
  class LoginUser < BaseMutation
    argument :input, Types::Inputs::LoginUserInput, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(input:)
      command = AuthenticateUser.call(input.email, input.password)

      if command.success?
        { token: command.result, user: command.authenticated_user, errors: [] }
      else
        { token: nil, user: nil, errors: command.errors.full_messages }
      end
    end
  end
end
