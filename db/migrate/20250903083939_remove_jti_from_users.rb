# frozen_string_literal: true

class RemoveJtiFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :jti
    remove_column :users, :jti, :string
  end
end
