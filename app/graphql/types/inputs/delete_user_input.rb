module Types
  module Inputs
    class DeleteUserInput < Types::BaseInputObject
      argument :id, ID, required: true
    end
  end
end