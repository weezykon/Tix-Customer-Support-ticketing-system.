# frozen_string_literal: true

module Types
  # Base class for GraphQL edges.
  class BaseEdge < GraphQL::Types::Relay::BaseEdge
    node_type_class(Types::NodeType)
  end
end
