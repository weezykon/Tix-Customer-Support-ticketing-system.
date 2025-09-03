# frozen_string_literal: true

module Types
  # GraphQL type for User model.
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :role, String, null: false
    field :tickets, [Types::TicketType], null: true
    field :comments, [Types::CommentType], null: true
  end
end
