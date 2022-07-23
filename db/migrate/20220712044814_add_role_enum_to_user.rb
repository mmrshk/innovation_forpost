# frozen_string_literal: true

class AddRoleEnumToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role
    add_column :users, :role, :integer, default: 0
  end
end
