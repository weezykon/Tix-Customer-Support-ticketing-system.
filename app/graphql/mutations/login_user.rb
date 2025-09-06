# frozen_string_literal: true

module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      command = AuthenticateUser.call(email, password)

      if command.success?
        { token: command.result, user: context[:current_user], errors: [] }
      else
        { token: nil, user: nil, errors: command.errors.values.flatten }
      end
    end
  end
end
