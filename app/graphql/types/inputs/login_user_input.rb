module Types
  module Inputs
    class LoginUserInput < Types::BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end