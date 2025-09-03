# frozen_string_literal: true

module Types
  # Base class for GraphQL mutations.
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :delete_user, mutation: Mutations::DeleteUser

    field :create_ticket, mutation: Mutations::CreateTicket
    field :update_ticket, mutation: Mutations::UpdateTicket
    field :delete_ticket, mutation: Mutations::DeleteTicket

    field :create_comment, mutation: Mutations::CreateComment
    field :update_comment, mutation: Mutations::UpdateComment
    field :delete_comment, mutation: Mutations::DeleteComment

    field :attach_file_to_ticket, mutation: Mutations::AttachFileToTicket
    field :assign_ticket, mutation: Mutations::AssignTicket
  end
end
