# frozen_string_literal: true

class AddAssignedAgentToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :assigned_agent, foreign_key: { to_table: :users }, type: :uuid
  end
end
