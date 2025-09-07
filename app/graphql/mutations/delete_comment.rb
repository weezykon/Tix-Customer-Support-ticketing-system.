# frozen_string_literal: true

module Mutations
  # Deletes a comment.
  class DeleteComment < BaseMutation
    argument :input, Types::Inputs::DeleteCommentInput, required: true

    field :comment, Types::CommentType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      comment = Comment.find(input.id)

      if context[:current_user].role == 'customer' && comment.user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to delete this comment.'
      end

      if comment.destroy
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
