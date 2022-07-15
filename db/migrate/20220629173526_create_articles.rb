# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :text, null: false

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :articles, %i[user_id created_at]
  end
end
