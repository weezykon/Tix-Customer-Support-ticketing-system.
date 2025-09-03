# frozen_string_literal: true

module Mutations
  # Updates an existing comment.
  class UpdateComment < BaseMutation
    argument :id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: false
    field :errors, [String], null: false

    def resolve(id:, content:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      comment = Comment.find(id)

      if context[:current_user].role == 'customer' && comment.user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to update this comment.'
      end

      if comment.update(content: content)
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
