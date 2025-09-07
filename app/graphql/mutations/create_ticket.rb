# frozen_string_literal: true

module Mutations
  # Creates a new support ticket.
  class CreateTicket < BaseMutation
    argument :input, Types::Inputs::CreateTicketInput, required: true

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(input:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.new(title: input.title, description: input.description, priority: input.priority, department: input.department, subject: input.subject, user: context[:current_user], status: 'open')
      if ticket.save
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
