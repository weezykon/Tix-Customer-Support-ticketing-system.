module Types
  module Inputs
    class AttachFileToTicketInput < Types::BaseInputObject
      argument :ticket_id, ID, required: true
      argument :file, ApolloUploadServer::Upload, required: true
    end
  end
end