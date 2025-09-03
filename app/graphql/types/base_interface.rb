# frozen_string_literal: true

module Types
  # Base module for GraphQL interfaces.
  module BaseInterface
    include GraphQL::Schema::Interface
    field_class Types::BaseField
  end
end
