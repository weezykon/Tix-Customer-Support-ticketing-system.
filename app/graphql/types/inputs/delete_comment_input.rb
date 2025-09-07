module Types
  module Inputs
    class DeleteCommentInput < Types::BaseInputObject
      argument :id, ID, required: true
    end
  end
end