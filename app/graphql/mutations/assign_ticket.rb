# frozen_string_literal: true

module Mutations
  # Assigns a ticket to an agent.
  class AssignTicket < BaseMutation
    argument :input, Types::Inputs::AssignTicketInput, required: true

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      unless context[:current_user].role == 'agent'
        raise GraphQL::ExecutionError,
              'You are not authorized to perform this action.'
      end

      ticket = Ticket.find(input.ticket_id)
      agent = User.find(input.agent_id)

      raise GraphQL::ExecutionError, 'User is not an agent.' unless agent.role == 'agent'

      if ticket.update(assigned_agent: agent)
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
