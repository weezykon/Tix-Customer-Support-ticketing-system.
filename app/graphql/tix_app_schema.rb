# frozen_string_literal: true

class TixAppSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batching, use the `GraphQL::Batch` gem.
  # For more info, see https://github.com/rmosolgo/graphql-batch
  use GraphQL::Batch

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter

  # Opt in to the new parser (default in future graphql-ruby versions)
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  # Add built-in tracing for performance monitoring
  use GraphQL::Tracing::ActiveSupportTracing

  # Union and Interface Resolution
  def self.resolve_type(_type, obj, _ctx)
    case obj
    when User
      Types::UserType
    when Ticket
      Types::TicketType
    when Comment
      Types::CommentType
    else
      raise(GraphQL::RequiredImplementationMissingError)
    end
  end

  # Relay-style Object Identification: -
  # Return a string UUID for `object`
  def self.id_from_object(object, _type_definition, _query_ctx)
    object.to_gid_param
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, _query_ctx)
    GlobalID::Locator.locate(global_id)
  end
end
