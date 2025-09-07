# frozen_string_literal: true

module Mutations
  # Deletes a ticket.
  class DeleteTicket < BaseMutation
    argument :input, Types::Inputs::DeleteTicketInput, required: true

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      unless context[:current_user].role == 'agent'
        raise GraphQL::ExecutionError,
              'You are not authorized to perform this action.'
      end

      ticket = Ticket.find(input.id)
      if ticket.destroy
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
