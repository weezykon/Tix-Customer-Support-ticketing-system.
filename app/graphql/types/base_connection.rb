# frozen_string_literal: true

module Types
  # Base class for GraphQL connections.
  class BaseConnection < GraphQL::Types::Relay::BaseConnection
    edge_type_class(Types::BaseEdge)
    field_class Types::BaseField
  end
end
