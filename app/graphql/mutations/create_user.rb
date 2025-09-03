# frozen_string_literal: true

module Mutations
  # Creates a new user.
  class CreateUser < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :role, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(name:, email:, role:)
      user = User.new(name: name, email: email, role: role)
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
