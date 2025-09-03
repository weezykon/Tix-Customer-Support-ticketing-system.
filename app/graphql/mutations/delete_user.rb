# frozen_string_literal: true

module Mutations
  # Deletes a user.
  class DeleteUser < BaseMutation
    argument :id, ID, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(id:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      unless context[:current_user].role == 'agent'
        raise GraphQL::ExecutionError,
              'You are not authorized to perform this action.'
      end

      user = User.find(id)
      if user.destroy
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
