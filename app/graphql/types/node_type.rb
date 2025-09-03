# frozen_string_literal: true

module Types
  # Base module for GraphQL nodes.
  module NodeType
    include Types::BaseInterface

    field :id, ID, null: false
  end
end
