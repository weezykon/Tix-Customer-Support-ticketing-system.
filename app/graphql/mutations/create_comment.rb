# frozen_string_literal: true

module Mutations
  # Creates a new comment on a ticket.
  class CreateComment < BaseMutation
    argument :content, String, required: true
    argument :ticket_id, ID, required: true

    field :comment, Types::CommentType, null: false
    field :errors, [String], null: false

    def resolve(content:, ticket_id:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.find(ticket_id)

      if context[:current_user].role == 'customer' && !ticket.comments.where(user: User.where(role: 'agent')).exists?
        raise GraphQL::ExecutionError, 'You can only comment after an agent has commented on this ticket.'
      end

      comment = Comment.new(content: content, ticket: ticket, user: context[:current_user])
      if comment.save
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
