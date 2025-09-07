# frozen_string_literal: true

module Mutations
  # Updates an existing ticket.
  class UpdateTicket < BaseMutation
    argument :input, Types::Inputs::UpdateTicketInput, required: true

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.find(input.id)

      if context[:current_user].role == 'customer' && ticket.user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to update this ticket.'
      end

      if ticket.update(input.to_h.except(:id))
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
