module Types
  module Inputs
    class UpdateUserInput < Types::BaseInputObject
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
      argument :role, String, required: false
    end
  end
end