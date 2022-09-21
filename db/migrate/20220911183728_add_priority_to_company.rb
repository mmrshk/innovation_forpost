class AddPriorityToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :priority, :integer, default: 0, null: false
  end
end
