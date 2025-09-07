module Types
  module Inputs
    class AssignTicketInput < Types::BaseInputObject
      argument :ticket_id, ID, required: true
      argument :agent_id, ID, required: true
    end
  end
end