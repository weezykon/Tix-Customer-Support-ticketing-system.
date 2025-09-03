# frozen_string_literal: true

module Mutations
  # Attaches a file to a ticket.
  class AttachFileToTicket < BaseMutation
    argument :ticket_id, ID, required: true
    argument :file, ApolloUploadServer::Upload, required: true

    field :ticket, Types::TicketType, null: false
    field :errors, [String], null: false

    def resolve(ticket_id:, file:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.find(ticket_id)

      # Authorize: Only the ticket owner or an agent can attach files
      if context[:current_user].role == 'customer' && ticket.user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to attach files to this ticket.'
      end

      # Attach the file using Active Storage
      ticket.attachments.attach(file)

      if ticket.save
        { ticket: ticket, errors: [] }
      else
        { ticket: nil, errors: ticket.errors.full_messages }
      end
    end
  end
end
