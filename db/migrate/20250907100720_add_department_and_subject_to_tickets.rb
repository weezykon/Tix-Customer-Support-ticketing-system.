class AddDepartmentAndSubjectToTickets < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :department, :string
    add_column :tickets, :subject, :string
  end
end
