# frozen_string_literal: true

class ChangeIndexToArticles < ActiveRecord::Migration[6.0]
  def change
    remove_index :articles, column: %i[user_id created_at]
    add_index :articles, :title
  end
end
