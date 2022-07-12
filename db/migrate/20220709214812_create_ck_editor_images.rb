# frozen_string_literal: true

class CreateCkEditorImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ck_editor_images do |t|
      t.string :file
      t.references :article, index: true, foreign_key: true, null: true

      t.timestamps
    end
  end
end
