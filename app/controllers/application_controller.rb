# frozen_string_literal: true

# Base controller for the application.
class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    command = AuthorizeApiRequest.call(request.headers)
    if command.success?
      @current_user = command.result
    else
      render json: { error: command.errors }, status: 401
    end
  end
end
