# frozen_string_literal: true

module Mutations
  # Creates a new support ticket.
  class CreateTicket < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :priority, String, required: true

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(title:, description:, priority:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.new(title: title, description: description, priority: priority, user: context[:current_user], status: 'open')
      if ticket.save
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
