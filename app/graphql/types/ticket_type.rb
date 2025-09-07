# frozen_string_literal: true

module Types
  # GraphQL type for Ticket model.
  class TicketType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :status, String, null: false
    field :priority, String, null: false
    field :department, String, null: false
    field :subject, String, null: false
    field :user, Types::UserType, null: false
    field :assigned_agent, Types::UserType, null: true
    field :comments, [Types::CommentType], null: true
  end
end
