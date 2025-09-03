# frozen_string_literal: true

module Types
  class BaseScalar < GraphQL::Schema::Scalar
    # Add custom scalars here
    # For example, to handle file uploads:
    # include GraphQL::Types::Relay::Base64
  end
end
