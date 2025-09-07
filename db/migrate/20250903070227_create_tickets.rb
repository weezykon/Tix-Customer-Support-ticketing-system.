# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :status
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
