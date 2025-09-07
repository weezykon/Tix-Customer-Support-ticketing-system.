module Types
  module Inputs
    class DeleteTicketInput < Types::BaseInputObject
      argument :id, ID, required: true
    end
  end
end