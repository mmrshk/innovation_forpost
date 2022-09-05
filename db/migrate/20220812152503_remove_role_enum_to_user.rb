class RemoveRoleEnumToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role, :integer, default: 0
    add_column :users, :role, :string
  end
end
