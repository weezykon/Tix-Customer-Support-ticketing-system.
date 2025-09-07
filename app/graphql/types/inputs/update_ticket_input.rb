module Types
  module Inputs
    class UpdateTicketInput < Types::BaseInputObject
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :status, String, required: false
      argument :priority, String, required: false
      argument :department, String, required: false
      argument :subject, String, required: false
    end
  end
end