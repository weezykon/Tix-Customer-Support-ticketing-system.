# frozen_string_literal: true

module Mutations
  # Updates an existing user.
  class UpdateUser < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :email, String, required: false
    argument :role, String, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      user = User.find(id)

      if context[:current_user].role == 'customer' && user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to update this user.'
      end

      if user.update(attributes)
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
