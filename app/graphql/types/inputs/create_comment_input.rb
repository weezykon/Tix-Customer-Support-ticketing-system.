module Types
  module Inputs
    class CreateCommentInput < Types::BaseInputObject
      argument :ticket_id, ID, required: true
      argument :content, String, required: true
    end
  end
end