class AddPriorityToTickets < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :priority, :string
  end
end
