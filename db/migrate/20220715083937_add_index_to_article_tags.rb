# frozen_string_literal: true

class AddIndexToArticleTags < ActiveRecord::Migration[6.0]
  def change
    add_index :article_tags, %i[article_id tag_id], unique: true
  end
end
