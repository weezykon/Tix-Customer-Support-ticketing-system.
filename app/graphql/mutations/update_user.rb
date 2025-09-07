# frozen_string_literal: true

module Mutations
  # Updates an existing user.
  class UpdateUser < BaseMutation
    argument :input, Types::Inputs::UpdateUserInput, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      user = User.find(input.id)

      if context[:current_user].role == 'customer' && user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to update this user.'
      end

      if user.update(input.to_h.except(:id))
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
