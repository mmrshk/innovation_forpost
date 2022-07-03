class AddStatusToArticles < ActiveRecord::Migration[6.0]
  def change
    # create_enum "statuses", %w[draft published trashed]
    # add_column :articles, :status, :statuses
    add_column :articles, :status, :integer, default: 0
  end
end
