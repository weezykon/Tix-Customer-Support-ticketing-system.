# frozen_string_literal: true

module Mutations
  # Updates an existing ticket.
  class UpdateTicket < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, String, required: false

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.find(id)

      if context[:current_user].role == 'customer' && ticket.user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to update this ticket.'
      end

      if ticket.update(attributes)
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
