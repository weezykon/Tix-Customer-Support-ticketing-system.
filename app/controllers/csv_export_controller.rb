# frozen_string_literal: true

# Handles CSV export of closed tickets.
class CsvExportController < ApplicationController
  before_action :authenticate_request

  def export_closed_tickets
    unless @current_user.role == 'agent'
      render json: { error: 'Not Authorized' }, status: 401
      return
    end

    tickets = Ticket.where(status: 'closed').where('updated_at >= ?', 1.month.ago)

    respond_to do |format|
      format.csv { send_data tickets.to_csv, filename: "closed-tickets-#{Date.today}.csv" }
    end
  end
end
