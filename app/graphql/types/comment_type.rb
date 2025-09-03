# frozen_string_literal: true

module Types
  # GraphQL type for Comment model.
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: false
    field :user, Types::UserType, null: false
    field :ticket, Types::TicketType, null: false
  end
end
