# frozen_string_literal: true

module Mutations
  # Creates a new user.
  class CreateUser < BaseMutation
    argument :input, Types::Inputs::CreateUserInput, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      user = User.new(name: input.name, email: input.email, password: input.password, role: input.role)
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
