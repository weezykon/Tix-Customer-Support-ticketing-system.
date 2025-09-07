module Types
  module Inputs
    class CreateTicketInput < Types::BaseInputObject
      argument :title, String, required: true
      argument :description, String, required: true
      argument :priority, String, required: true
      argument :department, String, required: true
      argument :subject, String, required: true
    end
  end
end