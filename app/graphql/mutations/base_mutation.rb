# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    # Add arguments and fields that all mutations should have
    # For example, a common error field
    field :errors, [String], null: false

    def resolve(**args)
      # Implement common mutation logic here
      # For example, authentication, authorization, error handling
      # This is a placeholder, actual implementation will vary
      { errors: [] }
    end
  end
end