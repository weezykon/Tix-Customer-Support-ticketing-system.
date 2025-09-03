# frozen_string_literal: true

module Types
  # Base class for GraphQL queries.
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :users, [Types::UserType], null: false

    def users
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      User.find(id)
    end

    field :tickets, [Types::TicketType], null: false

    def tickets
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      if context[:current_user].role == 'customer'
        context[:current_user].tickets
      else
        Ticket.all
      end
    end

    field :ticket, Types::TicketType, null: false do
      argument :id, ID, required: true
    end

    def ticket(id:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      ticket = Ticket.find(id)
      if context[:current_user].role == 'customer' && ticket.user != context[:current_user]
        raise GraphQL::ExecutionError, 'You are not authorized to view this ticket.'
      end

      ticket
    end

    field :comments, [Types::CommentType], null: false

    def comments
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      Comment.all
    end

    field :comment, Types::CommentType, null: false do
      argument :id, ID, required: true
    end

    def comment(id:)
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      Comment.find(id)
    end

    field :closed_tickets_csv_url, String, null: true

    def closed_tickets_csv_url
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      unless context[:current_user].role == 'agent'
        raise GraphQL::ExecutionError,
              'You are not authorized to perform this action.'
      end

      # In a real application, you would generate a temporary URL for the CSV file
      # and store it in a cloud storage service (e.g., S3) or serve it directly.
      # For this example, we'll just return a placeholder URL.
      '/export_closed_tickets'
    end

    field :open_tickets_for_agent, [Types::TicketType], null: false

    def open_tickets_for_agent
      raise GraphQL::ExecutionError, 'Authentication required' unless context[:current_user]

      unless context[:current_user].role == 'agent'
        raise GraphQL::ExecutionError,
              'You are not authorized to perform this action.'
      end

      Ticket.where(status: 'open')
    end
  end
end
